REM =====================================================================
REM Settings Menu
REM ----------------------------
REM This allows the user to manipulate some settings that is available in this module script.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Main Control Panel
REM # =============================================================================================
:Settings
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO Control Panel
ECHO %Separator%
ECHO.
ECHO [1] Encrypt Backup Compact Files with Password
ECHO     When set to 'True', this will allow the program encrypt the compact data with a password that was set within the 'Bootless Star' configuration.
ECHO     - Current Value: [%UserConfig.7ZipUseKey%]
ECHO.
ECHO [2] Back to the Future Quotes
ECHO     When set to 'True', this will allow the program display quotes from the movie 'Back to the Future'.
ECHO     - Current Value: [%UserConfig.BackToTheFutureQuotes%]
ECHO.
ECHO [3] Change Local Directory Location
ECHO     This allows the ability to change the %ProjectName%'s Local Directory current destination to another specific location.  Ideally, this should be used on a dedicated secondary storage [HDD preferred] that is only used for system backups.
ECHO     NOTE: This will NOT transition the current data that is stored within the local directories to the new destination!
ECHO     - Current Value: [%LocalDirectory.MainRoot%]
ECHO.
ECHO [4] Exclude Videos from Backup
ECHO     When set to 'True', this will forbid the program from backing up the user's Videos.
ECHO         Directories that will be excluded: ~\Videos, ~\My Videos, ~\Movies, ~\My Movies
ECHO     - Current Value: [%UserConfig.ExcludeVideos%]
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [U] Update Saved Profile named: %UserConfigurationLoaded%
ECHO [X] Exit
CALL :UserInput
GOTO :Settings_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:Settings_UserInput
IF "%STDIN%" EQU "1" GOTO :Settings_Toggle_EncryptKey
IF "%STDIN%" EQU "2" GOTO :Settings_Toggle_BackToTheFutureQuotes
IF "%STDIN%" EQU "3" GOTO :Settings_Update_LocalDirectory
IF "%STDIN%" EQU "4" GOTO :Settings_Toggle_ExcludeVideosBackup
IF /I "%STDIN%" EQU "U" GOTO :Settings_UpdateProfile
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :Settings



REM # =============================================================================================
REM # Documentation: Allow the program to encrypt the archives with a password that was defined from the environment program?
REM # =============================================================================================
:Settings_Toggle_EncryptKey
IF %UserConfig.7ZipUseKey% EQU True (
    SET UserConfig.7ZipUseKey=False
) ELSE (
    SET UserConfig.7ZipUseKey=True
)
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Allow the program to display Back to the Future movie quotes?
REM # =============================================================================================
:Settings_Toggle_BackToTheFutureQuotes
IF %UserConfig.BackToTheFutureQuotes% EQU True (
    SET UserConfig.BackToTheFutureQuotes=False
) ELSE (
    SET UserConfig.BackToTheFutureQuotes=True
)
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Allow the program to exclude the users typical video directories from backup.
REM # =============================================================================================
:Settings_Toggle_ExcludeVideosBackup
IF %UserConfig.ExcludeVideos% EQU True (
    SET UserConfig.ExcludeVideos=False
) ELSE (
    SET UserConfig.ExcludeVideos=True
)
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: User Configuration Settings
REM # =============================================================================================
:Settings_UpdateProfile
CALL :ClearBuffer
CALL :UserPreset_Driver 1
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Allow the user to update the program's Local Directory to a new destination.  This will be helpful to allow the user to keep the backups to a specific HDD.
REM # =============================================================================================
:Settings_Update_LocalDirectory
CLS
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO Control Panel: Update Local Directory Location
ECHO %Separator%
ECHO.
ECHO This allows the ability to change the %ProjectName%'s Local Directory current destination to another specific location.  Ideally, this should be used on a dedicated secondary storage [Hard Drive preferred] that is only used for system backups.  But, however, after a new location has been defined, this program will _NOT_ transition the current data that is stored within the local directories to the new destination!
ECHO.
ECHO Current Location:
ECHO    %LocalDirectory.MainRoot%
ECHO.
ECHO Define a new location:
ECHO.
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [Cancel] [Restore]
CALL :UserInput
GOTO :Settings_Update_LocalDirectory_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users decision about updating the local directory location
REM # =============================================================================================
:Settings_Update_LocalDirectory_UserInput
IF /I "%STDIN%" EQU "Cancel" (
    CALL :ClearBuffer
    GOTO :Settings
)
IF /I "%STDIN%" EQU "Restore" (
    REM We do NOT need to 'create' the directories, as the program will do this anyways at the start-up protocol.
    CALL :Initialization_Driver RestoreLocalDirectoryLocation
    CALL :ClearBuffer
    GOTO :Settings
) ELSE (
    CALL :Settings_Update_LocalDirectory_UserInput_Validate
    CALL :ClearBuffer
    GOTO :Settings
)



REM # =============================================================================================
REM # Documentation: Update the local directory location protocol
REM # =============================================================================================
:Settings_Update_LocalDirectory_UserInput_Validate
REM Clean the user's input from trailing slashes
CALL :Settings_Update_LocalDirectory_UserInput_Validate_CleanSTDIN
REM Store the value in a working var -- mainly a work around for pushing errors with parameters
SET "ProcessVarA=%STDIN%"
REM Does the path actually exists?  If not, opt-out immediately
CALL :Settings_Update_LocalDirectory_UserInput_Validate_CheckExists || (CALL :Settings_Update_LocalDirectory_UserInput_Validate_CheckExistsErr& EXIT /B 1)
REM ----
REM -------  Changes
REM Update the Local Directory identifiers
CALL :Initialization_Driver UpdateLocalDirectoryLocation "%ProcessVarA%"
REM Create the new local directories at the specified location
CALL :Prerequisite_Driver || (CALL :Initialization_Driver RestoreLocalDirectoryLocation& EXIT /B 1)
REM -------
REM ----
EXIT /B 1




REM # =============================================================================================
REM # Documentation: Filter any trailing back-slashes from the STDIN.
REM # =============================================================================================
:Settings_Update_LocalDirectory_UserInput_Validate_CleanSTDIN
REM Using the variable value, read the last character from the value.  -1 == One character from the right side
IF "%STDIN:~-1%" EQU "\" (
    REM Select the range, the -1 means we are limiting the right side; we're effectively dropping 'one' character.
    SET "STDIN=%STDIN:~0,-1%"
) ELSE (
    GOTO :EOF
)
REM If incase the user adds more of the back slashes for whatever reason, call the function again until it is fixed.
GOTO :Settings_Update_LocalDirectory_UserInput_Validate_CleanSTDIN



REM # =============================================================================================
REM # Parameters: [{String} DirectoryPath]
REM # Documentation: Check if the destination path exists
REM # =============================================================================================
:Settings_Update_LocalDirectory_UserInput_Validate_CheckExists
IF EXIST "%ProcessVarA%" (
    REM It exists, return a 0
    EXIT /B 0
) ELSE (
    REM return an error signal
    EXIT /B 1
)



REM # =============================================================================================
REM # Parameters: [{String} DirectoryPath]
REM # Documentation: Error Message when the Check Exists sends an error signal
REM # =============================================================================================
:Settings_Update_LocalDirectory_UserInput_Validate_CheckExistsErr
ECHO !ERR!: The specified path "%ProcessVarA%" does not exists!
PAUSE
GOTO :EOF