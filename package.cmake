if(NOT TARGET GTest::GTest)
    add_library(
        GTest::GTest
        STATIC
        IMPORTED
    )

    if(TARGET Threads::Threads)
        set_target_properties(
            GTest::GTest
            PROPERTIES
            INTERFACE_LINK_LIBRARIES
                Threads::Threads
        )
    endif()

    if(MSVC)
        set_target_properties(
            GTest::GTest
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest.lib"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtestd.lib"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include/gtest"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            GTest::GTest
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest.a"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtestd.a"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include/gtest"
        )
    endif()    
endif()

if(NOT TARGET GTest::Main)
    add_library(
        GTest::Main
        STATIC
        IMPORTED
    )

    set_target_properties(
        GTest::Main
        PROPERTIES
        INTERFACE_LINK_LIBRARIES
            GTest::GTest
        )

    if(MSVC)
        set_target_properties(
            GTest::GTest
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_main.lib"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_maind.lib"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include/gtest"
        )
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set_target_properties(
            GTest::GTest
            PROPERTIES
                IMPORTED_LOCATION
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_main.a"
                IMPORTED_LOCATION_DEBUG
                    "${CMAKE_CURRENT_LIST_DIR}/lib/gtest_maind.a"
                INTERFACE_INCLUDE_DIRECTORIES
                    "${CMAKE_CURRENT_LIST_DIR}/include/gtest"
        )
    endif()
endif()
