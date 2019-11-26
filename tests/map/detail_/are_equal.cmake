include(cmake_test/cmake_test)

ct_add_test("_cpp_map_are_equal")
    include(cmakepp_core/map/map)
    cpp_map(CTOR lhs)
    cpp_map(SET "${lhs}" a_key 42)
    cpp_map(SET "${lhs}" another_key "Hello World")

    ct_add_section("LHS == Empty map")
        cpp_map(CTOR rhs)
        ct_add_section("RHS == Empty map")
            cpp_map(CTOR lhs2)
            _cpp_map_are_equal(result "${lhs2}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("RHS == non-empty")
            # Uses the fact that lhs is not-empty, whereas we made an empty rhs
            _cpp_map_are_equal(result "${rhs}" "${lhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()

    ct_add_section("LHS == filled map")
        ct_add_section("Same map instance")
            _cpp_map_are_equal(result "${lhs}" "${lhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different instances, but same")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" another_key "Hello World")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result TRUE)
        ct_end_section()

        ct_add_section("Different values, but same keys")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" another_key "foo bar")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()

        ct_add_section("Same values, but different keys")
            cpp_map(CTOR rhs)
            cpp_map(SET "${rhs}" a_key 42)
            cpp_map(SET "${rhs}" foo_bar "hello world")
            _cpp_map_are_equal(result "${lhs}" "${rhs}")
            ct_assert_equal(result FALSE)
        ct_end_section()
    ct_end_section()
ct_end_test()