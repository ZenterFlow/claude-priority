@echo off
REM test-all.bat
REM Windows batch file wrapper for test-all.sh
REM This runs the bash test suite using Git Bash

echo ========================================
echo Claude Priority Marketplace Test Suite
echo ========================================
echo.

REM Check if Git Bash is available
where bash >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Git Bash not found!
    echo.
    echo Please install Git for Windows from:
    echo https://git-scm.com/download/win
    echo.
    echo Git Bash is required to run the validation scripts.
    pause
    exit /b 1
)

REM Run the bash test suite from tests directory
cd /d "%~dp0"
bash test-all.sh

REM Capture exit code
set TEST_EXIT_CODE=%errorlevel%

if %TEST_EXIT_CODE% equ 0 (
    echo.
    echo All tests passed! Ready to publish.
) else (
    echo.
    echo Tests failed. Please fix errors before publishing.
)

pause
exit /b %TEST_EXIT_CODE%
