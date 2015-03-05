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
ECHO [5] Toggle System's Power State
ECHO     After the user's settings has been backed up successfully, the program can issue a signal to the Operating System to enter a Sleep state, a full Hibernation state, or shutdown the system.
ECHO     NOTE: By default, this is disabled.
REM The variable must be translated into a form that the user can understand
CALL :Settings_NiceValues_PowerState
REM ----
ECHO     - Current Value: [%ProcessVarA%]
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
IF "%STDIN%" EQU "5" GOTO :Settings_Update_PowerState
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



REM # =============================================================================================
REM # Documentation: Inspect the value of the Power State variable (which is an Integer value) and
REM #           translate it to string that the user can easily understand.
REM # =============================================================================================
:Settings_NiceValues_PowerState
IF "%UserConfig.PowerState%" EQU "0" (
    SET "ProcessVarA=Disabled"
    GOTO :EOF
)
IF "%UserConfig.PowerState%" EQU "1" (
    SET "ProcessVarA=Suspend Mode"
    GOTO :EOF
)
IF "%UserConfig.PowerState%" EQU "2" (
    SET "ProcessVarA=Hibernation Mode"
    GOTO :EOF
)
IF "%UserConfig.PowerState%" EQU "3" (
    SET "ProcessVarA=Shutdown"
    GOTO :EOF
) ELSE (
    SET "ProcessVarA=!CRIT_ERR!: Couldn't translate variable 'PowerState' of value [%UserConfig.PowerState%]!
)
EXIT /B 1



REM # =============================================================================================
REM # Documentation: This function will allow the user to change the power settings within this program.
REM #       Obviously this has ABSOLUTELY NO RELATION to the local system's power settings that the OS itself manages.
REM #       Instead, this program will issue a signal to either sleep, shutdown, or hibernate.
REM # =============================================================================================
:Settings_Update_PowerState
CLS
CALL :DashboardOrClassicalDisplay
CALL :QuoteDatabase
ECHO Control Panel: Update Power Settings
ECHO %Separator%
ECHO.
ECHO.
ECHO Power Settings:
ECHO -----------------
ECHO Once the backup has been completed, this program can send a signal to the Operating System to enter into a energy saving power state.  There will be a %UserConfig.PowerStateGraceTime% minute grace period - in which the user can abort the process, but only for commands that support this grace time.
ECHO CRITICAL NOTE: the 'force' flag WILL be used in the signal!
ECHO.
ECHO Currently Set:
CALL :Settings_NiceValues_PowerState
ECHO   %ProcessVarA%
ECHO.
ECHO [1] Keep System Powered On
ECHO       The computer will remain as-is; the Operating System power setting's will still manage the idle state.0
ECHO.
ECHO [2] Suspend State
ECHO       Place the system into sleep mode as soon as the %ProjectName% finishes it's backup process.
ECHO       No grace time will be issued
ECHO.
ECHO [3] Hibernation State
ECHO       Place the entire system into hibernation mode as soon as the %ProjectName% finishes it's backup process.
ECHO.
ECHO [4] Shutdown System
ECHO       Completely shutdown the entire system as soon as the %ProjectName% finishes it's backup process.
ECHO      NOTE for WINDOWS 8 and LATER PC USERS
ECHO            With the 'force' flag being used, the Kernel state will be thrashed.  Meaning, that the OS will have a slower start-up time.  During normal operations, the kernel is cached for a faster start-up.
ECHO.
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :Settings_Update_PowerState_UserInput



REM # =============================================================================================
REM # Documentation: Update the Power Setting's based on the user's feedback.
REM # =============================================================================================
:Settings_Update_PowerState_UserInput
REM Cancel \ Go back to the previous menu
IF /I "%STDIN%" EQU "X" (
    CALL :ClearBuffer
    GOTO :Settings
)
IF /I "%STDIN%" EQU "Cancel" (
    CALL :ClearBuffer
    GOTO :Settings
)
IF /I "%STDIN%" EQU "Exit" (
    CALL :ClearBuffer
    GOTO :Settings
)
REM ----

REM Keep Running; disabled energy saving states
IF "%STDIN%" EQU "1" (
    SET UserConfig.PowerState=0
    CALL :ClearBuffer
    GOTO :Settings
)

REM Suspend Power State
IF "%STDIN%" EQU "2" (
    SET UserConfig.PowerState=1
    CALL :ClearBuffer
    GOTO :Settings
)

REM Hibernation Power State
IF "%STDIN%" EQU "3" (
    SET UserConfig.PowerState=2
    CALL :ClearBuffer
    GOTO :Settings
)

REM Shutdown System
IF "%STDIN%" EQU "4" (
    SET UserConfig.PowerState=3
    CALL :ClearBuffer
    GOTO :Settings
) ELSE (
    REM Incorrect or invalid input
    CALL :BadInput& GOTO :Settings_Update_PowerState
)