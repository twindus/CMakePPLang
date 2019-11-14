include(cmake_test/cmake_test)

ct_add_test("_cpp_is_int")
    include(cmakepp_core/types/detail_/integer)

    ct_add_section("bool")
        _cpp_is_int(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o an integer")
            _cpp_is_int(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing integers")
            _cpp_is_int(return "Hello World 1")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("filepath")
        ct_add_section("Normal filepath (probably)")
            _cpp_is_int(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Contains an integer")
            _cpp_is_int(return "${CMAKE_CURRENT_LIST_DIR}/hello1")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        _cpp_is_int(return 3.14)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("integer")
        ct_add_section("positive")
            _cpp_is_int(return 42)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("negative")
            _cpp_is_int(return -42)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            _cpp_is_int(return "hello;world")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List of integers")
            _cpp_is_int(return "1;2;3")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/ctor)
        _cpp_map_ctor(my_map)
        _cpp_is_int(result "${my_map}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("target")
        ct_add_section("normal target name")
            add_library(lib STATIC IMPORTED)
            _cpp_is_int(return lib)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("target with integer")
            add_library(lib1 STATIC IMPORTED)
            _cpp_is_int(return lib1)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("type")
        _cpp_is_int(return bool)
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()
