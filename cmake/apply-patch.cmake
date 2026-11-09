# surge_apply_patch(<dir> <patch>)
#
# Applies <patch> to the git checkout in <dir> at configure time, once.
# Used by the lion-1.9.0 branch to carry Mac OS X 10.7 fixes for vstgui.surge
# and JUCE without forking those repositories. If the patch is already applied
# it is skipped; if it neither applies nor reverses cleanly configuration fails.
function(surge_apply_patch dir patch)
  find_package(Git REQUIRED)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} apply --reverse --check ${patch}
    WORKING_DIRECTORY ${dir}
    RESULT_VARIABLE already_applied OUTPUT_QUIET ERROR_QUIET)
  if(already_applied EQUAL 0)
    message(STATUS "Patch ${patch} already applied in ${dir}")
    return()
  endif()
  execute_process(
    COMMAND ${GIT_EXECUTABLE} apply ${patch}
    WORKING_DIRECTORY ${dir}
    RESULT_VARIABLE result)
  if(NOT result EQUAL 0)
    message(FATAL_ERROR "Could not apply ${patch} in ${dir}")
  endif()
  message(STATUS "Applied ${patch} in ${dir}")
endfunction()
