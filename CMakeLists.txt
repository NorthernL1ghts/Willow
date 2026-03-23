cmake_minimum_required(VERSION 3.20)

# Willow builds only with GCC or Clang — not MSVC or MSVC-based generators.
if(CMAKE_GENERATOR MATCHES "Visual Studio|NMake Makefiles")
  message(FATAL_ERROR
    "Willow does not support MSVC. Use Ninja or MinGW Makefiles with GCC or Clang "
    "(e.g. MinGW-w64, MSYS2, or Linux/macOS toolchains).")
endif()

# On Windows, pick GCC when no compiler was set (before project()).
if(WIN32 AND NOT CMAKE_C_COMPILER)
  if(CMAKE_GENERATOR MATCHES "Ninja|MinGW Makefiles|Unix Makefiles")
    find_program(WILLOW_GCC gcc)
    if(WILLOW_GCC)
      set(CMAKE_C_COMPILER "${WILLOW_GCC}" CACHE FILEPATH "C compiler" FORCE)
      message(STATUS "Willow: using GCC (${WILLOW_GCC})")
    endif()
  endif()
endif()

# compile_commands.json — clangd, IDE tooling, static analysis
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Optional: faster rebuilds when ccache is installed (must be before project())
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
endif()

project(Willow
  VERSION 0.1.0
  DESCRIPTION "Willow programming language compiler"
  LANGUAGES C
)

if(MSVC)
  message(FATAL_ERROR
    "Willow does not support the MSVC toolchain (including clang-cl). "
    "Use GCC or Clang with the GNU driver (e.g. gcc, clang).")
endif()

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

add_executable(wil
  src/main.c
)

target_include_directories(wil PRIVATE
  "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

target_compile_options(wil PRIVATE
  $<$<C_COMPILER_ID:GNU,Clang,AppleClang>:-Wall -Wextra -Wpedantic>
)
