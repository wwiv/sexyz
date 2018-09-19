# Supress warnings about "deprecated POSIX function names"
# (Some aren't POSIX, and none are deprecated by POSIX)
if(MSVC)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_OPTIONS /wd4996)
endif()
