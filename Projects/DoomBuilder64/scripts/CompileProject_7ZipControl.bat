REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                               7Zip


REM # =============================================================================================
REM # Documentation: Compact the files with 7zip?
REM # =============================================================================================
:CompileProject_7ZipCompactData
REM ----
REM Run this function?
IF %Detect_7Zip% EQU False EXIT /B 0
IF %UserConfig.7ZipMasterControl% EQU False EXIT /B 0
REM Does the user want to create an archive?
IF UserConfig.7ZipGenerateArchive EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Compacting Data with 7Zip"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM Filename
CALL :CompileProject_7ZipCommonSet_NameFile
REM Does it already exist?
IF EXIST "%LocalDirectory.Archives%\%FileName_Archive%" CALL :CompileProject_7ZipCompactData_ThrashExisting || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_7ZipCompactData_CompactData || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This function will gather the information that is needed and then compact the data.
REM # =============================================================================================
:CompileProject_7ZipCompactData_CompactData
CALL :CompileProject_Display_IncomingTaskSubLevel "Compacting the data"
CALL :CompileProject_7ZipCommonSet 1
SET TaskCaller_CallLong=START "Batch Fork: 7Zip Process Task" /B /WAIT /%PriorityGeneral% "%Path7Zip%" a "%ProcessVarA%" "%ProcessVarB%" %ProcessVarC%
SET TaskCaller_NiceProgramName=Seven Zip
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: If incase another archive exists with that exact same name, remove it.
REM # =============================================================================================
:CompileProject_7ZipCompactData_ThrashExisting
CALL :CompileProject_Display_IncomingTaskSubLevel "Thrashing an already existing file [%LocalDirectory.Archives%\%FileName_Archive%]"
REM If the archive already exists, remove it from the file system.
SET TaskCaller_NiceProgramName=Delete
SET TaskCaller_CallLong=DEL /F /Q "%LocalDirectory.Archives%\%FileName_Archive%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Update the FileName_Archive variable name; this will come in handy later in the procedure.
REM # =============================================================================================
:CompileProject_7ZipCommonSet_NameFile
SET FileName_Archive=%FileName%.%SevZipFileExtension%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Set up the arguments required to invoke 7zip.
REM # Parameters: [{int} 7ZipMode]
REM #   [1] = Compact Mode; setup extra parameters for 7Zip
REM # =============================================================================================
:CompileProject_7ZipCommonSet
REM Output Dir and Filename
SET ProcessVarA=%LocalDirectory.Archives%\%FileName_Archive%
IF %1 EQU 1 (
    REM Folder to compact
    SET ProcessVarB=%ProjectDirectory.DirCompiledTarget%\*
    REM Parameters
    SET ProcessVarC=-mx=%SevZipCompressionPass% -mmt=%SevZipMultiThreadingCPU% -t%SevZipArchiveFormat% -w"%LocalDirectory.Temp%"
)
GOTO :EOF



REM -------------------------------
REM -------------------------------
REM Verify the contents within an archive


REM # =============================================================================================
REM # Documentation: Verify the archive contents.
REM # =============================================================================================
:CompileProject_7ZipVerifyData
REM ----
REM Run this function?
IF %Detect_7Zip% EQU False EXIT /B 0
IF %UserConfig.7ZipMasterControl% EQU False EXIT /B 0
REM Does the user want to verify the contents?
IF %SevZipVerify% EQU False EXIT /B 0
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Verifying Data with 7Zip"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_7ZipVerifyData_Task || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



:CompileProject_7ZipVerifyData_Task
CALL :CompileProject_Display_IncomingTaskSubLevel "Testing the archive's integrity"
CALL :CompileProject_7ZipCommonSet 0
SET TaskCaller_CallLong=START "Batch Fork: 7Zip Process Task" /B /WAIT /%PriorityGeneral% "%Path7Zip%" t "%ProcessVarA%" -r
SET TaskCaller_NiceProgramName=Seven Zip
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%