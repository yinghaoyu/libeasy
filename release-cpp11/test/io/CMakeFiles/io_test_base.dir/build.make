# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /mnt/g/easy

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /mnt/g/easy/release-cpp11

# Include any dependencies generated for this target.
include test/io/CMakeFiles/io_test_base.dir/depend.make

# Include the progress variables for this target.
include test/io/CMakeFiles/io_test_base.dir/progress.make

# Include the compile flags for this target's objects.
include test/io/CMakeFiles/io_test_base.dir/flags.make

test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.o: ../test/io/easy_baseth_pool_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.o   -c /mnt/g/easy/test/io/easy_baseth_pool_test.c

test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_baseth_pool_test.c > CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_baseth_pool_test.c -o CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.o: ../test/io/easy_client_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_client_test.c.o   -c /mnt/g/easy/test/io/easy_client_test.c

test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_client_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_client_test.c > CMakeFiles/io_test_base.dir/easy_client_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_client_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_client_test.c -o CMakeFiles/io_test_base.dir/easy_client_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.o: ../test/io/easy_connection_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_connection_test.c.o   -c /mnt/g/easy/test/io/easy_connection_test.c

test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_connection_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_connection_test.c > CMakeFiles/io_test_base.dir/easy_connection_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_connection_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_connection_test.c -o CMakeFiles/io_test_base.dir/easy_connection_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.o: ../test/io/easy_file_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_file_test.c.o   -c /mnt/g/easy/test/io/easy_file_test.c

test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_file_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_file_test.c > CMakeFiles/io_test_base.dir/easy_file_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_file_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_file_test.c -o CMakeFiles/io_test_base.dir/easy_file_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.o: ../test/io/easy_io_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_io_test.c.o   -c /mnt/g/easy/test/io/easy_io_test.c

test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_io_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_io_test.c > CMakeFiles/io_test_base.dir/easy_io_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_io_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_io_test.c -o CMakeFiles/io_test_base.dir/easy_io_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.o: ../test/io/easy_log_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_log_test.c.o   -c /mnt/g/easy/test/io/easy_log_test.c

test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_log_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_log_test.c > CMakeFiles/io_test_base.dir/easy_log_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_log_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_log_test.c -o CMakeFiles/io_test_base.dir/easy_log_test.c.s

test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.o: test/io/CMakeFiles/io_test_base.dir/flags.make
test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.o: ../test/io/easy_request_test.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/mnt/g/easy/release-cpp11/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.o"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/io_test_base.dir/easy_request_test.c.o   -c /mnt/g/easy/test/io/easy_request_test.c

test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/io_test_base.dir/easy_request_test.c.i"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /mnt/g/easy/test/io/easy_request_test.c > CMakeFiles/io_test_base.dir/easy_request_test.c.i

test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/io_test_base.dir/easy_request_test.c.s"
	cd /mnt/g/easy/release-cpp11/test/io && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /mnt/g/easy/test/io/easy_request_test.c -o CMakeFiles/io_test_base.dir/easy_request_test.c.s

io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_baseth_pool_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_client_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_connection_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_file_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_io_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_log_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/easy_request_test.c.o
io_test_base: test/io/CMakeFiles/io_test_base.dir/build.make

.PHONY : io_test_base

# Rule to build all files generated by this target.
test/io/CMakeFiles/io_test_base.dir/build: io_test_base

.PHONY : test/io/CMakeFiles/io_test_base.dir/build

test/io/CMakeFiles/io_test_base.dir/clean:
	cd /mnt/g/easy/release-cpp11/test/io && $(CMAKE_COMMAND) -P CMakeFiles/io_test_base.dir/cmake_clean.cmake
.PHONY : test/io/CMakeFiles/io_test_base.dir/clean

test/io/CMakeFiles/io_test_base.dir/depend:
	cd /mnt/g/easy/release-cpp11 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /mnt/g/easy /mnt/g/easy/test/io /mnt/g/easy/release-cpp11 /mnt/g/easy/release-cpp11/test/io /mnt/g/easy/release-cpp11/test/io/CMakeFiles/io_test_base.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/io/CMakeFiles/io_test_base.dir/depend
