cmake_minimum_required(VERSION 3.0)
project(easy
  VERSION 1.1.22
  LANGUAGES C CXX)

add_library(easy_base INTERFACE)

set(INNER_INCLUDE_DIRS
  ${CMAKE_CURRENT_SOURCE_DIR}/src/include
  ${CMAKE_CURRENT_SOURCE_DIR}/src/
)

set_property(GLOBAL PROPERTY EASY_INCLUDE_DIRS
  ${INNER_INCLUDE_DIRS}
)

target_include_directories(
  easy_base INTERFACE
  ${INNER_INCLUDE_DIRS}
)


set(CXX_FLAGS
  -ggdb # gdb 调试选项
  -Wall # warn all意为显示所有警告
  -Wextra # 增加-Wall未包含的选项，具体见gcc手册
  -Werror # warn error 意为把警告当错误处理
  -Wconversion # 警告可能改变值的隐式转换
  -Wno-unused-parameter # 忽略函数定义有未使用的参数
  -Wold-style-cast # 如果使用旧样式（C 样式）强制转换为非void类型，则发出警告
  -Woverloaded-virtual # 如果基类函数被子类函数隐藏，就引发编译错误，注意覆盖、隐藏、重载区别
  -Wshadow # 当一个局部变量遮盖了另一个局部变量，或者全局变量，则发出警告
  -Wpointer-arith # 对函数指针或者void *类型的指针进行算术操作时给出警告，如sizeof(void*)
  -Wwrite-strings # 把常量字符串的地址给一个可变指针时，则发出警告，如char* str = "abc"
  -std=c++11 # 指定语言标准为c++11
  -march=native # 编译代码的cpu和运行bin的cpu不匹配，使bin不能运行
  )

target_compile_options(easy_base
  INTERFACE
  -D_GLIBCXX_USE_CXX11_ABI=0 -D_GNU_SOURCE -D__STDC_LIMIT_MACROS
)

target_link_libraries(easy_base
  INTERFACE
  -lpthread -lm -l:libssl.a -l:libcrypto.a
  ${CMAKE_DL_LIBS}
)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin) # 指定bin路径
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib) # 指定lib路径

target_compile_features(easy_base INTERFACE cxx_std_11)

add_subdirectory(src)
add_subdirectory(test)
#add_subdirectory(test EXCLUDE_FROM_ALL)
