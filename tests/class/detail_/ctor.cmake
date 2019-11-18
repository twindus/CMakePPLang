include(cmake_test/cmake_test)

ct_add_test("_cpp_class_ctor")
    include(cmakepp_core/class/detail_/ctor)

    ct_add_section("signature")
        set(CMAKEPP_CORE_DEBUG_MODE ON)
        ct_add_section("Arg1: desc")
            _cpp_class_ctor(TRUE a_new_type)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()

        ct_add_section("Arg2: desc")
            _cpp_class_ctor(result TRUE)
            ct_assert_fails_as("Assertion: TRUE is desc")
        ct_end_section()
    ct_end_section()

    ct_add_section("No base class")
        _cpp_class_ctor(result a_new_type)
        cpp_map(GET type "${result}" my_type)
        ct_assert_equal(type "a_new_type")
        cpp_map(GET base_classes "${result}" base_classes)
        cpp_array(GET result "${base_classes}" 0)
        ct_assert_equal(result object)
    ct_end_section()

    ct_add_section("One base class")
        _cpp_class_ctor(result a_new_type base1)
        cpp_map(GET type "${result}" my_type)
        ct_assert_equal(type "a_new_type")
        cpp_map(GET base_classes "${result}" base_classes)
        cpp_array(GET result "${base_classes}" 0)
        ct_assert_equal(result object)
        cpp_array(GET result "${base_classes}" 1)
        ct_assert_equal(result base1)
    ct_end_section()

    ct_add_section("Two base classes")
        _cpp_class_ctor(result a_new_type base1 base2)
        cpp_map(GET type "${result}" my_type)
        ct_assert_equal(type "a_new_type")
        cpp_map(GET base_classes "${result}" base_classes)
        cpp_array(GET result "${base_classes}" 0)
        ct_assert_equal(result object)
        cpp_array(GET result "${base_classes}" 1)
        ct_assert_equal(result base1)
        cpp_array(GET result "${base_classes}" 2)
        ct_assert_equal(result base2)
    ct_end_section()
ct_end_test()