# Note: CMake support is community-based. The maintainers do not use CMake
# internally.

cmake_minimum_required(VERSION 2.8.12)

if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

if (POLICY CMP0057)
  cmake_policy(SET CMP0057 NEW)
endif (POLICY CMP0057)

project(googletest-distribution)
set(GOOGLETEST_VERSION 1.11.0)

if (CMAKE_VERSION VERSION_GREATER "3.0.2")
  if(NOT CYGWIN AND NOT MSYS AND NOT ${CMAKE_SYSTEM_NAME} STREQUAL QNX)
    set(CMAKE_CXX_EXTENSIONS OFF)
  endif()
endif()

enable_testing()

set(
    REPOSITORY_OS
    "windows"
)

include(
    "${PROJECT_SOURCE_DIR}/cmake/cnpm/NastyPackageManager.cmake"
)

NPM_ADD_PACKAGE(
	NAME
		msvs
	VERSION
		2019
	BUILD_NUMBER
		0
)

NPM_ADD_PACKAGE(
	NAME
		WindowsSDK
	VERSION
		10.0.18362.0
	BUILD_NUMBER
		0
)

NPM_PREPARE_PACKAGES(
    DEFAULT_REPOSITORY_URLS
            "https://cnpm.rogii.com/${REPOSITORY_OS}/public"
)

include(CMakeDependentOption)
include(GNUInstallDirs)

#Note that googlemock target already builds googletest
option(BUILD_GMOCK "Builds the googlemock subproject" ON)
option(INSTALL_GTEST "Enable installation of googletest. (Projects embedding googletest may want to turn this OFF.)" ON)

if(BUILD_GMOCK)
  add_subdirectory( googlemock )
else()
  add_subdirectory( googletest )
endif()
