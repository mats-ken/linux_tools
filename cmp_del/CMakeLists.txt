cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_FLAGS "-Wall")

set(CMAKE_CXX_FLAGS "-DCOMPARE_MTIME=0")
add_executable(cmp_del cmp_del.cpp)

#set(CMAKE_CXX_FLAGS "-DCOMPARE_MTIME=1")
#add_executable(cmp_del_mtime cmp_del.cpp)
