@ECHO OFF
COLOR 15

REM Check if it has elevated privileges
NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO Run it as Administrator...
    PING 127.0.0.1 >NUL 2>&1
    EXIT /B 1
)

ECHO ****************************
ECHO **        CMI 2018        **
ECHO ** Made with love by BCGS **
ECHO **************************** & ECHO.
ECHO ----------------------------
ECHO ----- Default Programs -----
ECHO ---------------------------- & ECHO.

REM Disable confirmation prompts 
ECHO Disabling UAC
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 0 /f
ECHO.

REM New variables to hold both the OS architecture and folder's new path
REG Query "HKLM\Hardware\Description\System\CentralProcessor\0" | FIND /i "x86" > NUL && SET OS=32BIT || SET OS=64BIT
IF %OS%==32BIT (SET FOLDER=System32) ELSE (SET FOLDER=SysWOW64)

REM Move the pack to (System32/SysWOW64) folder
MOVE "%~dp0_default_" %WINDIR%\%FOLDER%
SET NEWPATH=%WINDIR%\%FOLDER%\_default_

SET /p "=* Google Chrome " <NUL
REM https://enterprise.google.com/chrome/chrome-browser/
IF %OS%==32BIT (
    MSIEXEC /i %NEWPATH%\googlechromestandaloneenterprise.msi /qb!-
    IF EXIST "C:\Program Files\Google\Chrome" (ECHO (OK^)) ELSE (ECHO (Failed^))
) ELSE (
    MSIEXEC /i %NEWPATH%\googlechromestandaloneenterprise64.msi /qb!-
    IF EXIST "C:\Program Files (x86)\Google\Chrome" (ECHO (OK^)) ELSE (ECHO (Failed^))
)

SET /p "=* PeaZip " <NUL
REM http://www.peazip.org/
IF %OS%==32BIT (
    START /wait %NEWPATH%\peazip-6.6.0.WINDOWS.exe /VERYSILENT
) ELSE (
    START /wait %NEWPATH%\peazip-6.6.0.WIN64.exe /VERYSILENT
)
IF EXIST "C:\Program Files\PeaZip" (ECHO (OK^)) ELSE (ECHO (Failed^))

SET /p "=* CDBurnerXP " <NUL
REM https://cdburnerxp.se/en/download
IF %OS%==32BIT (
    START /wait %NEWPATH%\cdbxp_setup_4.5.8.6795.exe /SILENT /ACCEPTEULA=1
) ELSE (
    START /wait %NEWPATH%\cdbxp_setup_4.5.8.6795_x64.exe /SILENT /ACCEPTEULA=1
)
IF EXIST "C:\Program Files\CDBurnerXP" (ECHO (OK^)) ELSE (ECHO (Failed^))

SET /p "=* VLC media player " <NUL
REM https://www.videolan.org/vlc/download-windows.html
IF %OS%==32BIT (
    START /wait %NEWPATH%\vlc-3.0.3-win32.exe /L=1046 /S
) ELSE (
    START /wait %NEWPATH%\vlc-3.0.3-win64.exe /L=1046 /S
)
IF EXIST "C:\Program Files\VideoLAN\VLC" (ECHO (OK^)) ELSE (ECHO (Failed^))

SET /p "=* Acrobat Reader DC " <NUL
REM https://get.adobe.com/reader/enterprise/
START /wait %NEWPATH%\AcroRdrDC1800920044_pt_BR.exe /sALL
IF %OS%==32BIT (
    IF EXIST "C:\Program Files\Adobe" (ECHO (OK^)) ELSE (ECHO (Failed^))
) ELSE (
    IF EXIST "C:\Program Files (x86)\Adobe" (ECHO (OK^)) ELSE (ECHO (Failed^))
)

SET /p "=* Java 8u181 " <NUL
REM https://www.java.com/en/download/manual.jsp
START /wait %NEWPATH%\jre-8u181-windows-i586.exe /s
IF %OS%==32BIT (
    IF EXIST "C:\Program Files\Java" (ECHO (OK^)) ELSE (ECHO (Failed^))
) ELSE (
    START /wait %NEWPATH%\jre-8u181-windows-x64.exe /s
    IF EXIST "C:\Program Files (x86)\Java" (
        IF EXIST "C:\Program Files\Java" (ECHO (OK^)) ELSE (ECHO (Failed^))
    ) ELSE ECHO (Failed^)
)

SET /p "=* WPS Office " <NUL
REM https://www.wps.com/download/
START /wait %NEWPATH%\setup_XA_mui_10.2.0.5996_Free_100.103.exe /S /ACCEPTEULA=1
IF EXIST "%UserProfile%\AppData\Local\Kingsoft\WPS Office" (ECHO (OK^)) ELSE (ECHO (Failed^))

SET /p "=* Avira " <NUL
REM https://www.avira.com/pt-br/free-antivirus-windows#start-download-av
REM ** PS: Cannot fully install this boy silently. Consider opening it afterwards **
START /wait %NEWPATH%\avira_ptbr_av_5a6e51e342864__ws.exe /S /v/qn
IF %OS%==32BIT (
    IF EXIST "C:\Program Files\Avira" (ECHO (OK^)) ELSE (ECHO (Failed^))
) ELSE (
    IF EXIST "C:\Program Files (x86)\Avira" (ECHO (OK^)) ELSE (ECHO (Failed^))
)
ECHO.

ECHO ------------------------------------------
ECHO --             Temp Program             --
ECHO -- Do not forget to remove it afterward --
ECHO ------------------------------------------ & ECHO.

SET /p "=* Driver Booster 5 " <NUL
REM https://www.iobit.com/pt/driver-booster.php
START /wait %NEWPATH%\driver_booster_setup.exe /VERYSILENT
IF %OS%==32BIT (
    IF EXIST "C:\Program Files\IObit" (ECHO (OK^)) ELSE (ECHO (Failed^))
) ELSE (
    IF EXIST "C:\Program Files (x86)\IObit" (ECHO (OK^)) ELSE (ECHO (Failed^))
)
ECHO.

REM Re-enable confirmation prompts 
ECHO Re-enabling UAC
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 5 /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
REG add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f

REM Delete folder
RD /s /q %NEWPATH%

ECHO.
PAUSE

REM Exit & delete this file
DEL "%~f0"&EXIT /B