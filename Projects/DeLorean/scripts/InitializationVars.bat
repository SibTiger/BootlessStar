REM =====================================================================
REM Module Initialization Driver
REM ----------------------------
REM This section will manage how to either initialize identifiers for the module environment or if the configuration needs to be saved to a preset file.
REM =====================================================================


REM # =============================================================================================
REM # Parameters: [{String} Mode] [{String} Options] [{String} TargetPath]
REM # Documentation: This function, depending how it is called - which is set by the first parameter [MODE], will help set up the environment for the program, create or update a user configuration, or update the project resource targets [plugins, directories, etc].
REM # =============================================================================================
:Initialization_Driver
REM This driver requires parameters:
REM     [Mode] (OPTIONS) (PATH)
REM When starting the program, this function will be executed.
IF %1 EQU Load (
    REM Parameters: [Mode = Load]
    REM Load the environment field when starting up the program or when this block is executed.
    CALL :Initialization_IdentifiersStatic
    CALL :Initialization_IdentifiersUserSettings 0
    CALL :Initialization_LocalDirectories 2
    CALL :UserPreset_Driver 0
    CALL :Initialization_UpdateLogging
    GOTO :EOF
)
IF %1 EQU SaveUserConfig (
    REM Parameters: [Mode = SaveUserConfig] [File to Output]
    REM Write the current user configuration that is in current active memory and write it to a file.
    CALL :Initialization_IdentifiersUserSettings 1 "%~2"
    CALL :Initialization_LocalDirectories 1 "%~2"
    GOTO :EOF
)
IF %1 EQU UpdateLocalDirectoryLocation (
    REM Parameters: [Mode = UpdateLocalDirectoryLocation] [New Path]
    REM Change the Local Directories default location to a user specified
    CALL :Initialization_LocalDirectories 3 "%~2"
    GOTO :EOF
)
IF %1 EQU RestoreLocalDirectoryLocation (
    REM Parameters: [Mode = RestoreLocalDirectoryLocation]
    REM Revert the local directories default location
    CALL :Initialization_LocalDirectories 2
    GOTO :EOF
)
IF %1 EQU UpdateLocalDirectorySubLocation (
    REM This is used when loading from a save preset, just re-flash the local sub directory variables.
    REM  With the way that this is designed, it is a bit wasteful of resources.
    CALL :Initialization_LocalDirectories 0
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function sets the static environment for the module, and other variables that is self managed 1ithin the program.
REM # =============================================================================================
:Initialization_IdentifiersStatic
REM Static Variables
SET ProjectName=DeLorean
SET ProjectVersion=5.1.2
SET ReleaseDate=26.October.2014
REM This sets up the archive based name, this is used for the backup process.
SET "Backup_FileName=Backup-[%ComputerName%]_%core.Date%"
REM The general output file name for the restore and backup process
SET Output=UNKNOWN
REM This variable houses the source target; this is primarily for restoring functionality.
SET Source=UNKNOWN
REM This variable holds the archive's encryption password, this is primarily used for the Restoring functionality.
SET ArchivePassword=UNKNOWN
REM 7Zip Exclusion List, used to avoid 7Zip from accessing junction loops.
SET Backup_ExclusionList=UNKNOWN
REM Error Signal for Operations; if the value is not null, there was a general issue with a function or functions in sequence.
SET ErrorSignal=0
REM Exit Code captures ErrorLevel - but retains the xid.
SET ExitCode=0
REM Fatal Exit retains the exit code from the lower level [spine of the program]; if there is an error from the lower level, then this variable will be updated.
SET FatalExit=0
REM What internal or external CMD was called, this is going to be used primarily for logs and error messages.  Make this easy for the user to understand what program was called, do not make it complicated.
SET TaskCaller_NiceProgramName=NULL
REM Compiled version of 'TaskCaller' into one string.
SET TaskCaller_CallLong=NULL
REM This houses the parameters for 7Zip, this gets filled when we need to invoke it.
SET SevenZipCompactParameters=-
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET DriversNiceTask=UNKNOWN
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{Int} Mode] IF MODE = 3 "[{String} LocalDirectoryPath]" OR IF MODE = 2 "[{String} UserConfigOutput]"
REM # Documentation: This function will set the Local Directory targets.  These local directories are necessary for the program to work correctly.
REM #  First Parameter:
REM #   0 = Read\Load
REM #   1 = Write to specific file
REM #   2 = Use Default Root Path
REM #   3 = Use New Root Path
REM #  Second Parameter:
REM #   Output File
REM # =============================================================================================
:Initialization_LocalDirectories
REM Note: DirLocal is merely a simple dedicated directory for output data and saved data.
REM ----
REM Output to a save file
IF %1 EQU 1 (ECHO REM Local Directory [root])>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
IF %1 EQU 1 (ECHO SET "LocalDirectory.MainRoot=%LocalDirectory.MainRoot%")>> "%~2"
IF %1 EQU 1 GOTO :EOF
REM ----

REM Main root
REM ----
REM Default Root
IF %1 EQU 2 (SET "LocalDirectory.MainRoot=%DirProjects%\%ProjectName%")
REM Update the Root
IF %1 EQU 3 (SET "LocalDirectory.MainRoot=%~2\%ProjectName%")
REM ----

REM Special Cases
REM ----
REM Preset Configurations -- DO NOT UPDATE THIS IF THE USER CHANGES THE PATH!
IF %1 EQU 2 (SET "LocalDirectory.UserConfig=%LocalDirectory.MainRoot%\Config")
REM ----
REM Temporary data
SET "LocalDirectory.Temp=%LocalDirectory.MainRoot%\Temp"
REM Backup Database
SET "LocalDirectory.Backup=%LocalDirectory.MainRoot%\Backup"
REM Restored Database
SET "LocalDirectory.Restore=%LocalDirectory.MainRoot%\Restore"
REM Log Files
SET "LocalDirectory.Logs=%LocalDirectory.MainRoot%\Log"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{Int} Mode] [{String} UserConfigOutput]
REM # Documentation: This function houses the users settings and customizations; this manages both loading and writing to a file, depending on the argument when this function is called.
REM #  First Parameter:
REM #   0 = Read\Load
REM #   1 = Write to specific file
REM #  Second Parameter:
REM #   Output File
REM # =============================================================================================
:Initialization_IdentifiersUserSettings
REM --------------------------------
REM ================================
IF %1 EQU 1 (ECHO.)>> "%~2"
REM 7Zip Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM 7Zip Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Encrypt compressed data with a password?
IF %1 EQU 0 (SET UserConfig.7ZipUseKey=False)
IF %1 EQU 1 (ECHO REM Encrypt compressed data with a password?)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.7ZipUseKey=%UserConfig.7ZipUseKey%)>> "%~2"
REM ----


IF %1 EQU 1 (ECHO.)>> "%~2"
REM Program Management Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM Program Management Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Allow the program to display random quotes from the Back to the Future?
IF %1 EQU 0 SET UserConfig.BackToTheFutureQuotes=True
IF %1 EQU 1 (ECHO REM Allow the program to display random quotes from the Back to the Future?)>> "%~2"
IF %1 EQU 1 (ECHO SET "UserConfig.BackToTheFutureQuotes=%UserConfig.BackToTheFutureQuotes%")>> "%~2"
REM ----
REM Exclude the user's videos directories from backup?
IF %1 EQU 0 SET UserConfig.ExcludeVideos=False
IF %1 EQU 1 (ECHO REM Allow the program to exclude backing up the users video directories [~\Videos, ~\My Videos, ~\My Movies, ~\Movies])>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.ExcludeVideos=%UserConfig.ExcludeVideos%)>> "%~2"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the log file name, if logging is enabled.
REM # =============================================================================================
:Initialization_UpdateLogging
IF "%ToggleLog%" NEQ "False" SET "STDOUT=%LocalDirectory.Logs%\%ProjectName%_%core.Date%.txt"
GOTO :EOF