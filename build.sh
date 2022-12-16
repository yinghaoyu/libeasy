#!/bin/bash

# 执行时显示指令及参数
set -x

SOURCE_DIR=`pwd`
# ${VAR:-string} 如果 VAR 变量为空则返回 string
# ${VAR:+string} 如果 VAR 变量不为空则返回 string
# ${VAR:=string} 如果 VAR 变量为空则重新赋值 VAR 变量值为 string
# ${VAR:?string} 如果 VAR 变量为空则将 string 输出到 stderr
BUILD_DIR=${SOURCE_DIR:-/build}
BUILD_TYPE=${BUILD_TYPE:-release}
CXX={CXX:-g++}

# for clang-tidy
ln -sf $BUILD_DIR/$BUILD_TYPE/compile_commands.json

# DCMAKE_EXPORT_COMPILE_COMMANDS=ON开启后，其生成的文件compile_commands.json，包含所有编译单元所执行的指令

mkdir -p $BUILD_DIR/$BUILD_TYPE \
  && cd $BUILD_DIR/$BUILD_TYPE \
  && cmake \
           -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
           -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
           -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
           $SOURCE_DIR \
  && make $*
