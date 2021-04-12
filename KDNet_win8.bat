rem @ECHO OFF

IF EXIST "C:\Program Files (x86)\Microsoft Xbox 360 SDK\bin\win32\windbg.exe" (
	start "balls" "C:\Program Files (x86)\Microsoft Xbox 360 SDK\bin\win32\windbg.exe" -k net:port=50001
)

IF EXIST "C:\Program Files\Microsoft Xbox 360 SDK\bin\win32\windbg.exe" (
	start "balls" C:\Program Files\Microsoft Xbox 360 SDK\bin\win32\windbg.exe -k net:port=50001
)

