cmake_minimum_required(VERSION 3.10)
project(proj_kinect)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(${PROJECT_SOURCE_DIR}/include)

set(OpenCV_DIR ${PROJECT_SOURCE_DIR}/third_party/opencv/build)
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

set(freenect2_DIR ${PROJECT_SOURCE_DIR}/third_party/libfreenect2/build)
find_package(freenect2 REQUIRED)
INCLUDE_DIRECTORIES(${freenect2_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${freenect2_DIR})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")
file(GLOB SOURCES "src/*.cpp")

add_executable(proj_kinect ${SOURCES})
target_link_libraries(proj_kinect ${freenect2_DIR}/lib/libfreenect2.so)
target_link_libraries(proj_kinect ${OpenCV_DIR}/lib/libopencv_core.so)
target_link_libraries(proj_kinect ${OpenCV_DIR}/lib/libopencv_highgui.so)
target_link_libraries(proj_kinect ${OpenCV_DIR}/lib/libopencv_imgproc.so)
