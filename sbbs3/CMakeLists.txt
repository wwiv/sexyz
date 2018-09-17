project (SBBS3 C CXX)

cmake_minimum_required(VERSION 2.8.11)

INCLUDE (../build/SynchronetMacros.cmake)
INCLUDE (CheckFunctionExists)

if(MSVC)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_OPTIONS /wd4996)
endif()
set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS RINGBUF_SEM RINGBUF_EVENT RINGBUF_MUTEX)

if(EXISTS /dev/random)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS HAS_DEV_RANDOM RANDOM_DEV="/dev/random")
endif()

add_library(crc crc16.c crc32.c)
target_link_libraries(crc xpdev)

add_executable(sexyz
	sexyz.c
	xmodem.c
	zmodem.c
	ringbuf.c
	nopen.c
	telnet.c
)
require_libs(sexyz xpdev crc)

