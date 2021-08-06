setlocal EnableDelayedExpansion
@echo on

cd build
if errorlevel 1 exit 1

copy src\*.exe "%LIBRARY_BIN%"\
if errorlevel 1 exit 1
