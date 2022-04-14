include(cmake_test/cmake_test)

ct_add_test(NAME "test_cpp_is_fxn")
function("${test_cpp_is_fxn}")
    include(cmakepp_lang/types/fxn)

    ct_add_section(NAME "test_signature" EXPECTFAIL)
    function("${test_signature}")
        cpp_is_fxn(return add_subdirectory hello)
    endfunction()

    ct_add_section(NAME "test_bool")
    function("${test_bool}")
        cpp_is_fxn(return TRUE)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_class")
    function("${test_class}")
        include(cmakepp_lang/class/class)
        cpp_class(MyClass)

        cpp_is_fxn(return MyClass)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_command")
    function("${test_command}")
        cpp_is_fxn(return add_subdirectory)
        ct_assert_equal(return TRUE)
    endfunction()

    ct_add_section(NAME "test_descriptions")
    function("${test_descriptions}")
        ct_add_section(NAME "description_without_fxn")
        function("${description_without_fxn}")
            cpp_is_fxn(return "Hello World")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "description_contains_fxn")
        function("${description_contains_fxn}")
            cpp_is_fxn(return "Hello World add_subdirectory")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_float")
    function("${test_float}")
        cpp_is_fxn(return 3.14)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_integer")
    function("${test_integer}")
        cpp_is_fxn(return 42)
        ct_assert_equal(return FALSE)
    endfunction()

    ct_add_section(NAME "test_list")
    function("${test_list}")
        ct_add_section(NAME "normal_list")
        function("${normal_list}")
            cpp_is_fxn(return [[hello;world]])
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "list_of_fxns")
        function("${list_of_fxns}")
            cpp_is_fxn(return [[add_subdirectory;include]])
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_map")
    function("${test_map}")
        include(cmakepp_lang/map/map)
        cpp_map(CTOR a_map)
        cpp_is_fxn(result a_map)
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_obj")
    function("${test_obj}")
        include(cmakepp_lang/object/object)
        cpp_is_fxn(result "${__CMAKEPP_LANG_OBJECT_SINGLETON__}")
        ct_assert_equal(result FALSE)
    endfunction()

    ct_add_section(NAME "test_path")
    function("${test_path}")
        ct_add_section(NAME "normal_path")
        function("${normal_path}")
            cpp_is_fxn(return "${CMAKE_CURRENT_LIST_DIR}")
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "path_contains_fxn")
        function("${path_contains_fxn}")
            cpp_is_fxn(return "${CMAKE_CURRENT_LIST_DIR}/add_subdirectory")
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_target")
    function("${test_target}")
        ct_add_section(NAME "normal_target_name")
        function("${normal_target_name}")
            add_library(lib STATIC IMPORTED)
            cpp_is_fxn(return lib)
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "target_with_fxn")
        function("${target_with_fxn}")
            add_library(libadd_subdirectory STATIC IMPORTED)
            cpp_is_fxn(return lib1)
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()

    ct_add_section(NAME "test_type")
    function("${test_type}")

        ct_add_section(NAME "type_not_command")
        function("${type_not_command}")
            cpp_is_fxn(return bool)
            ct_assert_equal(return FALSE)
        endfunction()

        ct_add_section(NAME "list_which_is_also_command")
        function("${list_which_is_also_command}")
            cpp_is_fxn(return list)
            ct_assert_equal(return FALSE)
        endfunction()
    endfunction()
endfunction()