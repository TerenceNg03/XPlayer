# Syntax for this file: https://cmake.org/cmake/help/v2.8.12/cmake.html
# Reference manual: http://doc.qt.io/qt-5/cmake-manual.html

cmake_minimum_required(VERSION 2.8.12)
# 2.8.11 is required for automatic linking to the qtmain.lib library on Windows

project(qt5-ui CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc/resource/ui automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if (APPLE)
    set(CMAKE_MACOSX_RPATH ON)
endif (APPLE)

# Find the QtWidgets library
find_package(Qt5Widgets REQUIRED)
find_package(Qt5 COMPONENTS Core Widgets Multimedia MultimediaWidgets REQUIRED)

 
include_directories(${Qt5MultimediaWidgets_INCLUDE_DIRS})

# Tell CMake to create the example-project executable
add_executable(${CMAKE_PROJECT_NAME}-exe WIN32
    src/lib.cpp
    src/mainwindow.cpp
    resources/resources.qrc)

add_library(${CMAKE_PROJECT_NAME} SHARED
    src/lib.cpp
    src/mainwindow.cpp
    resources/resources.qrc)

# Use the Widgets module from Qt 5.
target_link_libraries(${CMAKE_PROJECT_NAME} Qt5::Widgets Qt5::Multimedia Qt5::MultimediaWidgets)
target_link_libraries(${CMAKE_PROJECT_NAME}-exe Qt5::Widgets Qt5::Multimedia Qt5::MultimediaWidgets)
