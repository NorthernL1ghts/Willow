@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

set "BLD=build"
set "GCC="

where gcc >nul 2>&1
if not errorlevel 1 (
    for /f "delims=" %%i in ('where gcc 2^>nul') do (
        set "GCC=%%i"
        goto :have_gcc
    )
)

if exist "C:\msys64\mingw64\bin\gcc.exe" set "GCC=C:\msys64\mingw64\bin\gcc.exe"
if not defined GCC if exist "C:\msys64\ucrt64\bin\gcc.exe" set "GCC=C:\msys64\ucrt64\bin\gcc.exe"
if not defined GCC if exist "C:\mingw64\bin\gcc.exe" set "GCC=C:\mingw64\bin\gcc.exe"
if not defined GCC if exist "%LOCALAPPDATA%\Programs\mingw64\bin\gcc.exe" set "GCC=%LOCALAPPDATA%\Programs\mingw64\bin\gcc.exe"
if not defined GCC if exist "%ProgramFiles%\mingw-w64\bin\gcc.exe" set "GCC=%ProgramFiles%\mingw-w64\bin\gcc.exe"
if not defined GCC if exist "%ProgramFiles(x86)%\mingw-w64\bin\gcc.exe" set "GCC=%ProgramFiles(x86)%\mingw-w64\bin\gcc.exe"

:have_gcc
if not defined GCC (
    echo ERROR: gcc not found.
    echo Install MSYS2 ^(https://www.msys2.org/^) and run in MSYS2 UCRT64 or MinGW64:
    echo   pacman -Syu
    echo   pacman -S mingw-w64-x86_64-gcc mingw-w64-x86_64-ninja mingw-w64-x86_64-cmake
    echo Then either add C:\msys64\mingw64\bin to PATH or keep this script's default search paths.
    exit /b 1
)

for %%F in ("%GCC%") do set "GCC_BIN=%%~dpF"
set "GCC_BIN=%GCC_BIN:~0,-1%"
set "PATH=%GCC_BIN%;%PATH%"

echo Using GCC: %GCC%
echo.

where ninja >nul 2>&1
if not errorlevel 1 (
    cmake -S . -B "%BLD%" -G Ninja -DCMAKE_C_COMPILER="%GCC%" -DCMAKE_BUILD_TYPE=Debug
    if errorlevel 1 exit /b 1
    goto :build
)

where mingw32-make >nul 2>&1
if not errorlevel 1 (
    cmake -S . -B "%BLD%" -G "MinGW Makefiles" -DCMAKE_C_COMPILER="%GCC%" -DCMAKE_BUILD_TYPE=Debug
    if errorlevel 1 exit /b 1
    goto :build
)

echo ERROR: Need ninja or mingw32-make next to gcc ^(same MinGW/MSYS2 bin folder^).
echo In MSYS2 MinGW64 shell: pacman -S mingw-w64-x86_64-ninja
exit /b 1

:build
cmake --build "%BLD%"
if errorlevel 1 exit /b 1

"%BLD%\wil.exe" %*
set "EC=%ERRORLEVEL%"
echo.
echo Exit code: %EC%
exit /b %EC%
