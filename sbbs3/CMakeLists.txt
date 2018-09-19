project (SBBS3 C CXX)

cmake_minimum_required(VERSION 2.8.11)

INCLUDE (../build/SynchronetMacros.cmake)
INCLUDE (CheckFunctionExists)

set_property(
	DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS
	RINGBUF_SEM
	RINGBUF_EVENT
	RINGBUF_MUTEX
	TELNET_NO_DLL
	)

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

target_link_libraries(sexyz xpdev crc)
