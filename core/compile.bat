@ECHO OFF
REM ========================================
REM =             Compile Core             =
REM ========================================
REM This is designed to expeditiously compile the core with no interaction from the user; thus compile the scripts into one large script.
GOTO MainDriver



REM ============================================
REM Main Driver
REM This driver is going to be the main focus of the entire program.
REM --------------------------------------------
:MainDriver
CALL :Variables
IF EXIST "%Output%" (CALL :Expunge)
    IF %Error% EQU True GOTO ErrorTermination
CALL :Compile
CALL :Verify
    IF %Error% EQU True GOTO ErrorTermination
GOTO Kill



REM ============================================
REM Variables
REM Setup the variables we'll need for this program.
REM --------------------------------------------
:Variables
SET Filename=BootlessStar.bat
SET SourcePath=.\Scripts\
SET Output=.\%Filename%
SET ExitCode=1
SET Error=False
GOTO SubTermination



REM ============================================
REM Compile Sequence
REM Compile all of the scripts into one ASCII file.
REM --------------------------------------------
:Compile
ECHO Generating file: %Filename%
TYPE %SourcePath%header.bat> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%LegalCrap.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%StartUp_Driver.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%CompatibilityCheck.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%GlobalFunctions.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%Dashboard.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%EnvironmentHooking.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%InitializationVars.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%MainMenu.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%DocumentsManager.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%CheckUpdates.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ProjectLoader.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ExternalModuleLauncher.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanelMenu.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanelAdvancedMenu.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%UserConfigManagement.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_Logging.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_Copy.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_CopyBehaviorConfigration.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_intCMDCopyParameters.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_XCopyParameters.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_RoboCopyParameters.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_RoboCopyParameters-Extended.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_Bell.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_DirectorySetup.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_GeneralProgramSettings.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_WindowsExplorer.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_Priority.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_7Zip.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_7ZipConfiguration.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_ModulesExecuteWindowSharing.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%ControlPanel_DashboardViewer.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%DebugTool.bat>> %Output%
CALL :CompileLineFeeds

TYPE %SourcePath%Kill.bat>> %Output%

GOTO SubTermination



:CompileLineFeeds
REM This is useful to separate the files
ECHO.>> %Output%
ECHO.>> %Output%
ECHO.>> %Output%
ECHO.>> %Output%
ECHO.>> %Output%
GOTO SubTermination



REM ============================================
REM Expunge Previous
REM Thrash the previously built script.
REM --------------------------------------------
:Expunge
DEL /F /Q %Output% || GOTO ExpungeError
GOTO SubTermination



:ExpungeError
ECHO Could not remove file named '%Filename%'!
SET Error=True
PAUSE
GOTO SubTermination



REM ============================================
REM Verify File
REM Verify that the file was generated.
REM --------------------------------------------
:Verify
IF NOT EXIST %Output% (
    GOTO VerifyError
) ELSE (
    GOTO SubTermination
)



:VerifyError
ECHO Could not find file named '%Filename%'!
SET Error=True
PAUSE
GOTO SubTermination



REM ============================================
REM Termination Processes
REM --------------------------------------------
:SubTermination
REM Terminate just the fork or subprocess
SET ExitCode=1
GOTO Kill



:Termination
REM Main terminated
SET ExitCode=0
GOTO Kill



:ErrorTermination
REM Main termination when an error occurs
SET ExitCode=1
GOTO Kill



:Kill
REM Actually kill the process
EXIT /B %ExitCode%