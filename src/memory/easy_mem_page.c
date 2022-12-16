/**
 * Copyright (c) 2021 OceanBase
 * OceanBase CE is licensed under Mulan PubL v2.
 * You can use this software according to the terms and conditions of the Mulan PubL v2.
 * You may obtain a copy of Mulan PubL v2 at:
 *          http://license.coscl.org.cn/MulanPubL-2.0
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
 * EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
 * MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 * See the Mulan PubL v2 for more details.
 */

#include "memory/easy_mem_page.h"
#include <malloc.h>

static easy_mem_page_t *easy_mem_rmqueue(easy_mem_zone_t *zone, uint32_t order);
static void easy_mem_expand(easy_mem_zone_t *zone, easy_mem_page_t *page,
                            int low, int high, easy_mem_area_t *area);
static void easy_mem_merge_buddy_page(easy_mem_zone_t *zone, easy_mem_page_t *page, uint32_t order);

static inline easy_mem_page_t *easy_mem_page_ptr(easy_mem_page_t *page, int index);
static inline easy_mem_page_t *easy_mem_index_to_page(easy_mem_zone_t *zone, int index);
static inline int easy_mem_page_to_index(easy_mem_zone_t *zone, easy_mem_page_t *page);
static inline int easy_mem_find_buddy_index(int page_idx, uint32_t order);
static inline int easy_mem_find_combined_index(int page_idx, uint32_t order);
static inline void easy_mem_set_page_free(easy_mem_zone_t *zone, easy_mem_page_t *page, int order);
static inline void easy_mem_set_page_used(easy_mem_zone_t *zone, easy_mem_page_t *page, int order);

// 内存初始化, 最大每zone 2G
easy_mem_zone_t *easy_mem_zone_create(int64_t max_size)
{
    easy_mem_zone_t         *zone;
    unsigned char           *memptr;
    int64_t                 size;
    uint32_t                n;
    int                     page_size, pos, order, asize;

    // min = 128k
    order = 0;
    size = EASY_MEM_PAGE_SIZE;

    while (size < max_size) {
        // max_size > 1 page(64k)，让 size 按 2 4 8 ... 的倍数增长
        size <<= 1;
        order ++;
    }
    // 描述整个zone需要的信息 = sizeof(描述zone的结构体) + sizeof(柔性数组)
    // 由于每个page需要1个字节的page_flags来描述
    // 因此柔性数组的长度为size / EASY_MEM_PAGE_SIZE
    pos = (size / EASY_MEM_PAGE_SIZE) + sizeof(easy_mem_zone_t);
    // 对齐到 page
    page_size = easy_align(pos, EASY_MEM_PAGE_SIZE);
    // 最大页大小
    asize = (1 << (EASY_MEM_MAX_ORDER + EASY_MEM_PAGE_SHIFT - 1));
    // 保证 asize 至少能存下描述整个zone的结构信息
    asize = easy_max(page_size, easy_min(asize, size));

    // alloc memory
    // memptr 按 page 对齐
    if ((memptr = (unsigned char *)memalign(EASY_MEM_PAGE_SIZE, asize + size)) == NULL) {
        return NULL;
    }

    // init
    zone = (easy_mem_zone_t *)memptr;
    memset(zone, 0, sizeof(easy_mem_zone_t));
    zone->curr = memptr + easy_align(pos, 32);
    zone->curr_end = memptr + page_size;

    zone->max_order = ((order >= EASY_MEM_MAX_ORDER) ? (EASY_MEM_MAX_ORDER - 1) : order);
    zone->mem_start = (unsigned char *)easy_align((unsigned long)zone->curr_end, asize);
    zone->mem_last = zone->mem_start;
    zone->mem_end = zone->mem_start + size;

    for (n = 0; n <= zone->max_order; n++) {
        // 初始时，每个mem_area的环形链表都指向自己
        easy_list_init(&zone->area[n].free_list);
    }

    return zone;
}

// 内存释放
void easy_mem_zone_destroy(easy_mem_zone_t *zone)
{
    easy_free(zone);
}

// 内存分配
easy_mem_page_t *easy_mem_alloc_pages(easy_mem_zone_t *zone, uint32_t order)
{
    easy_mem_page_t         *page;
    easy_mem_area_t         *area;

    // mem_zone 最大的 mem_page 有 1<<max_order 个 page
    if (order > zone->max_order)
        return NULL;

    // 有空的page直接分配
    if (zone->free_pages >= (1 << order))
        if ((page = easy_mem_rmqueue(zone, order)) != NULL)
            return page;

    // 尾部有空闲mem_area层
    if (zone->mem_last < zone->mem_end) {
        page = (easy_mem_page_t *) zone->mem_last;
        // mem_last往后移动这一层的大小
        zone->mem_last += ((1 << zone->max_order) << EASY_MEM_PAGE_SHIFT);
        // 加上这一层的page数量
        zone->free_pages += (1 << zone->max_order);
        area = zone->area + zone->max_order;
        // 把空闲page用头插法插入到最后一层mem_area
        easy_list_add_head(&page->lru, &area->free_list);
        area->nr_free ++;

        return easy_mem_rmqueue(zone, order);
    }

    return NULL;
}

// 内存释放
void easy_mem_free_pages(easy_mem_zone_t *zone, easy_mem_page_t *page)
{
    unsigned long           page_idx;
    unsigned char           *ptr = (unsigned char *) page;

    if (ptr < zone->mem_start || ptr > (zone->mem_last - EASY_MEM_PAGE_SIZE))
        return;

    // page index
    page_idx = easy_mem_page_to_index(zone, page);

    if ((zone->page_flags[page_idx] & 0x80)) {
        // page被标记为已分配
        easy_mem_merge_buddy_page(zone, page, (zone->page_flags[page_idx] & 0x0f));
    }
}

static easy_mem_page_t *easy_mem_rmqueue(easy_mem_zone_t *zone, uint32_t order)
{
    easy_mem_area_t         *area;
    uint32_t                n;
    easy_mem_page_t         *page;

    for (n = order; n <= zone->max_order; n++) {
        // mem_zone的第n层mem_area
        area = zone->area + n;

        if (easy_list_empty(&area->free_list))
            continue;  // 第n层的mem_area没有空闲page
        // 第n层mem_area的第1个page
        page = easy_list_entry(area->free_list.next, easy_mem_page_t, lru);
        // 独立page链表
        easy_list_del(&page->lru);
        area->nr_free--;
        // 分配需消耗第n层mem_area的 1<<order 个page，因此要减去
        zone->free_pages -= (1 << order);
        // 把第n层mem_area剩余的page合并到第 n-1 n-2 ... order层
        easy_mem_expand(zone, page, order, n, area);
        // 把第n层mem_area的上半区page标记为已分配
        easy_mem_set_page_used(zone, page, order);
        return page;
    }

    return NULL;
}

static void easy_mem_expand(easy_mem_zone_t *zone, easy_mem_page_t *page,
                            int low, int high, easy_mem_area_t *area)
{
    easy_mem_page_t         *newpage;
    unsigned long           size = 1 << high;
    // 将页框块分为2个256个页框的块
    // 一个分配给应用，另外一个移到256个页框的链表中
    while (high > low) {
        area--;
        high--;
        size >>= 1;
        // 从第higt层的mem_area拆分包含size个page的newpage
        // newpage位于page的下半区，上半区用来分配
        newpage = easy_mem_page_ptr(page, size);
        // 把newpage加到层数更小的mem_area的表头
        easy_list_add_head(&newpage->lru, &area->free_list);
        area->nr_free ++;
        // newpage标记为层数更小的mem_area管理
        easy_mem_set_page_free(zone, newpage, high);
    }
}

static void easy_mem_merge_buddy_page(easy_mem_zone_t *zone, easy_mem_page_t *page, uint32_t order)
{
    int                     page_idx, buddy_idx, combined_idx, order_size;
    easy_mem_page_t         *buddy;

    order_size = 1 << order;
    page_idx = easy_mem_page_to_index(zone, page);
    zone->free_pages += order_size;
    // 释放128k的块，查询伙伴块，假设存在则合并成256k的块
    // 再查询256k的伙伴块，假设存在则合并成512k的块
    // ...
    // 层层查询，直到最后一层
    while (order < zone->max_order) {
        // 寻找伙伴块索引
        buddy_idx = easy_mem_find_buddy_index(page_idx, order);
        // 伙伴块必须和待释放的块同层
        if (zone->page_flags[buddy_idx] != order)
            break;
        // 找出伙伴页
        buddy = easy_mem_index_to_page(zone, buddy_idx);
        // 独立伙伴页的链表
        easy_list_del(&buddy->lru);
        zone->area[order].nr_free --;
        zone->page_flags[buddy_idx] = 0;
        // 寻找合并块索引
        combined_idx = easy_mem_find_combined_index(page_idx, order);
        page = easy_mem_index_to_page(zone, combined_idx);
        page_idx = combined_idx;
        order ++;
    }
    // 把待释放的page置成空闲
    easy_mem_set_page_free(zone, page, order);
    // 把空闲page加入这层的mem_area
    easy_list_add_head(&page->lru, &zone->area[order].free_list);
    zone->area[order].nr_free ++;
}

// inline function
static inline easy_mem_page_t *easy_mem_page_ptr(easy_mem_page_t *page, int index)
{
    return (easy_mem_page_t *)(((unsigned char *)page) + index * EASY_MEM_PAGE_SIZE);
}

static inline int easy_mem_page_to_index(easy_mem_zone_t *zone, easy_mem_page_t *page)
{
    return (((unsigned char *)page) - zone->mem_start) >> EASY_MEM_PAGE_SHIFT;
}

static inline easy_mem_page_t *easy_mem_index_to_page(easy_mem_zone_t *zone, int index)
{
    return (easy_mem_page_t *)(zone->mem_start + (index << EASY_MEM_PAGE_SHIFT));
}

static inline int easy_mem_find_buddy_index(int page_idx, uint32_t order)
{
    return page_idx ^ (1 << order);
}

static inline int easy_mem_find_combined_index(int page_idx, uint32_t order)
{
    return (page_idx & ~(1 << order));
}

static inline void easy_mem_set_page_free(easy_mem_zone_t *zone, easy_mem_page_t *page, int order)
{
    unsigned long           page_idx;

    page_idx = (((unsigned char *)page) - zone->mem_start) >> EASY_MEM_PAGE_SHIFT;
    zone->page_flags[page_idx] = (0x0f & order);
}

static inline void easy_mem_set_page_used(easy_mem_zone_t *zone, easy_mem_page_t *page, int order)
{
    unsigned long           page_idx;

    page_idx = (((unsigned char *)page) - zone->mem_start) >> EASY_MEM_PAGE_SHIFT;
    zone->page_flags[page_idx] = (0x80 | order);
}
