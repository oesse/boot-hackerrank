cmake_minimum_required(VERSION 3.10)
project(boot-hackerrank)

option(ENABLE_CPPCHECK "Enable static analysis with cppcheck" FALSE)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# === targets ===

add_library(Solution INTERFACE)
target_include_directories(Solution INTERFACE src)

add_executable(SolutionRunner src/main.cpp)
target_link_libraries(SolutionRunner PRIVATE Solution)

include(Testing)
include(CppCheck)

AddUnitTests(Solution
  DIRECTORY test/unit
  TEST_CASES
  solution_test.cpp
  )


AddIoTests(SolutionRunner
  DIRECTORY test/io
  TEST_CASES
  basic_solution.io
  )
