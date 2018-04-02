if(ENABLE_COVERAGE)
  find_program(LCOV NAMES lcov)
  find_program(GENHTML NAMES genhtml)


  add_custom_command(
    OUTPUT coverage.info
    COMMAND ${LCOV} --capture --directory . --output-file coverage-tmp.info
    COMMAND ${LCOV} --remove coverage-tmp.info '/usr/*' '*/test/*' '*/catch/*' --output-file coverage.info
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    MAIN_DEPENDENCY test
    )

  add_custom_command(
    OUTPUT coverage/index.html
    COMMAND ${GENHTML} coverage.info --output-directory coverage
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    MAIN_DEPENDENCY coverage.info
    )

  add_custom_target(coverage DEPENDS coverage/index.html)
endif()
