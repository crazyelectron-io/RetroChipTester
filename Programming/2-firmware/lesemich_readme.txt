There are three(!) ways to flash the firmware:

1. flash_firmware_(please_edit).bat
   Edit this file and change the parameters according to the programmer you are using.
   
2. winflash.bat
   Drop the firmware (hex) file on this batchfile. The file will ask you for the parameters.
   
3. When using the flash_fuses.bat you are asked (at the end) if it should create a
   batch file for you that allows to flash the firmware (flash_firmware.bat).
   When you move that file into this folder it will flash the firmware immediately (the 
   correct parameters are already set).
   
-------------------------------------------------------------------------------------------
Es gibt drei (!) Möglichkeiten, die Firmware zu flashen:

1. flash_firmware_(please_edit).bat
    Bearbeiten Sie diese Datei und ändern Sie die Parameter entsprechend dem von Ihnen 
	verwendeten Programmierer.
   
2. winflash.bat
    Legen Sie die Firmware-Datei (HEX) auf dieser Batchdatei ab. Die Datei fragt nach den 
	notwendigen Parametern.
   
3. Wenn Sie die Datei flash_fuses.bat verwenden, werden Sie (am Ende) gefragt, ob eine
    Batchdatei erstellt werden soll, die das Flashen der Firmware ermöglicht (flash_firmware.bat).
    Wenn Sie diese Datei in diesen Ordner verschieben, kann die Firmware direkt damit geflasht 
	werden (die richtige Parameter sind bereits eingestellt).
