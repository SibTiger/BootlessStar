REM =====================================================================
REM Environment Setup Manager
REM ----------------------------
REM This entire section sets the programs environment as well as declarations that is used within this program, this will also set a default configuration for the user.  Within this section, it is also possible to write the identifiers information in to a file, which is specifically for saving the user configuration, and also printing the current value within the terminal.
REM When passing through this section, it is crucially important to look over the EnvironmentSetup_Switch.  This function demands a parameter to work correctly, otherwise the return result will be an error.
REM =====================================================================


REM # =============================================================================================
REM # Parameters: [{int} Mode]
REM # Documentation: This driver determines the action to take within the initialization field.
REM # Parameter details:
REM # 0 = Initialize
REM # 1 = Save User Variables
REM # 2 = Debug
REM # =============================================================================================
:EnvironmentSetup_Switch
IF "%1" EQU "StartUp" (
    REM When the program is starting up
    CALL :EnvironmentSetup_Core
    CALL :EnvironmentSetup_TerminalUpdates
    CALL :EnvironmentSetup_UserSettings 0
    CALL :EnvironmentSetup_DirectoryCheck
    CALL :EnvironmentSetup_Find_dotNETFoundations
    CALL :EnvironmentSetup_CheckEnvironmentPrivileges
    CALL :EnvironmentSetup_Setup_Time-and-Date
    EXIT /B 0
)
IF "%1" EQU "Restart" (
    REM When the program is requested to reset its already declared and assigned variables
    CALL :EnvironmentSetup_TerminalUpdates
    CALL :EnvironmentSetup_UserSettings 0
    CALL :EnvironmentSetup_DirectoryCheck
    CALL :EnvironmentSetup_Find_dotNETFoundations
    CALL :EnvironmentSetup_Setup_Time-and-Date
    EXIT /B 0
)
REM ----
IF "%1" EQU "UserConfigSave" (
    REM Save user configuration
    CALL :EnvironmentSetup_UserSettings 1 "%DirSavePresets%\%STDIN%"
    EXIT /B 0
)
REM ----
IF "%1" EQU "DebugUser" (
    REM Display the user's variables on screen
    CALL :EnvironmentSetup_UserSettings 2
    EXIT /B 0
)
IF "%1" EQU "Thrash" (
    REM When the program terminates, clear some sensitive variables.
    CALL :EnvironmentSetup_UninitializeVars
    EXIT /B 0
)
IF "%1" EQU "PathRestore" (
    REM When the user wishes to restore a program path to the original state
    CALL :EnvironmentSetup_UserSettings "%~2"
    EXIT /B 0
)
IF "%1" EQU "PartialReset" (
    REM When a script finishes, this will reset some of the environment that could have changed.
    CALL :EnvironmentSetup_TerminalUpdates
    EXIT /B 0
)
IF "%1" EQU "UserConfigLoad" (
    REM When loading a configuration, check wither the directory and program targets can still be detected.
    CALL :EnvironmentSetup_DirectoryCheck
    EXIT /B 0
)
IF "%1" EQU "CheckExternalResources" (
    REM Check the directory and program targets and determine if they exist.
    CALL :EnvironmentSetup_DirectoryCheck
    EXIT /B 0
)
REM ----
REM Error; Either the parameter wasn't correct or there was no parameter.
CALL :EnvironmentSetup_SwitchError
EXIT /B 1



REM # =============================================================================================
REM # Documentation: If the EnvironmentSetup_Switch reaches an error, this function will merely return an error.
REM # =============================================================================================
:EnvironmentSetup_SwitchError
REM The Switch method was invoked with an improper or unsupported parameter type.
ECHO !ERR: The Environment Switch was called with an improper setting!
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function houses static declarations for the core environment.
REM # =============================================================================================
:EnvironmentSetup_Core
SET ProgramName=Bootless Star
SET ProgramVersion=1.5.4
SET ProgramReleaseDate=6.March.2016
SET CodeName=Aditi
REM Program Title
SET core.Title=%ProgramName% %ProgramVersion% ^(%CodeName%^)
REM Borders
SET Separator=-------------------------
SET SeparatorLong=--------------------------------------------------
SET SeparatorSmall=-------------
REM Bell Character
SET SND_BELL=
REM User Input
SET STDIN=NULL
REM Set the ExitCode to 3; This value means: unexpected error or crash-out
SET ExitCode=3
REM Modules ExitCode
SET scriptExitCode=0
REM Working Variables - adjacent to Intel's CISC working registries [AX, BX, CX, DX]
SET ProcessVarA=NULL
SET ProcessVarB=NULL
SET ProcessVarC=NULL
SET ProcessVarD=NULL
REM Dedicated Directories
REM  User Configurations
SET DirSavePresets=.\Presets
REM  Stand-alone scripts
SET DirSubScripts=.\Scripts
REM  Documentation
SET DirDocuments=.\Documents
REM  Core Compatible scripts [Designed to work with this program]
SET DirProjects=.\Projects
REM  Preset Configuration Name
SET UserConfigurationLoaded=coreDefault
REM  Preset Configuration Unique Key Chain Token
REM    When the user saves a configuration, they will gain a new token number - which should remain unique to the user.  The token number is what is going to be the filename for all of the modules that the user executes with this program.
SET UserConfigurationKeyChainToken=0
REM  Is the OS compatible with this program?
SET IncompatibleOS=False
REM  Toggle ECHO mode; view all of the code in Real Time
SET DebugMode=False
REM Detection identifiers
SET Detect_SVN=False
SET Detect_Git=False
SET Detect_7Zip=False
SET Detect_InnoSetup=False
SET Detect_MinGW=False
SET Detect_MSHTMLWorkShop=False
SET Detect_MSVS120COMMTOOLS=False
SET Detect_MSVS110COMMTOOLS=False
SET Detect_MSVS100COMMTOOLS=False
SET Detect_MSVS90COMMTOOLS=False
SET Detect_MSVS80COMMTOOLS=False
SET Detect_MicrosoftVisualStudio=False
SET Detect_dotNET1=False
SET Detect_dotNET1.1=False
SET Detect_dotNET2=False
SET Detect_dotNET2-64=False
SET Detect_dotNET3=False
SET Detect_dotNET3-64=False
SET Detect_dotNET3.5=False
SET Detect_dotNET3.5-64=False
SET Detect_dotNET4=False
SET Detect_dotNET4-64=False
REM NOTE: Robocopy was never included into Windows [officially] until Vista [6.0]; Windows XP [5.1] and earlier never had Robocopy.
SET Detect_Robocopy=False
SET Detect_Python3=False
SET Detect_Python2=False
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function houses settings that are to be part of the environment.
REM # =============================================================================================
:EnvironmentSetup_TerminalUpdates
TITLE %core.Title%
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} Mode]
REM # Documentation: This function houses the users configuration.  This function also has multiple purposes within the user declaration field.
REM # Parameter details:
REM # 0 = Set the default Value
REM # 1 = Save the information into a preset configuration.
REM # 2 = Display the value on the terminal screen.
REM # =============================================================================================
:EnvironmentSetup_UserSettings
REM Dashboard Viewer Functionality
IF %1 EQU 0 SET DashboardViewerTool=True
IF %1 EQU 1 (ECHO REM When true, this will allow the Dashboard Viewer tool to be displayed in the program.)>> "%~2"
IF %1 EQU 1 (ECHO SET DashboardViewerTool=%DashboardViewerTool%)>> "%~2"
IF %1 EQU 2 ECHO DashboardViewerTool -^> %DashboardViewerTool%
REM ----
REM Open Windows File Manager and perform simple tasks [highlight an object, for example]
IF %1 EQU 0 SET CallExplorerCommands=True
IF %1 EQU 1 (ECHO REM When true, this will allow modules to call Windows Explorer.  This can allow modules to open windows and highlight objects within the desktop environment.)>> "%~2"
IF %1 EQU 1 (ECHO SET CallExplorerCommands=%CallExplorerCommands%)>> "%~2"
IF %1 EQU 2 ECHO CallExplorerCommands -^> %CallExplorerCommands%
REM ----
REM Default duplicating software
IF %1 EQU 0 SET CopyMethod=XCOPY
IF %1 EQU 1 (ECHO REM Default copying software to use within the program and modules.)>> "%~2"
IF %1 EQU 1 (ECHO SET CopyMethod=%CopyMethod%)>> "%~2"
IF %1 EQU 2 ECHO CopyMethod -^> %CopyMethod%
REM ----
REM XCOPY Argument Set
IF %1 EQU 0 SET XCopyArg=/V /C /Y /Z
IF %1 EQU 1 (ECHO REM XCopy's parameters.)>> "%~2"
IF %1 EQU 1 (ECHO SET XCopyArg=%XCopyArg%)>> "%~2"
IF %1 EQU 2 ECHO XCopyArg -^> %XCopyArg%
REM ----
REM XCopy Switch: Verify
IF %1 EQU 0 SET ParametersXCopy.Verify=True
IF %1 EQU 1 (ECHO REM Batch External Command XCopy; Switch: Verify)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersXCopy.Verify=%ParametersXCopy.Verify%)>> "%~2"
IF %1 EQU 2 ECHO ParametersXCopy.Verify -^> %ParametersXCopy.Verify%
REM ----
REM XCopy Switch: Continue operation regardless of errors
IF %1 EQU 0 SET ParametersXCopy.Continue=True
IF %1 EQU 1 (ECHO REM Batch External Command XCopy; Switch: Continue even with errors)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersXCopy.Continue=%ParametersXCopy.Continue%)>> "%~2"
IF %1 EQU 2 ECHO ParametersXCopy.Continue -^> %ParametersXCopy.Continue%
REM ----
REM XCopy Switch: Encrypt files to destination even if destination does not support it
IF %1 EQU 0 SET ParametersXCopy.Encrypt=False
IF %1 EQU 1 (ECHO REM Batch External Command XCopy; Switch: Encrypt files to destination)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersXCopy.Encrypt=%ParametersXCopy.Encrypt%)>> "%~2"
IF %1 EQU 2 ECHO ParametersXCopy.Encrypt -^> %ParametersXCopy.Encrypt%
REM ----
REM XCopy Switch: Suppress warning messages
IF %1 EQU 0 SET ParametersXCopy.Suppress=True
IF %1 EQU 1 (ECHO REM Batch External Command XCopy; Suppress warning messages)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersXCopy.Suppress=%ParametersXCopy.Suppress%)>> "%~2"
IF %1 EQU 2 ECHO ParametersXCopy.Suppress -^> %ParametersXCopy.Suppress%
REM ----
REM XCopy Switch: Network Restartable Mode
IF %1 EQU 0 SET ParametersXCopy.Restart=True
IF %1 EQU 1 (ECHO REM Batch External Command XCopy; Switch: Network Restartable Mode)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersXCopy.Restart=%ParametersXCopy.Restart%)>> "%~2"
IF %1 EQU 2 ECHO ParametersXCopy.Restart -^> %ParametersXCopy.Restart%
REM ----
REM Robocopy Switch: Network Restart Mode (Backup Mode if failure)
IF %1 EQU 0 SET ParametersRobocopy.RestartBackup=True
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Network Restart Mode - Backup Mode if Permission Failure)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.RestartBackup=%ParametersRobocopy.RestartBackup%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.RestartBackup -^> %ParametersRobocopy.RestartBackup%
REM ----
REM Robocopy Switch: Restrict Deep Paths
IF %1 EQU 0 SET ParametersRobocopy.RestrictDeepPaths=False
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Restrict Deep Paths)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.RestrictDeepPaths=%ParametersRobocopy.RestrictDeepPaths%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.RestrictDeepPaths -^> %ParametersRobocopy.RestrictDeepPaths%
REM ----
REM Robocopy Switch: No Junction Pointers
IF %1 EQU 0 SET ParametersRobocopy.NoJunctionPoints=True
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: No Junction Pointers)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.NoJunctionPoints=%ParametersRobocopy.NoJunctionPoints%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.NoJunctionPoints -^> %ParametersRobocopy.NoJunctionPoints%
REM ----
REM Robocopy Switch: Display Full Path Location
IF %1 EQU 0 SET ParametersRobocopy.FullPath=True
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Display Full Path Location)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.FullPath=%ParametersRobocopy.FullPath%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.FullPath -^> %ParametersRobocopy.FullPath%
REM ----
REM Robocopy Switch: Verbose Mode
IF %1 EQU 0 SET ParametersRobocopy.Verbose=True
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Verbose Mode)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.Verbose=%ParametersRobocopy.Verbose%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.Verbose -^> %ParametersRobocopy.Verbose%
REM ----
REM Robocopy Switch: Display File Sizes in Bytes
IF %1 EQU 0 SET ParametersRobocopy.BytesFileSize=False
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Show File Size in Bytes)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.BytesFileSize=%ParametersRobocopy.BytesFileSize%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.BytesFileSize -^> %ParametersRobocopy.BytesFileSize%
REM ----
REM Robocopy Switch: Do Not Display Progress
IF %1 EQU 0 SET ParametersRobocopy.NoProgress=False
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Do Not Display Progress)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.NoProgress=%ParametersRobocopy.NoProgress%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.NoProgress -^> %ParametersRobocopy.NoProgress%
REM ----
REM Robocopy Switch: Display Estimated Time of Arrival
IF %1 EQU 0 SET ParametersRobocopy.ETA=True
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Display Estimated Time of Arrival)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.ETA=%ParametersRobocopy.ETA%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.ETA -^> %ParametersRobocopy.ETA%
REM ----
REM Robocopy Switch: Maximum Retries
IF %1 EQU 0 SET ParametersRobocopy.Retry=20
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Max Retries)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.Retry=%ParametersRobocopy.Retry%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.Retry -^> %ParametersRobocopy.Retry%
REM ----
REM Robocopy Switch: Maximum Wait Time
IF %1 EQU 0 SET ParametersRobocopy.Wait=30
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Maximum Wait Time)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.Wait=%ParametersRobocopy.Wait%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.Wait -^> %ParametersRobocopy.Wait%
REM ----
REM Robocopy Switch: Multithreading
IF %1 EQU 0 SET ParametersRobocopy.Multithread=2
IF %1 EQU 1 (ECHO REM Batch External Command Robocopy; Switch: Multithreading)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersRobocopy.Multithread=%ParametersRobocopy.Multithread%)>> "%~2"
IF %1 EQU 2 ECHO ParametersRobocopy.Multithread -^> %ParametersRobocopy.Multithread%
REM ----
REM Robocopy Argument Set
IF %1 EQU 0 SET RoboCopyArg=/ZB /XD /FP /V /BYTES /ETA /R:%ParametersRobocopy.Retry% /W:%ParametersRobocopy.Wait% /MT:%ParametersRobocopy.Multithread%
IF %1 EQU 1 (ECHO REM ROBOCOPY's paramenters.)>> "%~2"
IF %1 EQU 1 (ECHO SET RoboCopyArg=%RoboCopyArg%)>> "%~2"
IF %1 EQU 2 ECHO RoboCopyArg -^> %RoboCopyArg%
REM ----
REM IntCMD Copy Argument Set Compiled
IF %1 EQU 0 SET CopyIntCMDArg=/V /Y /Z
IF %1 EQU 1 (ECHO REM Batch Internal Command - Copy's parameters [compiled].)>> "%~2"
IF %1 EQU 1 (ECHO SET CopyIntCMDArg=%CopyIntCMDArg%)>> "%~2"
IF %1 EQU 2 ECHO CopyIntCMDArg -^> %CopyIntCMDArg%
REM ----
REM IntCMD Copy Switch: Decrypt
IF %1 EQU 0 SET ParametersCopy.Decrypt=False
IF %1 EQU 1 (ECHO REM Batch Internal Command Copy; Switch: Decrypt)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersCopy.Decrypt=%ParametersCopy.Decrypt%)>> "%~2"
IF %1 EQU 2 ECHO ParametersCopy.Decrypt -^> %ParametersCopy.Decrypt%
REM ----
REM IntCMD Copy Switch: Verify
IF %1 EQU 0 SET ParametersCopy.Verify=True
IF %1 EQU 1 (ECHO REM Batch Internal Command Copy; Switch: Verify)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersCopy.Verify=%ParametersCopy.Verify%)>> "%~2"
IF %1 EQU 2 ECHO ParametersCopy.Verify -^> %ParametersCopy.Verify%
REM ----
REM IntCMD Copy Switch: Suppress Overwrite Prompts
IF %1 EQU 0 SET ParametersCopy.Suppress=True
IF %1 EQU 1 (ECHO REM Batch Internal Command Copy; Switch: Suppress)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersCopy.Suppress=%ParametersCopy.Suppress%)>> "%~2"
IF %1 EQU 2 ECHO ParametersCopy.Suppress -^> %ParametersCopy.Suppress%
REM ----
REM IntCMD Copy Switch: Network Restart Mode
IF %1 EQU 0 SET ParametersCopy.Restart=True
IF %1 EQU 1 (ECHO REM Batch Internal Command Copy; Switch: Network Restart Mode)>> "%~2"
IF %1 EQU 1 (ECHO SET ParametersCopy.Restart=%ParametersCopy.Restart%)>> "%~2"
IF %1 EQU 2 ECHO ParametersCopy.Restart -^> %ParametersCopy.Restart%
REM ----
REM Default Copying duplicating software parameter set.
IF %1 EQU 0 SET CopyArg=%XCopyArg%
IF %1 EQU 1 (ECHO REM Default parameters that should be used when calling the default copying software.)>> "%~2"
IF %1 EQU 1 (ECHO SET CopyArg=%CopyArg%)>> "%~2"
IF %1 EQU 2 ECHO CopyArg -^> %CopyArg%
REM ----
REM Default arguments to be used with MSBuild
IF %1 EQU 0 SET "MSVSArg=/t:Rebuild /p:Configuration=Release;Platform=x86 /v:quiet"
IF %1 EQU 1 (ECHO REM Parameters to be used when using MSBuild from Microsoft Visual Studio packages.)>> "%~2"
IF %1 EQU 1 (ECHO SET "MSVSArg=%MSVSArg%")>> "%~2"
IF %1 EQU 2 ECHO MSVSArg -^> %MSVSArg%
REM ----
REM Default arguments to be used with VCUpgrade
IF %1 EQU 0 SET "MSVSArgVPO=/p:Configuration=Release;Platform=Win32 /v:quiet"
IF %1 EQU 1 (ECHO REM Parameters to be used when using VCUpgrade from Microsoft Visual Studio packages.)>> "%~2"
IF %1 EQU 1 (ECHO SET "MSVSArgVPO=%MSVSArgVPO%")>> "%~2"
IF %1 EQU 2 ECHO MSVSArgVPO -^> %MSVSArgVPO%
REM ----
REM Module logging
IF %1 EQU 0 SET ToggleLog=False
IF %1 EQU 1 (ECHO REM When true, this will allow modules to log their activity or progress to a logfile.)>> "%~2"
IF %1 EQU 1 (ECHO SET ToggleLog=%ToggleLog%)>> "%~2"
IF %1 EQU 2 ECHO ToggleLog -^> %ToggleLog%
REM ----
REM Logfile Name [NUL == NULL]
IF %1 EQU 0 SET STDOUT=NUL
IF %1 EQU 1 (ECHO REM Logfile name)>> "%~2"
IF %1 EQU 1 (ECHO SET STDOUT=%STDOUT%)>> "%~2"
IF %1 EQU 2 ECHO STDOUT -^> %STDOUT%
REM ----
REM Terminal Alarm [BELL]
REM {0=Disable|1=One beep compile & Two beeps for errors|2=Two beeps for errors only}
IF %1 EQU 0 SET UseBell=1
IF %1 EQU 1 (ECHO REM Terminal Alarm or Bell.)>> "%~2"
IF %1 EQU 1 (ECHO SET UseBell=%UseBell%)>> "%~2"
IF %1 EQU 2 ECHO UseBell -^> %UseBell%
REM ----
REM Microsoft's 'Help' compiling tool.
IF %1 EQU 0 CALL :EnvironmentSetup_FindDefault_HTMLWorkshop
IF %1 EQU 1 (ECHO REM Directory path to Microsoft's HTML Workshop software.  Do NOT include the extension, the software itself dislikes that....)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSHTMLWorkShop=%PathMSHTMLWorkShop%")>> "%~2"
IF %1 EQU 2 ECHO PathMSHTMLWorkShop -^> %PathMSHTMLWorkShop%
IF "%~1" EQU "HTML Workshop" CALL :EnvironmentSetup_FindDefault_HTMLWorkshop
REM ----
REM General Kernel request Priority.
IF %1 EQU 0 SET PriorityGeneral=Normal
IF %1 EQU 1 (ECHO REM General priority for operations.  When the priority is higher, the system may become unstable or will have performance issues)>> "%~2"
IF %1 EQU 1 (ECHO SET PriorityGeneral=%PriorityGeneral%)>> "%~2"
IF %1 EQU 2 ECHO PriorityGeneral -^> %PriorityGeneral%
REM ----
REM Here, we are looking for 'common tools' that is included with Visual Studio 2005.
IF %1 EQU 0 SET "PathMSVS2005=%VS80COMNTOOLS%"
IF %1 EQU 1 (ECHO REM Directory path to: Microsoft Visual Studio 2005' VSVars32.bat)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSVS2005=%PathMSVS2005%")>> "%~2"
IF %1 EQU 2 ECHO PathMSVS2005 -^> %PathMSVS2005%
IF %1 EQU "Visual Studio 2005" SET "PathMSVS2005=%VS80COMNTOOLS%"
REM ----
REM Here, we are looking for 'common tools' that is included with Visual Studio 2008.
IF %1 EQU 0 SET "PathMSVS2008=%VS90COMNTOOLS%"
IF %1 EQU 1 (ECHO REM Directory path to: Microsoft Visual Studio 2008' VSVars32.bat)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSVS2008=%PathMSVS2008%")>> "%~2"
IF %1 EQU 2 ECHO PathMSVS2008 -^> %PathMSVS2008%
IF %1 EQU "Visual Studio 2008" SET "PathMSVS2008=%VS90COMNTOOLS%"
REM ----
REM Here, we are looking for 'common tools' that is included with Visual Studio 2010.
IF %1 EQU 0 SET "PathMSVS2010=%VS100COMNTOOLS%"
IF %1 EQU 1 (ECHO REM Directory path to: Microsoft Visual Studio 2010' VSVars32.bat)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSVS2010=%PathMSVS2010%")>> "%~2"
IF %1 EQU 2 ECHO PathMSVS2010 -^> %PathMSVS2010%
IF %1 EQU "Visual Studio 2010" SET "PathMSVS2010=%VS100COMNTOOLS%"
REM ----
REM Here, we are looking for 'common tools' that is included with Visual Studio 2012.
IF %1 EQU 0 SET "PathMSVS2012=%VS110COMNTOOLS%"
IF %1 EQU 1 (ECHO REM Directory path to: Microsoft Visual Studio 2012' VSVars32.bat)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSVS2012=%PathMSVS2012%")>> "%~2"
IF %1 EQU 2 ECHO PathMSVS2012 -^> %PathMSVS2012%
IF %1 EQU "Visual Studio 2012" SET "PathMSVS2012=%VS110COMNTOOLS%"
REM ----
REM Here, we are looking for 'common tools' that is included with Visual Studio 2013.
IF %1 EQU 0 SET "PathMSVS2013=%VS120COMNTOOLS%"
IF %1 EQU 1 (ECHO REM Directory path to: Microsoft Visual Studio 2013' VSVars32.bat)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMSVS2013=%PathMSVS2013%")>> "%~2"
IF %1 EQU 2 ECHO PathMSVS2013 -^> %PathMSVS2013%
IF %1 EQU "Visual Studio 2013" SET "PathMSVS2013=%VS120COMNTOOLS%"
REM ----
REM MinGW path, for those that prefer or need MinGW support.
IF %1 EQU 0 SET "PathMinGW=.\MinGW\"
IF %1 EQU 1 (ECHO REM Directory path for MinGW)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathMinGW=%PathMinGW%")>> "%~2"
IF %1 EQU 2 ECHO PathMinGW -^> %PathMinGW%
IF %1 EQU "MinGW" SET "PathMinGW=.\MinGW\"
REM ----
REM Inno Setup
IF %1 EQU 0 CALL :EnvironmentSetup_FindDefault_InnoSetup
IF %1 EQU 1 (ECHO REM Directory path to Inno Setup Builder)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathInnoSetup=%PathInnoSetup%")>> "%~2"
IF %1 EQU 2 ECHO PathInnoSetup -^> %PathInnoSetup%
IF %1 EQU "Inno Installer" CALL :EnvironmentSetup_FindDefault_InnoSetup
REM ----
REM Python v3
IF %1 EQU 0 CALL :EnvironmentSetup_FindDefault_Python3
IF %1 EQU 1 (ECHO REM Directory path to Python v3)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathPython3=%PathPython3%")>> "%~2"
IF %1 EQU 2 ECHO PathPython3 -^> %PathPython3%
IF %1 EQU "Python3" CALL :EnvironmentSetup_FindDefault_Python3
REM ----
REM Python v2.7
IF %1 EQU 0 CALL :EnvironmentSetup_FindDefault_Python2
IF %1 EQU 1 (ECHO REM Directory path to Python v2.7)>> "%~2"
IF %1 EQU 1 (ECHO SET "PathPython2=%PathPython2%")>> "%~2"
IF %1 EQU 2 ECHO PathPython2 -^> %PathPython2%
IF %1 EQU "Python2" CALL :EnvironmentSetup_FindDefault_Python2
REM ----
REM 7Zip
IF %1 EQU 0 CALL :EnvironmentSetup_FindDefault_7Zip
IF %1 EQU 1 (ECHO REM Directory path to 7zip)>> "%~2"
IF %1 EQU 1 (ECHO SET "Path7Zip=%Path7Zip%")>> "%~2"
IF %1 EQU 2 ECHO Path7Zip -^> %Path7Zip%
IF %1 EQU "Seven Zip" CALL :EnvironmentSetup_FindDefault_7Zip
REM ----
REM 7Zip Archive Password
IF %1 EQU 0 SET SevZipKey=
IF %1 EQU 1 (ECHO REM 7Zip: Archive password to use with 7zip. [NOT ENCRYPTED])>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipKey=%SevZipKey%)>> "%~2"
IF %1 EQU 2 ECHO SevZipKey -^> %SevZipKey%
REM ----
REM 7Zip Archive Password Toggle
IF %1 EQU 0 SET SevZipUseKey=False
IF %1 EQU 1 (ECHO REM 7Zip: When true, this will allow 7Zip [if called] to enable the use of encrypting the archive file with a password.)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipUseKey=%SevZipUseKey%)>> "%~2"
IF %1 EQU 2 ECHO SevZipUseKey -^> %SevZipUseKey%
REM ----
REM 7Zip Archive Format
IF %1 EQU 0 SET SevZipArchiveFormat=7z
IF %1 EQU 1 (ECHO REM 7Zip: Archive format)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipArchiveFormat=%SevZipArchiveFormat%)>> "%~2"
IF %1 EQU 2 ECHO SevZipArchiveFormat -^> %SevZipArchiveFormat%
REM ----
REM 7Zip file extension
IF %1 EQU 0 SET SevZipFileExtension=7z
IF %1 EQU 1 (ECHO REM 7Zip: Archive filename extension)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipFileExtension=%SevZipFileExtension%)>> "%~2"
IF %1 EQU 2 ECHO SevZipFileExtension -^> %SevZipFileExtension%
REM ----
REM 7Zip Compression
IF %1 EQU 0 SET SevZipCompressionPass=5
IF %1 EQU 1 (ECHO REM 7Zip: Compression rate to be used when compacting the data.  Higher the compression rate, the slower it builds.)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipCompressionPass=%SevZipCompressionPass%) >> "%~2"
IF %1 EQU 2 ECHO SevZipCompressionPass -^> %SevZipCompressionPass%
REM ----
REM 7Zip Copy algorithm
IF %1 EQU 0 SET SevZipCopyFormat=Deflate
IF %1 EQU 1 (ECHO REM 7Zip: Copy Format)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipCopyFormat=%SevZipCopyFormat%)>> "%~2"
IF %1 EQU 2 ECHO SevZipCopyFormat -^> %SevZipCopyFormat%
REM ----
REM 7Zip CPU Multithreading
IF %1 EQU 0 CALL :EnvironmentSetup_CheckCPULogicalProcessors
IF %1 EQU 1 (ECHO REM 7Zip: When on, this will allow the 7Zip program to use more than one thread from the CPU, which will allow the program to finish expeditiously.  DO NOT enable this if the CPU one has one core and one thread!)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipMultiThreadingCPU=%SevZipMultiThreadingCPU%)>> "%~2"
IF %1 EQU 2 ECHO SevZipMultiThreadingCPU -^> %SevZipMultiThreadingCPU%
REM ----
REM 7Zip Encryption
IF %1 EQU 0 SET SevZipEncryptionAlgorithm=ZipCrypto
IF %1 EQU 1 (ECHO REM 7Zip: When password protecting the archive file, these algorithms will strengthen the encryption of the file.)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipEncryptionAlgorithm=%SevZipEncryptionAlgorithm%)>> "%~2"
IF %1 EQU 2 ECHO SevZipEncryptionAlgorithm -^> %SevZipEncryptionAlgorithm%
REM ----
REM 7Zip Testing
IF %1 EQU 0 SET SevZipVerify=True
IF %1 EQU 1 (ECHO REM 7Zip: When true, this will allow modules to verify the archive file contents to assure that everything was generated accurately.)>> "%~2"
IF %1 EQU 1 (ECHO SET SevZipVerify=%SevZipVerify%)>> "%~2"
IF %1 EQU 2 ECHO SevZipVerify -^> %SevZipVerify%
REM ----
REM Modules Execute in a shared window with the core.
IF %1 EQU 0 SET ModuleExecuteSharingWindow=True
IF %1 EQU 1 (ECHO REM When false, this will allow modules to be executed in their own window environment -- this allows multitasking.)>> "%~2"
IF %1 EQU 1 (ECHO SET ModuleExecuteSharingWindow=%ModuleExecuteSharingWindow%)>> "%~2"
IF %1 EQU 2 ECHO ModuleExecuteSharingWindow -^> %ModuleExecuteSharingWindow%
REM ----
REM Finished
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Within this function, this will check wither the targets can be found within the filesystem.  If the target can not be found, simply change the target status to false.
REM # =============================================================================================
:EnvironmentSetup_DirectoryCheck
REM Visual Studio 2005
IF EXIST "%PathMSVS2005%" (
    SET Detect_MSVS80COMMTOOLS=True
    IF %Detect_MicrosoftVisualStudio% EQU False SET Detect_MicrosoftVisualStudio=True
) ELSE (
    SET Detect_MSVS80COMMTOOLS=False
)

REM Visual Studio 2008
IF EXIST "%PathMSVS2008%" (
    SET Detect_MSVS90COMMTOOLS=True
    IF %Detect_MicrosoftVisualStudio% EQU False SET Detect_MicrosoftVisualStudio=True
) ELSE (
    SET Detect_MSVS90COMMTOOLS=False
)

REM Visual Studio 2010
IF EXIST "%PathMSVS2010%" (
    SET Detect_MSVS100COMMTOOLS=True
    IF %Detect_MicrosoftVisualStudio% EQU False SET Detect_MicrosoftVisualStudio=True
) ELSE (
    SET Detect_MSVS100COMMTOOLS=False
)

REM Visual Studio 2012
IF EXIST "%PathMSVS2012%" (
    SET Detect_MSVS110COMMTOOLS=True
    IF %Detect_MicrosoftVisualStudio% EQU False SET Detect_MicrosoftVisualStudio=True
) ELSE (
    SET Detect_MSVS110COMMTOOLS=False
)

REM Visual Studio 2013
IF EXIST "%PathMSVS2013%" (
    SET Detect_MSVS120COMMTOOLS=True
    IF %Detect_MicrosoftVisualStudio% EQU False SET Detect_MicrosoftVisualStudio=True
) ELSE (
    SET Detect_MSVS120COMMTOOLS=False
)

REM Microsoft HTML Workshop
IF EXIST "%PathMSHTMLWorkShop%.exe" (
    SET Detect_MSHTMLWorkShop=True
) ELSE (
    SET Detect_MSHTMLWorkShop=False
)

REM MinGW
IF EXIST "%PathMinGW%" (
    SET Detect_MinGW=True
) ELSE (
    SET Detect_MinGW=False
)

REM Inno Setup
IF EXIST "%PathInnoSetup%" (
    SET Detect_InnoSetup=True
) ELSE (
    SET Detect_InnoSetup=False
)

REM 7Zip
IF EXIST "%Path7Zip%" (
    SET Detect_7Zip=True
) ELSE (
    SET Detect_7Zip=False
)

REM This is treated differently as it could be invoked while in %PATH%
REM Python v3
IF %Detect_Python3% EQU False (
    IF EXIST "%PathPython3%" SET Detect_Python3=True
)

REM Python v2
IF EXIST "%PathPython2%" (
    SET Detect_Python2=True
) ELSE (
    SET Detect_Python2=False
)

REM SVN
REM Besides checking the filesystem, just do an invoke check.
SVN 2> NUL 1> NUL
IF %ERRORLEVEL% EQU 1 (
    SET Detect_SVN=True
) ELSE (
    SET Detect_SVN=False
)

REM Git
REM Besides checking the filesystem, just do an invoke check.
GIT 2> NUL 1> NUL
IF %ERRORLEVEL% EQU 1 (
    SET Detect_Git=True
) ELSE (
    SET Detect_Git=False
)



REM Robocopy
REM Besides checking the filesystem, just do an invoke check.
REM   Robocopy was never officially added into Windows until Windows Vista and later.
REM   To avoid conflicts with Windows XP and Windows 2000 users, run a check.
ROBOCOPY 2> NUL 1> NUL
IF %ERRORLEVEL% EQU 16 (
    SET Detect_Robocopy=True
) ELSE (
    SET Detect_Robocopy=False
)
REM Finished
REM ----
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect the HTML Workshop software.
REM # =============================================================================================
:EnvironmentSetup_FindDefault_HTMLWorkshop
IF EXIST "%ProgramFiles%\HTML Help Workshop\hhc.exe" (
    SET "PathMSHTMLWorkShop=%ProgramFiles%\HTML Help Workshop\hhc"
) ELSE (
    SET "PathMSHTMLWorkShop=%ProgramFiles(x86)%\HTML Help Workshop\hhc"
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect the 7Zip software.
REM # =============================================================================================
:EnvironmentSetup_FindDefault_7Zip
IF EXIST "%ProgramFiles%\7-Zip\7z.exe" (
    SET "Path7Zip=%ProgramFiles%\7-Zip\7z.exe"
) ELSE (
    SET "Path7Zip=%ProgramFiles(x86)%\7-Zip\7z.exe"
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect the Inno Setup software.
REM # =============================================================================================
:EnvironmentSetup_FindDefault_InnoSetup
IF EXIST %programfiles%\Inno Setup 5\iscc.exe (
    SET "PathInnoSetup=%programfiles%\Inno Setup 5\iscc.exe"
) ELSE (
    SET "PathInnoSetup=%programfiles(x86)%\Inno Setup 5\iscc.exe"
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect Python version 3.x
REM # =============================================================================================
:EnvironmentSetup_FindDefault_Python3
REM If incase the user allowed Python (or did it themselves) to be included in $PATH.
py --help 2> NUL 1> NUL
IF %ERRORLEVEL% EQU 0 (
    SET PathPython3=py
    SET Detect_Python3=True
) ELSE (
    SET "PathPython3=%SYSTEMDRIVE%\Python33\python.exe"
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect Python version 2.7.x
REM # =============================================================================================
:EnvironmentSetup_FindDefault_Python2
IF EXIST "%SYSTEMDRIVE%\Python27\python.exe" (
    SET Detect_Python2=True
)
SET "PathPython2=%SYSTEMDRIVE%\Python27\python.exe"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Try to automatically detect all of the .NET framework foundation software.
REM # =============================================================================================
:EnvironmentSetup_Find_dotNETFoundations
REM Check to see if the user has the specified .NET foundations installed within the system
REM ----
REM .NET Framework v1
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v1.0.3705" SET Detect_dotNET1=True
REM ----
REM .NET Framework v1.1
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v1.1.4322" SET Detect_dotNET1.1=True
REM ----
REM .NET Framework v2
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v2.0.50727" SET Detect_dotNET2=True
IF EXIST "%WINDIR%\Microsoft.NET\Framework64\v2.0.50727" SET Detect_dotNET2-64=True
REM ----
REM .NET Framework v3
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v3.0" SET Detect_dotNET3=True
IF EXIST "%WINDIR%\Microsoft.NET\Framework64\v3.0" SET Detect_dotNET3-64=True
REM ----
REM .NET Framework v3.5
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v3.5" SET Detect_dotNET3.5=True
IF EXIST "%WINDIR%\Microsoft.NET\Framework64\v3.5" SET Detect_dotNET3.5-64=True
REM ----
REM .NET Framework v4
IF EXIST "%WINDIR%\Microsoft.NET\Framework\v4.0.30319" SET Detect_dotNET4=True
IF EXIST "%WINDIR%\Microsoft.NET\Framework64\v4.0.30319" SET Detect_dotNET4-64=True
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Determine wither or not the program is executed with administrative access
REM # =============================================================================================
:EnvironmentSetup_CheckEnvironmentPrivileges
REM This merely checks if the program has enough privileges to access a certain directory.
"%SYSTEMROOT%\System32\icacls.exe" "%SYSTEMROOT%\System32\Config\System" > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    REM Executed without Root access
    SET Detect_RootAccess=False
) ELSE (
    REM Executed with Root access
    SET Detect_RootAccess=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Filter the date and time and store their filtered value into variables.  This will allow other programs to use date and time as filenames.
REM # =============================================================================================
:EnvironmentSetup_Setup_Time-and-Date
REM These are special statements that are used to clean up the date string so that information can be used within the filesystem as a file or directory.
REM Date
FOR /F "tokens=1-3 delims=/." %%a IN ("%DATE%") DO SET "core.Date=%%a_%%b_%%c"
REM Time
FOR /F "tokens=1-3 delims=:." %%a IN ("%TIME%") DO SET "core.Time=%%a-%%b-%%c"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function clears out sensitive identifiers from the program.  As Batch does not clear out the identifiers after the program has been terminated, this function will house variables that need to be cleared out before the session ends.
REM # =============================================================================================
:EnvironmentSetup_UninitializeVars
REM 7Zip key
SET SevZipKey=
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will check to see how many logical cores the host system has available.  This function is dedicated for 7Zip program, Multithreading functionality.  If the host system does NOT have any multithreading capabilities available, this program will disable the multithreading functionality when 7Zip is being called.
REM # =============================================================================================
:EnvironmentSetup_CheckCPULogicalProcessors
IF %Number_Of_Processors% EQU 0 (
    SET SevZipMultiThreadingCPU=off
) ELSE (
    SET SevZipMultiThreadingCPU=on
)
GOTO :EOF