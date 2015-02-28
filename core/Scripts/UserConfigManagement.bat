REM =====================================================================
REM User Configuration Manager
REM ----------------------------
REM This script allows the user to store and manage their own preset configuration that is located in the [ %DirSavePresets% - variable ].  These configurations files contains the user's personal settings that is used within this program, and is remotely handled within the Initialization block.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Check to make sure that the Preset directory [ %DirSavePresets% ] exists within the filesystem, if it does not - then simply create the directory.
REM # =============================================================================================
:UserConfigurationDirectoryInspect
IF NOT EXIST "%DirSavePresets%" MKDIR "%DirSavePresets%" || ECHO !ERR_CRIT!: Could not create directory [ %DirSavePresets% ] within the local filesystem!
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display what batch scripts were detected within the preset directory.
REM # =============================================================================================
:UserConfigurationDirectoryViewer
DIR /B "%DirSavePresets%" | FINDSTR /E /I ".bat" || ECHO !ERR: Could not find the directory or files!&
GOTO :EOF



REM # =============================================================================================
REM # Documentation: User preset configuration menu
REM # =============================================================================================
:UserConfiguration
CALL :DashboardDisplay
REM Check the preset config. menu.
CALL :UserConfigurationDirectoryInspect
ECHO User Configuration Menu
ECHO.
ECHO Preset Directory: %DirSavePresets%
ECHO %SeparatorLong%
REM Preview of all of the scripts found
CALL :UserConfigurationDirectoryViewer
ECHO %SeparatorLong%
ECHO.&ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] Load Settings
ECHO [2] Save Settings
ECHO [R] Refresh List
ECHO [D] Remove a Saved Configuration
ECHO [X] Return to Main Menu
CALL :UserInput
GOTO :UserConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:UserConfiguration_UserInput
REM Read the STDIN and process it
IF "%STDIN%" EQU "1" (
    CALL :UserConfiguration_SelectFile Load
    CALL :EnvironmentSetup_Switch UserConfigLoad
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "Load" (
    CALL :UserConfiguration_SelectFile Load
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF "%STDIN%" EQU "2" (
    CALL :UserConfiguration_SelectFile Save
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "Save" (
    CALL :UserConfiguration_SelectFile Save
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "R" (
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "Refresh" (
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "D" (
    CALL :UserConfiguration_SelectFile Delete
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "Delete" (
    CALL :UserConfiguration_SelectFile Delete
    CALL :ClearBuffer 1
    GOTO :UserConfiguration
)
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :UserConfiguration



REM # =============================================================================================
REM # Parameters: [{String} Mode]
REM # Documentation: This is a central point when the user wants to either select a file or create a new preset configuration file.
REM # =============================================================================================
:UserConfiguration_SelectFile
ECHO.
ECHO %1 Mode Selected
ECHO %Separator%
ECHO NOTE: Do not include the ^'.bat^' file extension.
ECHO.
ECHO Other Options:
ECHO [Cancel]
ECHO.
ECHO Enter a filename:
CALL :UserInput
CALL :UserConfiguration_SelectFile_UserInput %1
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} Mode]
REM # Documentation: Inspect the user's input and determine what action to perform.
REM # =============================================================================================
:UserConfiguration_SelectFile_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM Cache the users input into a working variable
CALL :UserConfiguration_SelectFile_CacheFileName
REM Fix the STDIN variable if necessary
CALL :UserConfiguration_SelectFile_UpdateVariable
REM Save mode
IF %1 EQU Save CALL :UserConfiguration_ChoiceSave& GOTO :EOF
REM Load mode
IF %1 EQU Load CALL :UserConfiguration_ChoiceLoad& GOTO :EOF
REM Expunge mode
IF %1 EQU Delete CALL :UserConfiguration_ChoiceThrash& GOTO :EOF
GOTO :EOF



REM # =============================================================================================
REM # Documentation: If incase the user did not input the file extension, add it for them.
REM # =============================================================================================
:UserConfiguration_SelectFile_UpdateVariable
SET "STDIN=%STDIN%.bat"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Cache the filename in a temporary working variable; this can be used later - such as defining the filename properly.
REM # =============================================================================================
:UserConfiguration_SelectFile_CacheFileName
SET "ProcessVarA=%STDIN%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Load the configuration file into the current environment.
REM # =============================================================================================
:UserConfiguration_ChoiceLoad
IF /I EXIST "%DirSavePresets%\%STDIN%" (
    CALL "%DirSavePresets%\%STDIN%"
    GOTO :EOF
) ELSE (
    ECHO !ERR: Filename could not be found!
    PAUSE
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: Save a new configuration file into the filesystem.
REM # =============================================================================================
:UserConfiguration_ChoiceSave
REM Does the file already exist within the filesystem?
IF /I EXIST "%DirSavePresets%\%STDIN%" (
    ECHO !ERR: File named '%STDIN%' already exists!
    PAUSE
    GOTO :EOF
)
CALL :UserConfiguration_CreateSave "%DirSavePresets%\%STDIN%"
REM Load the configuration, this will load the keychain ID and config name into memory.
CALL :UserConfiguration_ChoiceLoad "%DirSavePresets%\%STDIN%"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} FullPathFileName]
REM # Documentation: Create the header information into the file.
REM # =============================================================================================
:UserConfiguration_CreateSave
REM Notice: This first statement will OVERWRITE the ASCII file!
(ECHO @ECHO OFF) > "%~1"
(ECHO ECHO User Saved Configuration Generated using %ProgramName% Version %ProgramVersion% [%CodeName%]) >> "%~1"
(ECHO ECHO Date created: %Date% - %Time% by %UserName% on system %ComputerName%) >> "%~1"
(ECHO SET UserConfigurationLoaded=%ProcessVarA%) >> "%~1"
(ECHO SET UserConfigurationKeyChainToken=%RANDOM%) >> "%~1"
ECHO REM %SeparatorLong%>> "%~1"
ECHO REM %SeparatorLong%>> "%~1"
(ECHO.) >> "%~1"
REM To avoid redundancy and mistakes of forgotten variables, we'll utilize the EnvironmentSetup functions.
CALL :EnvironmentSetup_Switch UserConfigSave
(ECHO GOTO :EOF) >> "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Expunge a preset configuration file from the filesystem.
REM # =============================================================================================
:UserConfiguration_ChoiceThrash
IF /I EXIST "%DirSavePresets%\%STDIN%" (
    REM Prompt the user for confirmation before deleting the file.
    DEL /P "%DirSavePresets%\%STDIN%"
    GOTO :EOF
) ELSE (
    ECHO !ERR: Filename could not be found!
    PAUSE
    GOTO :EOF
)