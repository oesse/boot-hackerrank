set(CATCH2_VERSION 2.2.1)
find_package(Catch2 ${CATCH2_VERSION} QUIET)

set(CATCH2_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/external/catch2)
set(CATCH2_DOWNLOAD_PREFIX ${CMAKE_BINARY_DIR}/external/catch2-download)

function(ConfigureCatch2) 
  configure_file(${CMAKE_SOURCE_DIR}/cmake/Catch2-CMakeLists.txt.in ${CATCH2_DOWNLOAD_PREFIX}/CMakeLists.txt)
  execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
    RESULT_VARIABLE result
    WORKING_DIRECTORY ${CATCH2_DOWNLOAD_PREFIX})

  if(result)
    message(FATAL_ERROR "Configure step for catch failed: ${result}")
  endif()
endfunction()

function(DownloadCatch2)
  ConfigureCatch2()

  execute_process(COMMAND ${CMAKE_COMMAND} --build .
    RESULT_VARIABLE result
    WORKING_DIRECTORY ${CATCH2_DOWNLOAD_PREFIX})

  if(result)
    message(FATAL_ERROR "Download step for catch failed: ${result}")
  endif()
endfunction()

if(NOT Catch2_FOUND)
  DownloadCatch2()

  add_library(Catch INTERFACE)
  target_include_directories(Catch INTERFACE ${CATCH2_INSTALL_PREFIX}/include)
  add_library(Catch2::Catch ALIAS Catch)
endif()

if (NOT EXISTS ${CATCH2_INSTALL_PREFIX}/catch2_main.cpp)
  file(WRITE ${CATCH2_INSTALL_PREFIX}/catch2_main.cpp
  "#define CATCH_CONFIG_MAIN
  #include <catch.hpp>"
  )
endif()

add_library(CatchMain STATIC ${CATCH2_INSTALL_PREFIX}/catch2_main.cpp)
target_link_libraries(CatchMain PUBLIC Catch2::Catch)
