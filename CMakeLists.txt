cmake_minimum_required(VERSION 3.10)
project(P2PRoom)

# Add source files from src directory
file(GLOB SOURCES "src/*.cpp")

# Add include directories
include_directories(include)

# Add the main application executable
add_executable(main ${SOURCES} src/main.cpp)

# Google Test setup
set(GTEST_LIBRARY_DIR ${CMAKE_SOURCE_DIR}/lib/gtest/lib)
include_directories(${CMAKE_SOURCE_DIR}/lib/gtest/include)

# Add test files from test directory (excluding main.cpp)
file(GLOB TEST_SOURCES "test/*.cpp" "test/main_test.cpp")

# Append TEST_SOURCES and SOURCES
list(APPEND TEST_SOURCES ${SOURCES})

# Remove src/main.cpp form TEST_SOURCES
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*main.cpp$")

# Add the test executable
add_executable(test ${TEST_SOURCES})

# Link against Google Test libraries
target_link_libraries(test debug ${GTEST_LIBRARY_DIR}/libgtestd.a optimized ${GTEST_LIBRARY_DIR}/libgtest.a)
target_link_libraries(test debug ${GTEST_LIBRARY_DIR}/libgtest_maind.a optimized ${GTEST_LIBRARY_DIR}/libgtest_main.a)

# Optionally, set the output directories for executables
set_target_properties(main test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)
