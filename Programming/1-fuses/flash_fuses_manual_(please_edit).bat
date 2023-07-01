rem Check Fuses
avrdude.exe -C"avrdude.conf" -B 4 -patmega2560 -cstk500 -PCOM5 -U lfuse:r:-:i -U hfuse:r:-:i -U efuse:r:-:i

rem Do NOT save config in EEPROM
rem avrdude.exe -C"avrdude.conf" -B 4 -patmega2560 -cstk500 -PCOM5 -U lfuse:w:0xff:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m 

rem Save config in EEPROM
rem avrdude.exe -C"avrdude.conf" -B 4 -patmega2560 -cstk500 -PCOM5 -U lfuse:w:0xff:m -U hfuse:w:0xd7:m -U efuse:w:0xff:m 

rem Save config in EEPROM and use Full Swing Oscillator (refer to manual)
avrdude.exe -C"avrdude.conf" -B 4 -patmega2560 -cstk500 -PCOM5 -U lfuse:w:0xf7:m -U hfuse:w:0xd7:m -U efuse:w:0xff:m 

pause
