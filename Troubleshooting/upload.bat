rem avrdude.exe -C"avrdude.conf" -v -patmega2560 -cwiring -PCOM5 -b115200 -Uflash:w:Chip-TesterPro_TestFW.ino_atmega2560_16000000L.hex:i 
avrdude.exe -C"avrdude.conf" -v -patmega2560 -cstk500 -PCOM5 -Uflash:w:Chip-TesterPro-DiagFW.hex:i 
pause
