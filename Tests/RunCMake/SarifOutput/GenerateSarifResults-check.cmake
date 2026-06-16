include("${CMAKE_CURRENT_LIST_DIR}/check-sarif.cmake")

check_sarif_output("${RunCMake_TEST_BINARY_DIR}/.cmake/sarif/cmake.sarif"
  "${CMAKE_CURRENT_LIST_DIR}/GenerateSarifResults-expected.sarif")
file(READ "${RunCMake_TEST_BINARY_DIR}/.cmake/sarif/cmake.sarif" SARIF_OUTPUT)
message(STATUS "SARIF_OUTPUT: ${SARIF_OUTPUT}")