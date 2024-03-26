@ECHO OFF
REM ========================================
REM =             Compile Core             =
REM ========================================
REM This is designed to expeditiously compile the modulous script with no interaction from the user; thus compile the scripts into one large script.
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
SET Filename=DeLorean.bat
SET "SourcePath=.\Scripts\"
SET "Output=.\%Filename%"
SET ExitCode=1
SET Error=False
GOTO SubTermination



REM ============================================
REM Compile Sequence
REM Compile all of the scripts into one ASCII file.
REM --------------------------------------------
:Compile
ECHO Generating file: %Filename%
TYPE %SourcePath%Header.bat> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%LegalCrap.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Main.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Prerequisites.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Global.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Dashboard.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Dashboard_Detection.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%InitializationVars.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%MainMenu.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Restore.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Restore_Menu.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Restore_Prepare.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Restore_Extract.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup_Prepare.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup_FlushTempDir.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup_Compact.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup_Test.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Backup_CheckResources.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Operations_General.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%PowerState.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%CheckUpdates.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Settings.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%UserPreset.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%QuotesDatabase.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%ViewDirectory.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%ErrorManager.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Cleanup.bat>> "%Output%"
CALL :CompileLineFeeds

TYPE %SourcePath%Terminator.bat>> "%Output%"

GOTO SubTermination



:CompileLineFeeds
REM This is useful to separate the files
ECHO.>> "%Output%"
ECHO.>> "%Output%"
ECHO.>> "%Output%"
ECHO.>> "%Output%"
ECHO.>> "%Output%"
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