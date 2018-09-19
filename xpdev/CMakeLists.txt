project (XPDev C)

cmake_minimum_required(VERSION 2.8.11)

INCLUDE (CheckIncludeFiles)
INCLUDE (CheckFunctionExists)
INCLUDE (FindThreads)

set(SOURCE
    conwrap.c
    dat_file.c
    datewrap.c
    dirwrap.c
    filewrap.c
    genwrap.c
    ini_file.c
    link_list.c
    msg_queue.c
    multisock.c
    semwrap.c
    netwrap.c
    sockwrap.c
    semfile.c
    str_list.c
    strwrap.c
    threadwrap.c
    xp_dl.c
    xpbeep.c
    xpdatetime.c
    xpmap.c
    xpprintf.c
)

if(NOT WIN32)
	list(APPEND SOURCE xpevent.c)
    list(APPEND SOURCE xpsem.c)
endif()

add_library(xpdev ${SOURCE})

CHECK_INCLUDE_FILES(inttypes.h HAS_INTTYPES_H)
if(HAS_INTTYPES_H)
    target_compile_definitions(xpdev PUBLIC HAS_INTTYPES_H)
endif()
CHECK_INCLUDE_FILES(stdint.h HAS_STDINT_H)
if(HAS_STDINT_H)
    target_compile_definitions(xpdev PUBLIC HAS_STDINT_H)
endif()
target_compile_definitions(xpdev PUBLIC LINK_LIST_THREADSAFE)

if(WIN32)
	target_link_libraries(xpdev Iphlpapi Ws2_32 Winmm Netapi32)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Haiku")
	target_link_libraries(xpdev network m)
elseif(CMAKE_SYSTEM_NAME STREQUAL "NetBSD")
	target_link_libraries(xpdev ossaudio m)
elseif(CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
	target_link_libraries(xpdev ossaudio m)
elseif(CMAKE_SYSTEM_NAME STREQUAL "SunOS")
	target_link_libraries(xpdev socket m)
else()
	target_link_libraries(xpdev m)
endif()
target_link_libraries(xpdev ${CMAKE_THREAD_LIBS_INIT})

if(EXISTS /dev/urandom)
	target_compile_definitions(xpdev PRIVATE HAS_DEV_URANDOM URANDOM_DEV="/dev/urandom")
endif()
if(EXISTS /dev/random)
	target_compile_definitions(xpdev PRIVATE HAS_DEV_RANDOM RANDOM_DEV="/dev/random")
endif()

CHECK_FUNCTION_EXISTS(random HAS_RANDOM_FUNC) 
if(HAS_RANDOM_FUNC)
	target_compile_definitions(xpdev PRIVATE HAS_RANDOM_FUNC)
endif()

CHECK_FUNCTION_EXISTS(srandomdev HAS_SRANDOMDEV_FUNC)
if(HAS_SRANDOMDEV_FUNC)
	target_compile_definitions(xpdev PRIVATE HAS_SRANDOMDEV_FUNC)
endif()

target_include_directories(xpdev INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})