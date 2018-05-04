@echo off

set "loc7z=C:\Program Files\7-Zip\7z.exe"

REM @echo on

set "target_dir=%~dp1"

set "target_name=%~n1"

set "first_extract_path=%target_dir%%target_name%"

"%loc7z%" e %1 -o"%first_extract_path%" >nul 2>nul

"%loc7z%" e "%first_extract_path%\0003.dat" -o"%first_extract_path%\0003" >nul 2>nul

copy /y "%first_extract_path%\0003\0.xml" "%first_extract_path%.pmml" >nul

rmdir /q /s %first_extract_path%