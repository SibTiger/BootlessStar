REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                  Internal Project Version Update


REM # =============================================================================================
REM # Documentation: Allow the program to update the software's version; this will include the working copy revision ID in the software's version ID.  For example, if the software's revision is 1983, then this revision ID can be used in the program by manipulating a file from the software's source code.
REM # =============================================================================================
:CompileProject_UpdateInternalProjectVersion
REM This is dependent on the CompileProject_FetchSVNRevisionID function.
REM ----
REM I know this is bad on the hardware level, but flip the variable false.
IF %ProjectModify.UpdateInternalProjectVersion% EQU True SET ProjectModify.UpdateInternalProjectVersion=False
REM Run this function?
IF %Detect_SVN% EQU False EXIT /B 0
IF %UserConfig.SVNMasterControl% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Determining if the %ProjectName% version can be updated"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM Check to see if the 'VersionFromSVN.exe' exists
IF NOT EXIST "%UserConfig.DirProjectWorkingCopy%\VersionFromSVN.exe" (
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "Can not update the %ProjectName% project's version."
    CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
    EXIT /B 0
)
REM ----
REM Too make editing this program a bit easier, the update is managed while compiling the project.  This function is merely going to flip an variable to allow the program to update the version.
SET ProjectModify.UpdateInternalProjectVersion=True
CALL :CompileProject_Display_IncomingTaskSubLevelMSG "It is possible to update the %ProjectName% project's version."
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0