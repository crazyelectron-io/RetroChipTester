@echo off
cls
rem avrdude.exe -C"avrdude.conf" -v -patmega2560 -cwiring -PCOM5 -b115200 -Uflash:w:Chip-TesterPro-FW-v0.14.hex:i 
rem avrdude.exe -C"avrdude.conf" -v -patmega2560 -cstk500 -PCOM5 -b115200 -Uflash:w:Chip-TesterPro-FW-v0.14.hex:i 

echo.
echo Upload firmware
echo.

rem you can flash much faster (8x) when you add -B0.5 to the command line
rem ensure that the programmer supports this speed (or try 4x with -B1)

for %%f in ( Chip-TesterPro-FW-v0.??.hex ) do (
    if exist %%f avrdude.exe -C"avrdude.conf" -v -patmega2560 -cstk500 -PCOM5 -Uflash:w:%%f:i 
)

pause
