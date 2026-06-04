# Write some user messages to produce SARIF results
message(WARNING "Example warning message")

# The second warning should be logged, but the rule should not be duplicated
message(WARNING "A second example warning message")

# Status message should not be logged
message(STATUS "Example status message")

include(${CMAKE_CURRENT_LIST_DIR}/GenerateSarifResults-included-source.cmake)

# Scenario: warning from a CMake function call. The backtrace shows the function
# call hierarchy: the message() inside the function body, then the call site.
function(sarif_demo_warning msg)
  message(WARNING "${msg}")
endfunction()
sarif_demo_warning("Warning from function call")

# Scenario: CMake -> C++ -> CMake via variable_watch. The set() call in CMake
# triggers the C++ variable_watch machinery which invokes the callback (also
# CMake). The C++ dispatch uses a synthetic line number that the SARIF generator
# filters out, so the stack cleanly bridges: message() in callback -> set() call.
function(sarif_watch_cb var access value current_list_file stack)
  message(WARNING "Watch: ${var} was ${access}")
endfunction()
variable_watch(SARIF_WATCHED_VAR sarif_watch_cb)
set(SARIF_WATCHED_VAR "trigger_value")
