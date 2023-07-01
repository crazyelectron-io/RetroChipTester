@echo off
ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto ver_xp

rem Some references for STK500 users:
rem AVR061: STK500 Communication Protocol
rem     http://ww1.microchip.com/downloads/en/AppNotes/doc2525.pdf
rem     https://github.com/arduino/Arduino-stk500v2-bootloader/blob/master/command.h
cls
chcp 1252 >nul

rem ----------------------------------------------------------------------------------------------------------------------------

echo This program sets the fuses for the Retro Chip Tester by 8Bit-Museum.de
echo Dieses Programm setzt die Fuses für den Retro Chip Testers des 8Bit-Museum.de
echo.
echo Press / Drücke
echo   "1"  for English  ( x for exit ).
echo   "2"  für Deutsch  ( x für Abbruch ).
echo.
set lang=
:wrongkey1
choice /C 12x /N /M ">"
if errorlevel  1 if not errorlevel  2 set lang=en
if errorlevel  2 if not errorlevel  3 set lang=de
if errorlevel  3 if not errorlevel  4 exit
if [%lang%] == [] goto wrongkey1
cls

rem ----------------------------------------------------------------------------------------------------------------------------

echo.
if [%lang%] == [en] echo Select the programmer you are using:
if [%lang%] == [en] echo 1 = STK500 (or compatible), w = Wiring, u = USBASP
if [%lang%] == [de] echo Wähle den eingesetzten Programmierer
if [%lang%] == [de] echo 1 = STK500 (oder kompatibel), w = Wiring, u = USBASP
echo.

set prog=
:wrongkey4
choice /C 1wu /N /M ">"
if errorlevel  1 if not errorlevel  2 set prog=-cstk500
if errorlevel  2 if not errorlevel  3 set prog=-cwiring
if errorlevel  3 if not errorlevel  4 set prog=-cusbasp
if [%prog%] == [] goto wrongkey4
cls

rem ----------------------------------------------------------------------------------------------------------------------------

set comport=
if [%prog%] == [-cusbasp] goto noport

echo.
if [%lang%] == [en] echo Select the COM port your programmer is using.
if [%lang%] == [en] echo 1..9 = COM1..9
if [%lang%] == [de] echo Wähle den COM Port den Dein Programmierer verwendet (z.B. "5" = COM5)
if [%lang%] == [de] echo 1..9 = COM1..9
echo.

set comport=
:wrongkey3
choice /C 123456789 /N /M ">"
if errorlevel  1 if not errorlevel  2 set comport=-PCOM1
if errorlevel  2 if not errorlevel  3 set comport=-PCOM2
if errorlevel  3 if not errorlevel  4 set comport=-PCOM3
if errorlevel  4 if not errorlevel  5 set comport=-PCOM4
if errorlevel  5 if not errorlevel  6 set comport=-PCOM5
if errorlevel  6 if not errorlevel  7 set comport=-PCOM6
if errorlevel  7 if not errorlevel  8 set comport=-PCOM7
if errorlevel  8 if not errorlevel  9 set comport=-PCOM8
if errorlevel  9 if not errorlevel 10 set comport=-PCOM9
if [%comport%] == [] goto wrongkey3
cls

:noport

rem ----------------------------------------------------------------------------------------------------------------------------

echo.
if [%lang%] == [en] echo Usually the EEPROM content will be erased when the chip is reprogrammed (e.g. with a new firmware).
if [%lang%] == [en] echo Shall the Chip Tester store its configuration permanently in EEPROM? (y/n)
if [%lang%] == [de] echo Normalerweise wird der EEPROM-Inhalt gelöscht, wenn der Chip neu programmiert wird (z.B. mit einer neuen Firmware).
if [%lang%] == [de] echo Soll der Chip Tester seine Konfiguration dauerhaft im EEPROM speichern? (j/n)
echo.

set eeprom=
:wrongkey2
choice /C yjn /N /M ">"
if errorlevel  1 if not errorlevel  2 set eeprom=y
if errorlevel  2 if not errorlevel  3 set eeprom=y
if errorlevel  3 if not errorlevel  4 set eeprom=n
if [%eeprom%] == [] goto wrongkey2
cls

rem ----------------------------------------------------------------------------------------------------------------------------

echo.
if [%lang%] == [en] echo Usually the microprocessor uses the Low Power Oscillator.
if [%lang%] == [en] echo When the voltage swing of the used crystal is too low, the Full Swing Oscillator should be used.
if [%lang%] == [en] echo Shall the Chip Tester use the Full Swing Oscillator (recommended)? (y/n)
if [%lang%] == [de] echo Normalerweise verwendet der Mikroprozessor den Low Power Oscillator.
if [%lang%] == [de] echo Wenn der Spannungshub des Quarzes zu niedrig sein sollte, sollte der Full Swing Oscillator verwendet werden.
if [%lang%] == [de] echo Soll der Chip Tester den Full Swing Oscillator verwenden (empfohlen)? (j/n)
echo.

set lowpower=
:wrongkey7
choice /C yjn /N /M ">"
if errorlevel  1 if not errorlevel  2 set lowpower=n
if errorlevel  2 if not errorlevel  3 set lowpower=n
if errorlevel  3 if not errorlevel  4 set lowpower=y
if [%lowpower%] == [] goto wrongkey7
cls

rem ----------------------------------------------------------------------------------------------------------------------------

echo.
if [%lang%] == [en] echo Test communication with ATmega2560. Identify currently set fuses.
if [%lang%] == [de] echo Teste Kommunikation mit dem ATmega2560. Ermittle aktuell gesetze Fuses.
echo.

@avrdude.exe -C"avrdude.conf" -patmega2560 %prog% %comport% -U lfuse:r:-:i -U hfuse:r:-:i -U efuse:r:-:i

echo.
if [%lang%] == [en] echo Press any key to reprogram the fuses or Ctrl+C to cancel.
if [%lang%] == [de] echo Taste drücken, um die Fuses zu programmieren oder Strg+C zum Abbruch.
echo.

@pause >nul
cls

rem ----------------------------------------------------------------------------------------------------------------------------

rem full swing oscillator is lfuse=0xF7
if [%lowpower%] == [y] set lfuse=0xFF
if [%lowpower%] == [n] set lfuse=0xF7
set efuse=0xFF
if [%eeprom%] == [y] set hfuse=0xD7
if [%eeprom%] == [n] set hfuse=0xDF

echo.
if [%lang%] == [en] echo Reprogram the fuses to 16 mhz external clock and no bootloader.
if [%lang%] == [de] echo Setze die Fuses auf 16 MHz externen Takt und keinen Bootloader.
if [%lang%] == [en] if [%eeprom%] == [y] echo The configuration will be stored permanently in EEPROM.
if [%lang%] == [de] if [%eeprom%] == [y] echo Die Konfiguration wird dauerhaft im EEPROM gespeichert.
if [%lang%] == [en] if [%lowpower%] == [y] echo The Low Power Oscillator will be used.
if [%lang%] == [en] if [%lowpower%] == [n] echo The Full Swing Oscillator will be used.
if [%lang%] == [de] if [%lowpower%] == [y] echo Der Low Power Oscillator wird verwendet.
if [%lang%] == [de] if [%lowpower%] == [y] echo Der Full Swing Oscillator wird verwendet.
echo.

@avrdude.exe -C"avrdude.conf" -v -patmega2560 %prog% %comport% -U lfuse:w:%lfuse%:m -U hfuse:w:%hfuse%:m -U efuse:w:%efuse%:m 

echo.
if [%lang%] == [en] echo The fuses should be set to ( E:%efuse%, H:%hfuse%, L:%lfuse% )
if [%lang%] == [en] echo Compare these values with the line above.
if [%lang%] == [de] echo Die Fuses sollten jetzt wie folgt gesetzt sein: ( E:%efuse%, H:%hfuse%, L:%lfuse% )
if [%lang%] == [de] echo Diese Werte mit der Zeile oben vergleichen.
echo.

rem ----------------------------------------------------------------------------------------------------------------------------

if [%lang%] == [en] echo When the fuses have been burned correctly, you can now press "c" to create a batch file
if [%lang%] == [en] echo with that parameters to program the firmware.
if [%lang%] == [en] echo Copy this file into the folder with the firmware.
if [%lang%] == [de] echo Wenn die Fuses korrekt gesetzt wurden, kannst du nun durch Druck auf "c" eine Batch-Datei
if [%lang%] == [de] echo mit den korrekten Parametern zum brennen der Firmware erstellen lassen.
if [%lang%] == [de] echo Kopiere diese Datei in den Ordner mit der Firmware.

echo.
if [%lang%] == [en] echo Press "c" to create flash_firmware.bat or "x" to exit.
if [%lang%] == [de] echo Drücke "c" zum Erzeugen von "flash_firmware.bat" oder "x" zum Beenden.
echo.

set batch=
:wrongkey5
choice /C cx /N /M ">"
if errorlevel  1 if not errorlevel  2 set batch=y
if errorlevel  2 if not errorlevel  3 set batch=n
if [%batch%] == [] goto wrongkey5
cls

if not [%batch%] == [y] goto exit

rem ----------------------------------------------------------------------------------------------------------------------------

echo.
if [%lang%] == [en] echo Usually it takes about 260s to flash the firmware.
if [%lang%] == [en] echo Shall we try to flash the chip at a higher speed (30s, SCK period: 0.5 us)? (y/n)
if [%lang%] == [de] echo Normalerweise dauert es knapp 260 Sekunden um die Firmware zu flashen.
if [%lang%] == [de] echo Sollen wir versuchen den Chip mit einer höheren Geschwindigkeit zu flashen (30s, SCK period: 0.5 us)? (j/n)
echo.

set speed=
:wrongkey6
choice /C yjn /N /M ">"
if errorlevel  1 if not errorlevel  2 set speed=y
if errorlevel  2 if not errorlevel  3 set speed=y
if errorlevel  3 if not errorlevel  4 set speed=n
if [%speed%] == [] goto wrongkey6
cls

set parb=
if [%speed%] == [y] set parb=-B1

echo @echo off >flash_firmware.bat
echo cls >>flash_firmware.bat
echo echo. >>flash_firmware.bat
echo echo Upload firmware >>flash_firmware.bat
echo echo. >>flash_firmware.bat
echo for %%%%f in ( Chip-TesterPro-FW-v0.??.hex ) do ( >>flash_firmware.bat
echo     avrdude.exe -C"avrdude.conf" -v -patmega2560 %prog% %comport% %parb% -Uflash:w:%%%%f:i >>flash_firmware.bat
echo ) >>flash_firmware.bat
echo. >>flash_firmware.bat
echo pause >>flash_firmware.bat

:exit
exit

:ver_xp
echo I am sorry. This batch file requires Windows 7 or newer in order to run.
echo Please refer to the manual how to set the fuses manually.
echo.
echo Es tut mir leid, aber diese Batchdatei benötigt mindestens Windows 7.
echo Bitte sieh im Handbuch nach, wie die Fuses manuell gesetzt werden können.
echo.
pause
exit
