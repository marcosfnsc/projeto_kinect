cmake_minimum_required(VERSION 3.10)
project(proj_kinect)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(${PROJECT_SOURCE_DIR}/include)

#set(libfreenect_DIR ${PROJECT_SOURCE_DIR}/third_party/libfreenect)
#find_package(libfreenect REQUIRED)

set(freenect2_DIR ${PROJECT_SOURCE_DIR}/third_party/libfreenect2/build)
find_package(freenect2 REQUIRED)
INCLUDE_DIRECTORIES(${freenect2_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/third_party/libfreenect2/build)

set(OpenCV_DIR ${PROJECT_SOURCE_DIR}/third_party/opencv/build)
find_package(OpenCV REQUIRED)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
file(GLOB SOURCES "src/*.cpp")

add_executable(proj_kinect ${SOURCES})
target_link_libraries(proj_kinect ${PROJECT_SOURCE_DIR}/third_party/libfreenect2/build/lib/libfreenect2.so)
