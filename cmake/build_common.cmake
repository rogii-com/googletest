if(
    NOT DEFINED ROOT
    OR NOT DEFINED ARCH
)
    message(
        FATAL_ERROR
        "Assert: ROOT = ${ROOT}; ARCH = ${ARCH}"
    )
endif()

set(
    BUILD
    0
)

if(DEFINED ENV{BUILD_NUMBER})
    set(
        BUILD
        $ENV{BUILD_NUMBER}
    )
endif()

set(
    TAG
    ""
)

if(DEFINED ENV{TAG})
    set(
        TAG
        "$ENV{TAG}"
    )
else()
    find_package(
        Git
    )

    if(Git_FOUND)
        execute_process(
            COMMAND
                ${GIT_EXECUTABLE} rev-parse --short HEAD
            OUTPUT_VARIABLE
                TAG
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        set(
            TAG
            "_${TAG}"
        )
    endif()
endif()

include(
    "${CMAKE_CURRENT_LIST_DIR}/Version.cmake"
)

set(
    BUILD_PATH
    "${CMAKE_CURRENT_LIST_DIR}/../build"
)

set(
    PACKAGE_NAME
    "gtest-${VERSION}-${ARCH}-${BUILD}${TAG}"
)

set(
    CMAKE_INSTALL_PREFIX
    ${ROOT}/${PACKAGE_NAME}
)

set(
    DEBUG_PATH
    "${BUILD_PATH}/debug"
)

set(
    RELEASE_PATH
    "${BUILD_PATH}/release"
)

file(
    MAKE_DIRECTORY
    "${DEBUG_PATH}"
)
file(
    MAKE_DIRECTORY
    "${RELEASE_PATH}"
)

if(WIN32)
    set(
        GENERATOR
        -G Ninja
    )
endif()

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" ${GENERATOR} -DCMAKE_BUILD_TYPE=Debug -DCMAKE_DEBUG_POSTFIX=d -DBUILD_GTEST=ON -DBUILD_GMOCK=OFF -DBUILD_SHARED_LIBS=OFF -Dgtest_force_shared_crt=ON -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../..
    WORKING_DIRECTORY
        "${DEBUG_PATH}"
)
execute_process(
    COMMAND
        "${CMAKE_COMMAND}" --build . --target install
    WORKING_DIRECTORY
        "${DEBUG_PATH}"
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" ${GENERATOR} -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_GTEST=ON -DBUILD_GMOCK=OFF -DBUILD_SHARED_LIBS=OFF  -Dgtest_force_shared_crt=ON -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} ../..
    WORKING_DIRECTORY
        "${RELEASE_PATH}"
)
execute_process(
    COMMAND
        "${CMAKE_COMMAND}" --build . --target install
    WORKING_DIRECTORY
        "${RELEASE_PATH}"
)

if(WIN32)
    file(
        COPY
            "${DEBUG_PATH}/googletest/gtestd.pdb"
            "${DEBUG_PATH}/googletest/gtest_maind.pdb"
            "${RELEASE_PATH}/googletest/gtest.pdb"
            "${RELEASE_PATH}/googletest/gtest_main.pdb"
        DESTINATION
            "${ROOT}/${PACKAGE_NAME}/lib"
    )
endif()

file(
    COPY
        "${CMAKE_CURRENT_LIST_DIR}/../package.cmake"
    DESTINATION
        "${ROOT}/${PACKAGE_NAME}"
)

file(
    REMOVE_RECURSE
    "${BUILD_PATH}"
)

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" -E tar cf "${PACKAGE_NAME}.7z" --format=7zip -- "${PACKAGE_NAME}"
    WORKING_DIRECTORY
        "${ROOT}"
)

