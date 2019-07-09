if(NOT DEFINED ENV{ENV_INSTALL})
    message(
        FATAL_ERROR
        "You have to specify an install path via `ENV_INSTALL' variable."
    )
endif()

file(
    TO_CMAKE_PATH
    "$ENV{ENV_INSTALL}"
    ROOT
)

set(
    BUILD
    3
)

include(
    "${CMAKE_CURRENT_LIST_DIR}/Version.cmake"
)

set(
    ARCH
    x86
)

set(
    BUILD_PATH
    "${CMAKE_CURRENT_LIST_DIR}/../build"
)

set(
    PACKAGE_NAME
    "gtest-${VERSION}-${ARCH}-${BUILD}$ENV{TAG}"
)

include(
    "${CMAKE_CURRENT_LIST_DIR}/build_common.cmake"
)

