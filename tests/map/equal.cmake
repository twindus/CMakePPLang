include(cmake_test/cmake_test)

ct_add_test("cpp_map_equal")
    include(cmakepp_core/map/map)

    ct_add_section("Empty Map == Empty Map")
        cpp_map(CTOR a_map)
        cpp_map(CTOR another_map)
        cpp_map(EQUAL "${a_map}" result "${another_map}")
        ct_assert_equal(result TRUE)
    ct_end_section()

    ct_add_section("Filled map")
        cpp_map(CTOR a_map foo bar hello world)

        ct_add_section("Different than empty map")
            cpp_map(CTOR another_map)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Different keys")
            cpp_map(CTOR another_map foo1 bar hello1 world)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Different values")
            cpp_map(CTOR another_map foo bar1 hello world1)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Same values")
            cpp_map(CTOR another_map foo bar hello world)
            cpp_map(EQUAL "${a_map}" result "${another_map}")
            ct_assert_equal(result TRUE)
        ct_end_section()
    ct_end_section()
ct_end_test()
