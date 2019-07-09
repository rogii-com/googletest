if(
    NOT DEFINED ROOT
    OR NOT DEFINED PACKAGE_NAME
    OR NOT DEFINED BUILD_PATH
)
    message(
        FATAL_ERROR
        "Assert: ROOT = ${ROOT}; PACKAGE_NAME = ${PACKAGE_NAME}; BUILD_PATH = ${BUILD_PATH}"
    )
endif()

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
        "-G Ninja"
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
		"${DEBUG_PATH}/gtestd.pdb"
		"${DEBUG_PATH}/Debug/gtest_maind.pdb"
		"${RELEASE_PATH}/gtest.pdb"
		"${RELEASE_PATH}/gtest_main.pdb"
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

execute_process(
    COMMAND
        "${CMAKE_COMMAND}" -E tar cf "${PACKAGE_NAME}.7z" --format=7zip -- "${PACKAGE_NAME}"
    WORKING_DIRECTORY
        "${ROOT}"
)

