REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                             File Name


REM # =============================================================================================
REM # Documentation: Determine the file and directory name of the project and the current revision number.
REM # =============================================================================================
:CompileProject_GenerateProjectName
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Generating project name"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_GenerateProjectName_MakeName
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Create a generalized name; it is possible for the user to not have a revision ID - which no revision number will be stored.
REM # =============================================================================================
:CompileProject_GenerateProjectName_MakeName
REM This name is used to compile the project with the revision number
REM  For example: Project-r0000
IF %SVNRevisionNew% EQU -1 (
    REM If we can not get the newer revision, then exclude the revision number in the name.
    SET FileName=%ProjectNameCompact%
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "The file naming scheme will not include a revision number."
) ELSE (
    SET FileName=%ProjectNameCompact%-r%SVNRevisionNew%
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "The file naming scheme will include a revision number."
)
GOTO :EOF