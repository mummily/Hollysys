# CMakeList.txt: 平台CMake项目文件，在此处执行全局配置并包含子项目。
cmake_minimum_required (VERSION 3.8)

set(APP_NAME Platform)
project (${APP_NAME})

# 设置C++标准为 C++ 17
set(CMAKE_CXX_STANDARD 17)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

set(LIBRARY_SUFFIX .so)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(RUNTIME_PATH ${PROJECT_SOURCE_DIR}/00_Bin/Debug/)
else()
    set(RUNTIME_PATH ${PROJECT_SOURCE_DIR}/00_Bin/Release/)
endif() 

# QT
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Svg REQUIRED)
find_package(Qt5Xml REQUIRED)
find_package(Qt5Network REQUIRED)
find_package(Qt5Multimedia REQUIRED)
find_package(Qt5Concurrent REQUIRED)

# 设置Output路径
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/00_Bin/Debug/) 
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/00_Bin/Release/) 
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/00_Bin/Debug/)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/00_Bin/Release/)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${PROJECT_SOURCE_DIR}/00_Bin/Debug/)    
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${PROJECT_SOURCE_DIR}/00_Bin/Release/)

# 包含子项目。
add_subdirectory ("01_DBService/01_Build/Linux/")#已通过
add_subdirectory("02_Base/01_Build/Linux/")#已通过
add_subdirectory("03_Memory/01_Build/Linux/")#已通过
add_subdirectory("04_Var/01_Build/Linux/")#已通过
#add_subdirectory("05_IEC/01_Build/Linux/")#已通过
add_subdirectory("06_HW/01_Build/Linux/GeneralBase/")#已通过
add_subdirectory("06_HW/01_Build/Linux/GeneralLogic/")#已通过
add_subdirectory("07_Library/01_Build/Linux/")#已通过
add_subdirectory("08_Project/01_Build/Linux/")#已通过
#add_subdirectory("09_Task/01_Build/Linux/")#已通过
#add_subdirectory("10_Compile/01_Build/Linux/")#已通过
#add_subdirectory("11_Online/01_Build/Linux/")#已通过
add_subdirectory("12_ProductAdapter/01_Build/Linux/")#已通过
add_subdirectory("13_ControllerAdapter/01_Build/Linux/")#已通过
#add_subdirectory("14_PinDetailEx/01_Build/Linux/")
#add_subdirectory("15_ImpExpLib/01_Build/Linux/")#已通过
