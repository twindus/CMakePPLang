include(cmake_test/cmake_test)

ct_add_test(NAME "test__cpp_object_get_meta_attr")
function("${test__cpp_object_get_meta_attr}")
    include(cmakepp_lang/object/object)

    _cpp_object_ctor(an_obj obj)

    ct_add_section(NAME "test_signature")
    function("${test_signature}")
        set(CMAKEPP_LANG_DEBUG_MODE ON)

        ct_add_section(NAME "first_arg_obj" EXPECTFAIL)
        function("${first_arg_obj}")
            _cpp_object_get_meta_attr(TRUE result my_type)
        endfunction()

        ct_add_section(NAME "second_arg_desc" EXPECTFAIL)
        function("${second_arg_desc}")
            _cpp_object_get_meta_attr("${an_obj}" TRUE my_type)
        endfunction()

        ct_add_section(NAME "third_arg_desc" EXPECTFAIL)
        function("${third_arg_desc}")
            _cpp_object_get_meta_attr("${an_obj}" result TRUE)
        endfunction()

        ct_add_section(NAME "takes_three_args" EXPECTFAIL)
        function("${takes_three_args}")
            _cpp_object_get_meta_attr("${an_obj}" result my_type hello)
        endfunction()
    endfunction()

    ct_add_section(NAME "get_my_type_attr")
    function("${get_my_type_attr}")
        _cpp_object_get_meta_attr("${an_obj}" result my_type)
        ct_assert_equal(result obj)
    endfunction()

    ct_add_section(NAME "get_nonexistent_attr")
    function("${get_nonexistent_attr}")
        _cpp_object_get_meta_attr("${an_obj}" result not_an_attr)
        ct_assert_equal(result "")
    endfunction()
endfunction()
