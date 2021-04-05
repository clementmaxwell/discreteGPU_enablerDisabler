:: Written by Clement Maxwell
:: Version 1.1.3

@echo off
: Go to current directory
cd /d %~dp0

:: Get Admin Access
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:: Get the GPU id
set gpuID=
for /f "tokens=1 delims=&" %%a in (gpuID.txt) do (
  set gpuID=%%a
  goto :break
)
:break

:: Program menu
echo press 1 to enable dGPU
echo press 2 to disable dGPU
echo press 0 to exit
echo -----------------------

set /p x="> "
if %x%==1 goto enable
if %x%==2 goto disable
if %x%==0 goto end

:: Enable GPU
:enable
start devcon enable "%gpuID%"

:: Disable GPU
:disable
start devcon disable "%gpuID%"