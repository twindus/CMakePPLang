include(cmake_test/cmake_test)

ct_add_test("cpp_is_float")
    include(cmakepp_core/types/float)

    ct_add_section("Signature")
        cpp_is_float(return 3.14 hello)
        ct_assert_fails_as("cpp_is_float accepts exactly 2 arguments")
    ct_end_section()

    ct_add_section("bool")
        cpp_is_float(return TRUE)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("class")
        include(cmakepp_core/class/class)
        cpp_class(MyClass)

        cpp_is_float(return MyClass)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("command")
        cpp_is_float(return add_subdirectory)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("descriptions")
        ct_add_section("description w/o a float")
            cpp_is_float(return "Hello World")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("description containing a float")
            cpp_is_float(return "Hello World 3.14")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("float")
        ct_add_section("positive")
            cpp_is_float(return 3.14)
            ct_assert_equal(return TRUE)
        ct_end_section()

        ct_add_section("negative")
            cpp_is_float(return -3.14)
            ct_assert_equal(return TRUE)
        ct_end_section()
    ct_end_section()

    ct_add_section("integer")
        cpp_is_float(return 42)
        ct_assert_equal(return FALSE)
    ct_end_section()

    ct_add_section("list")
        ct_add_section("Normal list")
            cpp_is_float(return "hello;world")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("List of floats")
            cpp_is_float(return "1.23;2.34;3.45")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("map")
        include(cmakepp_core/map/map)
        cpp_map(CTOR a_map)
        cpp_is_float(result a_map)
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("obj")
        include(cmakepp_core/object/object)
        cpp_is_float(result "${__CMAKEPP_CORE_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    ct_end_section()

    ct_add_section("path")
        ct_add_section("Normal path")
            cpp_is_float(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("Path with float in it")
            cpp_is_float(return "${CMAKE_CURRENT_LIST_DIR}/3.14")
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("target")
        ct_add_section("normal target name")
            add_library(lib STATIC IMPORTED)
            cpp_is_float(return lib)
            ct_assert_equal(return FALSE)
        ct_end_section()

        ct_add_section("target with float")
            add_library(lib3.14 STATIC IMPORTED)
            cpp_is_float(return lib1)
            ct_assert_equal(return FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("type")
        cpp_is_float(return bool)
        ct_assert_equal(return FALSE)
    ct_end_section()
ct_end_test()
