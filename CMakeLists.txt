cmake_minimum_required(VERSION 3.1)

project(dxEffects2glEffects)
if(WIN32)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /D\"_HAS_ITERATOR_DEBUGGING=0\" /D\"_SECURE_SCL=0\" /D\"_CRT_SECURE_NO_WARNINGS\"")
endif(WIN32)
add_subdirectory(External)
add_subdirectory(Common)
add_subdirectory(Platform)