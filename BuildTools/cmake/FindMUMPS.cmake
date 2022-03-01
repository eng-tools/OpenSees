#----------------------------------------------------------
# OpenSees
#----------------------------------------------------------
# This file was copied and modified from the scivision/mumps project at
# https://github.com/scivision/mumps/blob/main/cmake/Modules/FindMUMPS.cmake
# Original license below:
# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.


function(mumps_libs)

find_path(MUMPS_INCLUDE_DIR
  NAMES mumps_compat.h
  PATHS
  $ENV{MUMPSDIR}
  PATH_SUFFIXES
  include
)

if(NOT MUMPS_INCLUDE_DIR)
  return()
endif()
message(STATUS "MUMPS found")

# get Mumps version
find_file(mumps_conf
NAMES smumps_c.h
HINTS ${MUMPS_INCLUDE_DIR}
NO_DEFAULT_PATH
)

if(mumps_conf)
  message(STATUS "get version number.")
  file(STRINGS ${mumps_conf} _def
  REGEX "^[ \t]*#[ \t]*define[ \t]+MUMPS_VERSION[ \t]+" )
  if("${_def}" MATCHES "MUMPS_VERSION[ \t]+\"([0-9]+\\.[0-9]+\\.[0-9]+)?\"")
    set(MUMPS_VERSION "${CMAKE_MATCH_1}" PARENT_SCOPE)
  endif()
endif()

find_library(MUMPS_COMMON
  NAMES mumps_common mumps_common_mpi
  PATHS
  $ENV{MUMPSDIR}
  PATH_SUFFIXES
  lib
)

if(NOT MUMPS_COMMON)
  return()
endif()

find_library(PORD
  NAMES pord libpord mumps_pord
  PATHS
  $ENV{MUMPSDIR}
  PATH_SUFFIXES
  lib
)
if(NOT PORD)
  return()
endif()

message(STATUS "MUMPS_common and PORD found.")

set(MUMPS_LIBRARIES ${MUMPS_LIBRARY} ${MUMPS_COMMON} ${PORD} PARENT_SCOPE)
set(MUMPS_INCLUDE_DIR ${MUMPS_INCLUDE_DIR} PARENT_SCOPE)

endfunction(mumps_libs)

# --- main

if(NOT MUMPS_FIND_COMPONENTS)
  set(MUMPS_FIND_COMPONENTS d)
endif()

mumps_libs()

if(MUMPS_LIBRARY AND MUMPS_INCLUDE_DIR)

# -- minimal check that MUMPS is linkable

mumps_check()

endif(MUMPS_LIBRARY AND MUMPS_INCLUDE_DIR)
# --- finalize

set(CMAKE_REQUIRED_INCLUDES)
set(CMAKE_REQUIRED_LIBRARIES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(MUMPS
REQUIRED_VARS MUMPS_LIBRARIES MUMPS_INCLUDE_DIR
VERSION_VAR MUMPS_VERSION
)

if(MUMPS_FOUND)
 set(MUMPS_LIBRARIES ${MUMPS_LIBRARY})
 set(MUMPS_INCLUDE_DIRS ${MUMPS_INCLUDE_DIR})

 if(NOT TARGET MUMPS::MUMPS)
   add_library(MUMPS::MUMPS INTERFACE IMPORTED)
   set_target_properties(MUMPS::MUMPS PROPERTIES
   INTERFACE_LINK_LIBRARIES "${MUMPS_LIBRARY}"
   INTERFACE_INCLUDE_DIRECTORIES "${MUMPS_INCLUDE_DIR}"
   )
 endif()

endif(MUMPS_FOUND)

mark_as_advanced(MUMPS_INCLUDE_DIR MUMPS_LIBRARY)