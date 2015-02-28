REM =====================================================================
REM Backup: Check Resources
REM ----------------------------
REM This section merely makes sure that everything is ready for the backup operation.  If this fails, the entire operation ends.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function will make sure that the all of the resources that are necessary for this program are available and ready.  If there is _one_ issue, terminate the program - unless it is possible to _assume_ settings automatically.
REM # =============================================================================================
:Backup_CheckResources
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Running Self-Check"
REM Print on the screen that the program is trying to self-check
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Check if the User's profile can be detected
CALL :Backup_CheckResources_Profile || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Check if 7Zip can be detected
CALL :Backup_CheckResources_7Zip || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Does a backup archive already exists?
CALL :Backup_CheckResources_AlreadyExists || (CALL :CaughtIssueSignal& EXIT /B 1)
REM ----
REM Print the footer in the log.
CALL :Operation_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Check to see if the user's Profile [or home directory] exists
REM # =============================================================================================
:Backup_CheckResources_Profile
CALL :Operation_Display_IncomingTaskSubLevel "Checking if %UserName%'s Home Directory directory exists"
IF NOT EXIST "%UserProfile%" (
    REM We can't find the user's Home Directory
    CALL :Backup_CheckResources_Profile_ERR
    EXIT /B 1
)
REM We can find the Home Directory
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Could not find the user's home directory.  Print the message on the terminal - and log it.
REM # =============================================================================================
:Backup_CheckResources_Profile_ERR
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: Could not locate %UserName%'s profile [or Home Directory]!"
CALL :Operation_Display_IncomingTaskSubLevelMSG "This program can not continue until this issue has been resolved!"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the 7Zip software was detected from the core.
REM # =============================================================================================
:Backup_CheckResources_7Zip
CALL :Operation_Display_IncomingTaskSubLevel "Checking if 7Zip was detected"
IF %Detect_7Zip% EQU False (
    REM We couldn't find the 7Zip software
    CALL :Backup_CheckResources_7Zip_ERR
    EXIT /B 1
)
REM Detected 7Zip
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Could not find the 7Zip application.  Print the message on the terminal - and log it.
REM # =============================================================================================
:Backup_CheckResources_7Zip_ERR
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: Could not find 7Zip software!"
CALL :Operation_Display_IncomingTaskSubLevelMSG "This program can not continue until this issue has been resolved!"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the archive does not already exist
REM # =============================================================================================
:Backup_CheckResources_AlreadyExists
CALL :Operation_Display_IncomingTaskSubLevel "Checking if an archive with name [ %Output% ] already exists"
IF EXIST "%Output%" (
    CALL :Backup_CheckResources_AlreadyExists_Message
    CALL :Backup_CheckResources_AlreadyExists_Prompt || EXIT /B 1
    EXIT /B 0
)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Display [and log it] to the user that the archive already exists
REM # =============================================================================================
:Backup_CheckResources_AlreadyExists_Message
CALL :Operation_Display_IncomingTaskSubLevelMSG "!ERR_CRIT!: Found an already existing file [ %Output% ]!"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Prompt the user of their choices of this slight issue; they can cancel out or delete the archive file and generate a new backup.
REM # =============================================================================================
:Backup_CheckResources_AlreadyExists_Prompt
ECHO.&ECHO.
ECHO ^<!^>       ERROR       ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO Found an already existing backup archive file!
ECHO.
ECHO Options:
ECHO %SeparatorSmall%
ECHO [Delete]
ECHO Any other key will mean 'Cancel'.
CALL :UserInput
GOTO :Backup_CheckResources_AlreadyExists_Prompt_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input; if they explicitly put "Delete", then the archive file gets expunged and the program will continue, otherwise - we stop.
REM # =============================================================================================
:Backup_CheckResources_AlreadyExists_Prompt_UserInput
IF /I "%STDIN%" EQU "Delete" (
    CALL :Backup_CheckResources_AlreadyExists_Prompt_Thrash || (CALL :CaughtErrorSignal& EXIT /B 1)
    EXIT /B 0
) ELSE (
    EXIT /B 1
)



REM # =============================================================================================
REM # Documentation: Delete the archive by user's request
REM # =============================================================================================
:Backup_CheckResources_AlreadyExists_Prompt_Thrash
CALL :Operation_Display_IncomingTaskSubLevelMSG "Removing an already existing archive file [ %Output% ]"
SET "TaskCaller_NiceProgramName=Delete"
SET TaskCaller_CallLong=DEL "%Output%"
CALL :Operation_TaskOperation
EXIT /B %ExitCode%