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

#ifndef EASY_MEM_PAGE_H_
#define EASY_MEM_PAGE_H_

#include "easy_define.h"
#include <easy_list.h>
#include <easy_atomic.h>

/**
 * Buddy内存分配器
 */
//       ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ↑
//       ↓   mem_area                              ↑
//       ↓ →   0      → page → page → ... → page → →  2^0 pages
//             1      → page → page → ... → page      2^1 pages
//             2      → page → page → ... → page      2^2 pages
//             3      → page → page → ... → page      2^3 pages
//             4      → page → page → ... → page      2^4 pages
//             5      → page → page → ... → page      2^5 pages
//             6      → page → page → ... → page      2^6 pages
//             7      → page → page → ... → page      2^7 pages
//             8      → page → page → ... → page      2^8 pages
//             9      → page → page → ... → page      2^9 pages
//             10     → page → page → ... → page      2^10 pages
//             11     → page → page → ... → page      2^11 pages
// MAX_ORDER   12     → page → page → ... → page      2^12 pages
// Buddy算法运用了任何正整数都可以由2^n的和组成
EASY_CPP_START

#define EASY_MEM_PAGE_SHIFT     16
#define EASY_MEM_PAGE_SIZE      (1<<EASY_MEM_PAGE_SHIFT)        // 64K
#define EASY_MEM_MAX_ORDER      12                              // 最大页大小: 128M

typedef struct easy_mem_page_t easy_mem_page_t;
typedef struct easy_mem_area_t easy_mem_area_t;
typedef struct easy_mem_zone_t easy_mem_zone_t;

struct easy_mem_page_t {
    easy_list_t             lru;
};

struct easy_mem_area_t {
    easy_list_t             free_list;
    int                     nr_free;
};

struct easy_mem_zone_t {
    unsigned char           *mem_start, *mem_last, *mem_end;
    easy_mem_area_t         area[EASY_MEM_MAX_ORDER];         // 空闲块区域
    uint32_t                max_order;                        // mem_area最大层数
    int                     free_pages;                       // 全局空闲page数
    unsigned char           *curr, *curr_end;
    // 柔性数组，每个page用 8 bits
    // 高 4 bits 标记分配状态，1000 表示已分配，0000 表示未分配
    // 低 4 bits 标记当前所属的mem_area层order
    unsigned char           page_flags[0];
};

// 内存创建
easy_mem_zone_t *easy_mem_zone_create(int64_t max_size);
// 内存释放
void easy_mem_zone_destroy(easy_mem_zone_t *zone);
// 内存分配
easy_mem_page_t *easy_mem_alloc_pages(easy_mem_zone_t *zone, uint32_t order);
// 内存释放
void easy_mem_free_pages(easy_mem_zone_t *zone, easy_mem_page_t *page);

EASY_CPP_END

#endif
