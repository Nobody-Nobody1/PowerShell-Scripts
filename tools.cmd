@echo off
set tool=%1
set scriptFolder=%~dp0scripts

if "%tool%"=="" goto menu

if exist "%scriptFolder%\%tool%.ps1" (
    powershell -ExecutionPolicy Bypass -File "%scriptFolder%\%tool%.ps1" %*
    goto end
)

echo Unknown tool: %tool%
goto end

:menu
echo Available tools:
for %%f in ("%scriptFolder%\*.ps1") do echo   %%~nf
echo.
echo Usage: tools <toolname> [arguments]

:end