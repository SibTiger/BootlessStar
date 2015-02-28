REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                        Inno Setup Builder


REM # =============================================================================================
REM # Documentation: Create a Inno setup package.
REM # =============================================================================================
:CompileProject_GenerateSetup
REM ----
REM Run this function?
IF %Detect_InnoSetup% EQU False EXIT /B 0
IF %UserConfig.InnoMasterControl% EQU False EXIT /B 0
REM Does the user want to create a setup
IF %UserConfig.InnoGenerateSetup% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Generating Setup"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM Filename
CALL :CompileProject_GenerateSetup_NameFile
REM Does it already exist?
IF EXIST "%LocalDirectory.Setup%\%FileName_Setup%" CALL :CompileProject_GenerateSetup_ThrashExisting || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_GenerateSetup_CreateSetup || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_GenerateSetup_MoveSetupToLocal || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



:CompileProject_GenerateSetup_CreateSetup
CALL :CompileProject_Display_IncomingTaskSubLevel "Generating a setup for the %ProjectName% project"
SET TaskCaller_NiceProgramName=Inno Setup Builder
SET TaskCaller_CallLong=START "Batch Fork: Inno Setup Process Task" /B /WAIT /%PriorityGeneral% "%PathInnoSetup%" "%ProjectDirectory.DirSetupTarget%\builder2_setup.iss"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: If incase the previous setup package still exists, thrash it.
REM # =============================================================================================
:CompileProject_GenerateSetup_ThrashExisting
CALL :CompileProject_Display_IncomingTaskSubLevel "Thrashing an already existing file [%LocalDirectory.Setup%\%FileName_Setup%]"
REM If the package already exists, remove it from the file system.
SET TaskCaller_NiceProgramName=Delete
SET TaskCaller_CallLong=DEL /F /Q "%LocalDirectory.Setup%\%FileName_Setup%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%


REM # =============================================================================================
REM # Documentation: Transition the files from Doom Builder's Working Copy directory to Bootless Star's directory branch.
REM # =============================================================================================
:CompileProject_GenerateSetup_MoveSetupToLocal
CALL :CompileProject_Display_IncomingTaskSubLevel "Transitioning the setup file to the local directory"
SET TaskCaller_CallLong=COPY /V /Z "%ProjectDirectory.DirReleaseTarget%\builder2_setup.exe" "%LocalDirectory.Setup%\%FileName_Setup%"
SET TaskCaller_NiceProgramName=Copy
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Update the filename for future use.
REM # =============================================================================================
:CompileProject_GenerateSetup_NameFile
SET FileName_Setup=%FileName%_Setup.exe
GOTO :EOF