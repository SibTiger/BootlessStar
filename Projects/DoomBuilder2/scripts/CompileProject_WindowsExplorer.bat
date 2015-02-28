REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                         Windows Explorer


REM # =============================================================================================
REM # Documentation: Open new windows within the desktop environment that helps the user quickly identify the new contents that has been either compiled or generated such as 7z archives and\or Inno.
REM # =============================================================================================
:CompileProject_PopupWindowsExplorer
REM ----
REM Run this function?
IF %CallExplorerCommands% EQU False (
    CALL :CompileProject_TerminateSuccessfully_ExtendedNoExplorer
    EXIT /B 0
)
REM ----
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Calling Windows Explorer"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
CALL :CompileProject_PopupWindowsExplorer_StandardBuild
CALL :CompileProject_PopupWindowsExplorer_Archive
CALL :CompileProject_PopupWindowsExplorer_Setup
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Open a new windows and select the recently compiled engine.
REM # =============================================================================================
:CompileProject_PopupWindowsExplorer_FileNotFound
ECHO !ERR: Could not locate file { %~1 } on the filesystem!  As such, the Windows Explorer will not be called to locate this file.
IF %ToggleLog% EQU True (ECHO !ERR: Could not locate file { %~1 } on the filesystem!  As such, the Windows Explorer will not be called to locate this file.)>> "%STDOUT%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Open a new windows and select the recently compiled engine.
REM # =============================================================================================
:CompileProject_PopupWindowsExplorer_StandardBuild
REM ----
REM Run this function?
IF %UserConfig.MirrorCompiledData% EQU False EXIT /B 0
IF NOT EXIST "%LocalDirectory.Builds%\%FileName%" (
    CALL :CompileProject_PopupWindowsExplorer_FileNotFound "%LocalDirectory.Builds%\%FileName%"
    EXIT /B 0
)
REM ----
SET TaskCaller_NiceProgramName=Windows Explorer
SET TaskCaller_CallLong=EXPLORER /SELECT,"%LocalDirectory.Builds%\%FileName%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Open a new windows and select the recently compiled archive data files.
REM # =============================================================================================
:CompileProject_PopupWindowsExplorer_Archive
REM ----
REM Run this function?
IF %UserConfig.7ZipMasterControl% EQU False EXIT /B 0
IF %UserConfig.7ZipGenerateArchive% EQU False EXIT /B 0
IF NOT EXIST "%LocalDirectory.Archives%\%FileName_Archive%" (
    CALL :CompileProject_PopupWindowsExplorer_FileNotFound "%LocalDirectory.Archives%\%FileName_Archive%"
    EXIT /B 0
)
REM ----
SET TaskCaller_NiceProgramName=Windows Explorer
SET TaskCaller_CallLong=EXPLORER /SELECT,"%LocalDirectory.Archives%\%FileName_Archive%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: Open a new windows environment and highlight the inno setup packaged file.
REM # =============================================================================================
:CompileProject_PopupWindowsExplorer_Setup
REM ----
REM Run this function?
IF %UserConfig.InnoMasterControl% EQU False EXIT /B 0
IF %UserConfig.InnoGenerateSetup% EQU False EXIT /B 0
IF NOT EXIST "%LocalDirectory.Setup%\%FileName_Setup%" (
    CALL :CompileProject_PopupWindowsExplorer_FileNotFound "%LocalDirectory.Setup%\%FileName_Setup%"
    EXIT /B 0
)
REM ----
SET TaskCaller_NiceProgramName=Windows Explorer
SET TaskCaller_CallLong=EXPLORER /SELECT,"%LocalDirectory.Setup%\%FileName_Setup%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM # =============================================================================================
REM # Documentation: If the user disallows any module to use Windows Explorer, then alternatively, tell the user where the files are located within the file.
REM # =============================================================================================
:CompileProject_TerminateSuccessfully_ExtendedNoExplorer
ECHO.&ECHO.
IF %UserConfig.MirrorCompiledData% EQU True (
    ECHO Compiled Builds Directory:
    ECHO   %LocalDirectory.Builds%
    ECHO Filename:
    ECHO   %FileName%
    ECHO.
)
REM ----
IF EXIST "%LocalDirectory.Setup%\%FileName_Setup%" (
    ECHO Setup Packages Directory:
    ECHO   %LocalDirectory.Setup%
    ECHO Filename:
    ECHO   %FileName_Setup%
    ECHO.
)
REM ----
IF EXIST "%LocalDirectory.Archives%\%FileName_Archive%" (
    ECHO Archive Files Directory:
    ECHO   %LocalDirectory.Archives%
    ECHO Filename:
    ECHO   %FileName_Archive%
    ECHO.
)
GOTO :EOF