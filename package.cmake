if(NOT TARGET google::test)
    add_library(
        google::test
        STATIC
        IMPORTED
    )

    if(TARGET Threads::Threads)
        set_target_properties(
            google::test
            PROPERTIES
            INTERFACE_LINK_LIBRARIES
                Threads::Threads
        )
    endif()

    if(MSVC)
        set_target_properties(
            google::test
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest.lib"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtestd.lib"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            google::test
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest.a"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtestd.a"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    endif()    
endif()

if(NOT TARGET google::test-main)
    add_library(
        google::test-main
        STATIC
        IMPORTED
    )

    set_target_properties(
        google::test-main
        PROPERTIES
        INTERFACE_LINK_LIBRARIES
            google::test
        )

    if(MSVC)
        set_target_properties(
            google::test-main
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_main.lib"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_maind.lib"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            google::test-main
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_main.a"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtestd_maind.a"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    endif()
endif()

if(NOT TARGET google::mock)
    add_library(
        google::mock
        STATIC
        IMPORTED
    )

    if(MSVC)
        set_target_properties(
            google::mock
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gmock.lib"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gmockd.lib"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            google::mock
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/libgmock.a"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/libgmockd.a"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include"
        )
    endif()
endif()
