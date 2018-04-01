include(CTest)


if(BUILD_TESTING)
  include(Catch2)

  function(AddUnitTests library)
    set(options NONE)
    set(oneValueArgs DIRECTORY)
    set(multiValueArgs TEST_CASES)
    cmake_parse_arguments(ADD_TESTS_ARGS
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}" 
      ${ARGN})

    foreach(test_source ${ADD_TESTS_ARGS_TEST_CASES})
      string(REGEX REPLACE "\.cpp$" "" target ${test_source})
      if (ADD_TESTS_ARGS_DIRECTORY)
        set(source ${ADD_TESTS_ARGS_DIRECTORY}/${test_source})
      else()
        set(source ${test_source})
      endif()

      add_executable(${target} ${source})
      target_link_libraries(${target} PRIVATE ${library} CatchMain)
      add_test(NAME ${target} COMMAND ${target})
    endforeach()
  endfunction()

  find_program(BASH NAMES bash)
  function(AddE2ETests executable)
    set(options NONE)
    set(oneValueArgs DIRECTORY)
    set(multiValueArgs TEST_CASES)
    cmake_parse_arguments(ADD_TESTS_ARGS
      "${options}"
      "${oneValueArgs}"
      "${multiValueArgs}" 
      ${ARGN})

    foreach(test_source ${ADD_TESTS_ARGS_TEST_CASES})
      string(REGEX REPLACE "\.cpp$" "" target ${test_source})
      if (ADD_TESTS_ARGS_DIRECTORY)
        set(source ${ADD_TESTS_ARGS_DIRECTORY}/${test_source})
      else()
        set(source ${test_source})
      endif()

      set(TEST_COMMAND ${BASH} ${CMAKE_SOURCE_DIR}/tools/test-runner.sh ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${executable} ${source})

      string(REGEX REPLACE "\.io$" "" test_name ${test_source})

      add_custom_target(
        ${test_name}
        DEPENDS ${executable}
        COMMAND ${TEST_COMMAND})
      add_test(
        NAME ${test_name}
        COMMAND ${TEST_COMMAND})
    endforeach()
  endfunction()

  enable_testing()
else()
  function(AddUnitTests library)
  endfunction()
  function(AddE2ETests executable)
  endfunction()
endif()

