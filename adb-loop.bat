@echo off
title Force ADB over WiFi TCP^/IP
setlocal EnableDelayedExpansion
echo Press Ctrl+C and press y to Terminate
set /p ip=Enter your IP: 
:x
adb devices >nul
for /f %%f in ('adb devices ^| grep "!ip!:5555"') do (
	if [%%f] neq [!ip!:5555] goto :next
	if [%%f] equ [!ip!:5555] (
		goto :eof
	)
)
:next
echo.
echo Waiting for a USB connection...
echo.
adb tcpip 5555
adb connect !ip!
for /f %%f in ('adb devices ^| grep "!ip!:5555"') do (
	if [%%f] equ [!ip!:5555] (
		goto :eof
	)
)
timeout /t 1 /nobreak
goto :x

:eof
