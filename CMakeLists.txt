cmake_minimum_required(VERSION 3.21)
project(P2PRoom)

# Find the required Qt modules
find_package(Qt5 COMPONENTS Core Quick Qml REQUIRED)

# Add source files from src directory
file(GLOB SOURCES "src/*.cpp")

# Add resource files
qt5_add_resources(QML_RESOURCES view/resources.qrc)

# Add the main application executable
add_executable(main ${SOURCES} ${QML_RESOURCES} src/main.cpp)

# Link against the required Qt libraries
target_link_libraries(main PRIVATE Qt5::Core Qt5::Quick Qt5::Qml)

# Google Test setup
enable_testing()
include(GoogleTest)
add_executable(test ${TEST_SOURCES})
target_sources(test PRIVATE ${SOURCES} ${TEST_SOURCES})
target_link_libraries(test PRIVATE Qt5::Core Qt5::Quick Qt5::Qml gtest_main)
gtest_discover_tests(test)

# Specify include directories for targets
target_include_directories(main PRIVATE include)
target_include_directories(test PRIVATE include)

# Optionally, set the output directories for executables
set_target_properties(main test PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)
