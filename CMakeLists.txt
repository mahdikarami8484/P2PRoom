cmake_minimum_required(VERSION 3.21)
project(P2PRoom)

message("QML module path: ${Qt5Qml_DIR}")

# Find the required Qt modules
find_package(Qt5 COMPONENTS Core Quick REQUIRED Qml)

if(NOT Qt5_FOUND)
    message(FATAL_ERROR "Qt5 not found. Please check your Qt5 installation.")
endif()

# Add source files from src directory
file(GLOB SOURCES "src/*.cpp")

# Add resource files
qt5_add_resources(QML_RESOURCES view/resources.qrc)

# Add the main application executable
add_executable(main ${SOURCES} ${QML_RESOURCES} src/main.cpp)

# Google Test setup
include_directories(${CMAKE_SOURCE_DIR}/lib/gtest/include)
file(GLOB TEST_SOURCES "test/*.cpp" "test/main_test.cpp")
list(APPEND TEST_SOURCES ${SOURCES})
list(FILTER TEST_SOURCES EXCLUDE REGEX ".*main.cpp$")
add_executable(test ${TEST_SOURCES})
target_link_libraries(test debug ${CMAKE_SOURCE_DIR}/lib/gtest/lib/libgtestd.a optimized ${CMAKE_SOURCE_DIR}/lib/gtest/lib/libgtest.a)
target_link_libraries(test debug ${CMAKE_SOURCE_DIR}/lib/gtest/lib/libgtest_maind.a optimized ${CMAKE_SOURCE_DIR}/lib/gtest/lib/libgtest_main.a)

# Link against the required Qt libraries
target_link_libraries(main Qt5::Core Qt5::Quick)

# Specify include directories for targets
target_include_directories(main PRIVATE include)
target_include_directories(test PRIVATE include)

# Optionally, set the output directories for executables
set_target_properties(main test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)
