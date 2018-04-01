if(ENABLE_CPPCHECK)
  find_program(CPPCHECK NAMES cppcheck)
  if (CPPCHECK-NOTFOUND)
    message(FATAL_ERROR "Could not find cppcheck. Try with ENABLE_CPPCHECK=OFF")
  endif()

  add_custom_target(cppcheck
    COMMAND ${CPPCHECK}
    --quiet
    --enable=warning,performance,portability
    --project=${CMAKE_BINARY_DIR}/compile_commands.json
    )
endif()
