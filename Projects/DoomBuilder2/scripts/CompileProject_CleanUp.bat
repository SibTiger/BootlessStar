REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                       Clean Up Local Build


REM # =============================================================================================
REM # Documentation: This function will clean up the local working copy and make sure that all of the superfluous files have been thrashed from the directories.
REM # =============================================================================================
:CompileProject_CleanupCompiledData
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Cleaning up"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM Clean up the Working Copy within the build directory
CALL :CompileProject_CleanupCompiledData_TaskGeneralCleanUp || (CALL :CaughtErrorSignal& EXIT /B 1)
REM Thrash the Setup directory located in the build directory at the Working Copy?
IF %UserConfig.KeepSetupDir% EQU False CALL :CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B %ERRORLEVEL%



:CompileProject_CleanupCompiledData_TaskGeneralCleanUp
CALL :CompileProject_Display_IncomingTaskSubLevel "Thrashing superfluous data files that is not required for %ProjectName% engine"
SET TaskCaller_NiceProgramName=Delete
SET TaskCaller_CallLong=DEL /F /Q "%ProjectDirectory.DirCompiledTarget%\*.pdb" "%ProjectDirectory.DirCompiledTarget%\Builder.xml" "%ProjectDirectory.DirCompiledTarget%\Plugins\*.pdb" "%ProjectDirectory.DirCompiledTarget%\Plugins\Builder.exe" "%ProjectDirectory.DirCompiledTarget%\Plugins\Builder.xml" "%ProjectDirectory.DirCompiledTarget%\Plugins\Sharpzip.dll" "%ProjectDirectory.DirCompiledTarget%\Plugins\TrackBar.dll" "%ProjectDirectory.DirCompiledTarget%\Plugins\SlimDX.dll"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Expunge the Setup directory that is located within the Standard Output folder.
REM # =============================================================================================
:CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp
REM Safety net: Incase if the user _wants_ a setup package, then the Setup directory _must_ be present!
IF %UserConfig.InnoGenerateSetup% EQU True (
    IF %UserConfig.InnoMasterControl% EQU True GOTO :CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp_Required
)
CALL :CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp_Task
EXIT /B %ERRORLEVEL%



:CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp_Required
REM If the directory is required, then this function will notify the user that the request can not be satisfied, but the program will continue to operate regardless.
CALL :CompileProject_Display_IncomingTaskSubLevelMSG "!ERR: Can not remove %ProjectDirectory.DirCompileSetupTarget% because Inno Setup Builder requires this directory!"
EXIT /B 0



:CompileProject_CleanupCompiledData_TaskWorkingCopyCleanUp_Task
CALL :CompileProject_Display_IncomingTaskSubLevel "Thrashing the Setup Directory"
SET TaskCaller_NiceProgramName=Delete
SET TaskCaller_CallLong=RD /S /Q "%ProjectDirectory.DirCompileSetupTarget%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                       Clean Up SVN Local Working Copy



REM # =============================================================================================
REM # Documentation: Revert and clean up the Local Working Copy.
REM # =============================================================================================
:CompileProject_CleanupWorkingCopy
REM ----
REM Run this function?
IF %Detect_SVN% EQU False EXIT /B 0
IF %UserConfig.SVNMasterControl% EQU False EXIT /B 0
REM Does the user want the local working copy to be reverted?
IF %UserConfig.SVNAllowWorkingCopyRevert% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Cleaning up SVN Local Working Copy"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_CleanupWorkingCopy_ThrashBuildDir || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CleanupWorkingCopy_Cleanup || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CleanupWorkingCopy_Revert || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



:CompileProject_CleanupWorkingCopy_ThrashBuildDir
CALL :CompileProject_Display_IncomingTaskSubLevel "Expunging the Build directory from the %ProjectName% SVN Local Working Copy"
SET TaskCaller_CallLong=RD /S /Q "%ProjectDirectory.DirCompiledTarget%"
SET TaskCaller_NiceProgramName=Remove Directory
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CleanupWorkingCopy_Cleanup
CALL :CompileProject_Display_IncomingTaskSubLevel "Cleaning up the %ProjectName% SVN Local Working Copy"
SET TaskCaller_CallLong=SVN cleanup "%UserConfig.DirProjectWorkingCopy%"
SET TaskCaller_NiceProgramName=SVN
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CleanupWorkingCopy_Revert
CALL :CompileProject_Display_IncomingTaskSubLevel "Rolling-back the %ProjectName% SVN Local Working Copy"
SET TaskCaller_CallLong=SVN revert "%UserConfig.DirProjectWorkingCopy%" -R
SET TaskCaller_NiceProgramName=SVN
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%