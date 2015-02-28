REM =====================================================================
REM Control Panel: 7Zip Configuration
REM ----------------------------
REM Within this section, this will allow the user to customize available settings for 7Zip software.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Settings menu for 7Zip Configuration
REM # =============================================================================================
:ControlPanel_7Zip
CALL :DashboardDisplay
ECHO 7Zip Configuration Menu
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] Password
ECHO [2] Toggle Password
ECHO [3] Archive
ECHO [4] Compression Depth
ECHO [5] Copy Format
ECHO [6] Multithread
ECHO [7] Encryption Algorithm
ECHO [8] Verification
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Exit
CALL :UserInput
GOTO :ControlPanel_7Zip_Menu_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_7Zip_Menu_UserInput
IF "%STDIN%" EQU "1" GOTO :ControlPanel_7Zip_Menu_Choice_Password
IF "%STDIN%" EQU "2" GOTO :ControlPanel_7Zip_Menu_Choice_TogglePassword
IF "%STDIN%" EQU "3" GOTO :ControlPanel_7Zip_Menu_Choice_Archive
IF "%STDIN%" EQU "4" GOTO :ControlPanel_7Zip_Menu_Choice_Compression
IF "%STDIN%" EQU "5" GOTO :ControlPanel_7Zip_Menu_Choice_CopyAlgorithm
IF "%STDIN%" EQU "6" GOTO :ControlPanel_7Zip_Menu_Choice_Multithread
IF "%STDIN%" EQU "7" GOTO :ControlPanel_7Zip_Menu_Choice_Encryption
IF "%STDIN%" EQU "8" GOTO :ControlPanel_7Zip_Menu_Choice_Verify
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for setting a new archive password.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Password
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_Password
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for enabling or disabling the archive password.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_TogglePassword
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_TogglePassword
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for changing the archive file format.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Archive
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_ArchiveFormat
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for changing the compression rate.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Compression
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_Compression
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for changing the copying algorithm.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_CopyAlgorithm
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_CopyAlgorithm
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for allowing or disallowing multiple thread processing.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Multithread
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_Multithread
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for changing the encryption algorithm.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Encryption
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_Encryption
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip



REM # =============================================================================================
REM # Documentation: Call the 7Zip setting for changing the archive file type.
REM # =============================================================================================
:ControlPanel_7Zip_Menu_Choice_Verify
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip_Verify
CALL :ClearBuffer 1
GOTO :ControlPanel_7Zip