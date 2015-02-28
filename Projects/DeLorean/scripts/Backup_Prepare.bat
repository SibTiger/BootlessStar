REM =====================================================================
REM Backup: Backup Preparations
REM ----------------------------
REM In this section, the program will merely setup any last minute updates\configurations and anything else that is required for the backup process.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Within this section, we're preparing the entire backup process.
REM # =============================================================================================
:Backup_Prepare
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Preparing backup process"
REM Print on the screen that the program is preparing
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Initialize some runtime variables
CALL :Backup_Prepare_Initializations
REM ----
REM Generate the exclusions list
CALL :Backup_Prepare_BuildExclusionList_Manager "%Backup_ExclusionList%" || EXIT /B 1
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Parameters: [{string}FileName]
REM # Documentation: Here, this will easily guide the process of generating the exclusions list for 7Zip
REM # =============================================================================================
:Backup_Prepare_BuildExclusionList_Manager
CALL :Operation_Display_IncomingTaskSubLevel "Building Exclusions list"
CALL :Backup_Prepare_BuildExclusionList "%~1"
CALL :Backup_Prepare_BuildExclusionList_UserVideos "%~1"
CALL :Backup_Prepare_BuildExclusionList_FileCheck "%~1" || (CALL :ResourceErrorSignal "%~1"& EXIT /B 1)
EXIT /B 0



REM # =============================================================================================
REM # Parameters: [{string}FileName]
REM # Documentation: This will create an exclusion list that is going to be used with 7Zip.  This will avoid 7Zip from accessing nasty directories that it does not yet support -- junction pointers.  The list will always be built to assure that %USERNAME% is accurate; the location will be in the temporary directory.
REM #   Note: As 7Zip doesn't work with absolute paths when excluding files or directories, we have to assume the user name given in %UserProfile% matches in %UserName%.
REM # =============================================================================================
:Backup_Prepare_BuildExclusionList
CALL :Operation_Display_IncomingTaskSubLevelMSG "Generating Exclusion list"
(ECHO "%USERNAME%\Application Data")>> "%~1"
(ECHO "%USERNAME%\AppData")>> "%~1"
(ECHO "%USERNAME%\Cookies")>> "%~1"
(ECHO "%USERNAME%\Local Settings")>> "%~1"
(ECHO "%USERNAME%\My Documents")>> "%~1"
(ECHO "%USERNAME%\NetHood")>> "%~1"
(ECHO "%USERNAME%\PrintHood")>> "%~1"
(ECHO "%USERNAME%\Recent")>> "%~1"
(ECHO "%USERNAME%\Searches")>> "%~1"
(ECHO "%USERNAME%\SendTo")>> "%~1"
(ECHO "%USERNAME%\Start Menu")>> "%~1"
(ECHO "%USERNAME%\Templates")>> "%~1"
(ECHO "%USERNAME%\NTUSER.DAT*")>> "%~1"
(ECHO "%USERNAME%\ntuser.ini")>> "%~1"
(ECHO "%USERNAME%\SkyDrive")>> "%~1"
(ECHO "%USERNAME%\OneDrive")>> "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string}FileName]
REM # Documentation: This will add-on more directories to also exclude; if the user decides to exclude their video directories.
REM # =============================================================================================
:Backup_Prepare_BuildExclusionList_UserVideos
CALL :Operation_Display_IncomingTaskSubLevelMSG "Adding video directories to the exclusion list"
REM ----
REM Does the user really want to exclude their videos from the backup procedure?
IF %UserConfig.ExcludeVideos% EQU False (
    REM The user wants their videos backed up.
    CALL :Operation_Display_IncomingTaskSubLevelMSG "Skipping; user requested"
    GOTO :EOF
)
REM ----
(ECHO "%USERNAME%\Videos")>> "%~1"
(ECHO "%USERNAME%\My Videos")>> "%~1"
(ECHO "%USERNAME%\MyVideos")>> "%~1"
(ECHO "%USERNAME%\Movies")>> "%~1"
(ECHO "%USERNAME%\My Movies")>> "%~1"
(ECHO "%USERNAME%\MyMovies")>> "%~1"
GOTO :EOF


REM # =============================================================================================
REM # Parameters: [{string}FileName]
REM # Documentation: This small function merely makes sure that the exclusions list was created within the filesystem.
REM # =============================================================================================
:Backup_Prepare_BuildExclusionList_FileCheck
CALL :Operation_Display_IncomingTaskSubLevelMSG "Making sure the exclusion list '%~1' exists"
IF NOT EXIST "%~1" (
    EXIT /B 1
) ELSE (
    EXIT /B 0
)



REM # =============================================================================================
REM # Documentation: This function will update any mutable variables that is needed within the entire backup process.
REM # =============================================================================================
:Backup_Prepare_Initializations
CALL :Operation_Display_IncomingTaskSubLevel "Initializing RunTime mutable variables"
SET "Output=%LocalDirectory.Backup%\%Backup_FileName%"
SET "Backup_ExclusionList=%LocalDirectory.Temp%\exclusions.txt"
GOTO :EOF