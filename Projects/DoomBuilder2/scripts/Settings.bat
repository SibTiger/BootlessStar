REM =====================================================================
REM Settings Menu
REM ----------------------------
REM This allows the user to manipulate some settings that is available in this module script.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Main Control Panel
REM # =============================================================================================
:Settings
CALL :DashboardOrClassicalDisplay
ECHO Control Panel
ECHO %Separator%
ECHO.
ECHO [1] SVN Settings
ECHO [2] 7Zip Settings
ECHO [3] Inno Setup
ECHO [4] Visual Studio Setup
ECHO [5] Directory Management
ECHO [U] Update Saved Profile named: %UserConfigurationLoaded%
ECHO [X] Exit
CALL :UserInput
GOTO :Settings_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:Settings_UserInput
IF "%STDIN%" EQU "1" GOTO :SettingsChoice_SVN
IF "%STDIN%" EQU "2" GOTO :SettingsChoice_7Zip
IF "%STDIN%" EQU "3" GOTO :SettingsChoice_Inno
IF "%STDIN%" EQU "4" GOTO :SettingsChoice_VisualStudio
IF "%STDIN%" EQU "5" GOTO :SettingsChoice_DirectoryManagement
IF /I "%STDIN%" EQU "U" GOTO :SettingsChoice_UpdateProfile
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :Settings



REM # =============================================================================================
REM # Documentation: Subversion Settings
REM # =============================================================================================
:SettingsChoice_SVN
CALL :ClearBuffer
CALL :SettingsSVN_Menu
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: 7Zip Settings
REM # =============================================================================================
:SettingsChoice_7Zip
CALL :ClearBuffer
CALL :Settings7Zip_Menu
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Inno Settings
REM # =============================================================================================
:SettingsChoice_Inno
CALL :ClearBuffer
CALL :SettingsInno_Menu
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Visual Studio Settings
REM # =============================================================================================
:SettingsChoice_VisualStudio
CALL :ClearBuffer
CALL :SettingsVisualStudio_Menu
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: Directory Settings
REM # =============================================================================================
:SettingsChoice_DirectoryManagement
CALL :ClearBuffer
CALL :SettingsDirectoryManagement_Menu
CALL :ClearBuffer
GOTO :Settings



REM # =============================================================================================
REM # Documentation: User Configuration Settings
REM # =============================================================================================
:SettingsChoice_UpdateProfile
CALL :ClearBuffer
CALL :UserPreset_Driver 1
CALL :ClearBuffer
GOTO :Settings



REM ============================================================



REM # =============================================================================================
REM # Documentation: Subversion Commandline Settings Menu
REM # =============================================================================================
:SettingsSVN_Menu
CALL :DashboardOrClassicalDisplay
ECHO Subversion Control Panel
ECHO %Separator%
ECHO.
ECHO [1] SVN Master Control
ECHO     When set to 'True', this will allow the program to utilize SVN features and functionality.
ECHO     - Current Value: [%UserConfig.SVNMasterControl%]
ECHO     - Detected: [%Detect_SVN%]
ECHO.
ECHO [2] Allow Local Working Copy Upkeep
ECHO     Do not enable this if you store uncommitted or altered data within the local working copy, as _revert_ will restore the entire working copy to its original state.
ECHO     - Current Value: [%UserConfig.SVNAllowWorkingCopyRevert%]
ECHO.
ECHO [3] Allow Local Working Copy to be Updated
ECHO     Allow the local working copy to be updated to that latest revision.
ECHO     - Current Value: [%UserConfig.SVNAllowWorkingCopyUpdate%]
ECHO.
ECHO [4] Allow finding changelog history
ECHO     Allow the program to fetch a changelog ^(SVN Revision log^) history of the %ProjectName% project.
ECHO     - Current Value: [%UserConfig.SVNAllowFetchRevisionLog%]
ECHO.
ECHO [5] Allow finding changelog history in XML format
ECHO     Allow the program to fetch a changelog ^(SVN Revision log^) history of the %ProjectName% project in XML formatting.
ECHO     - Current Value: [%UserConfig.SVNAllowFetchRevisionLogXML%]
ECHO.
ECHO [X] Exit
CALL :UserInput
GOTO :SettingsSVN_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:SettingsSVN_UserInput
IF "%STDIN%" EQU "1" GOTO :SettingsSVN_ToggleMaster
IF "%STDIN%" EQU "2" GOTO :SettingsSVN_ToggleWorkingCopyRevert
IF "%STDIN%" EQU "3" GOTO :SettingsSVN_ToggleWorkingCopyUpdate
IF "%STDIN%" EQU "4" GOTO :SettingsSVN_ToggleFetchRevisionLog
IF "%STDIN%" EQU "5" GOTO :SettingsSVN_ToggleFetchRevisionLogXML
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :SettingsSVN_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to use Subversion?  If this is set to false, the program is _NOT_ allowed to use Subversion commandline utilities.
REM # =============================================================================================
:SettingsSVN_ToggleMaster
IF %UserConfig.SVNMasterControl% EQU True (
    SET UserConfig.SVNMasterControl=False
) ELSE (
    SET UserConfig.SVNMasterControl=True
)
CALL :ClearBuffer
GOTO :SettingsSVN_Menu



REM # =============================================================================================
REM # Documentation: This allows the program to revert the local working copy contents.
REM # =============================================================================================
:SettingsSVN_ToggleWorkingCopyRevert
IF %UserConfig.SVNAllowWorkingCopyRevert% EQU True (
    SET UserConfig.SVNAllowWorkingCopyRevert=False
) ELSE (
    SET UserConfig.SVNAllowWorkingCopyRevert=True
)
CALL :ClearBuffer
GOTO :SettingsSVN_Menu



REM # =============================================================================================
REM # Documentation: This allows the program to update the local working copy contents.
REM # =============================================================================================
:SettingsSVN_ToggleWorkingCopyUpdate
IF %UserConfig.SVNAllowWorkingCopyUpdate% EQU True (
    SET UserConfig.SVNAllowWorkingCopyUpdate=False
) ELSE (
    SET UserConfig.SVNAllowWorkingCopyUpdate=True
)
CALL :ClearBuffer
GOTO :SettingsSVN_Menu



REM # =============================================================================================
REM # Documentation: This will allow the program to fetch the revision changelog history.
REM # =============================================================================================
:SettingsSVN_ToggleFetchRevisionLog
IF %UserConfig.SVNAllowFetchRevisionLog% EQU True (
    SET UserConfig.SVNAllowFetchRevisionLog=False
) ELSE (
    SET UserConfig.SVNAllowFetchRevisionLog=True
)
CALL :ClearBuffer
GOTO :SettingsSVN_Menu



REM # =============================================================================================
REM # Documentation: This will allow the program to fetch the revision changelog history in an XML advanced formatting.
REM # =============================================================================================
:SettingsSVN_ToggleFetchRevisionLogXML
IF %UserConfig.SVNAllowFetchRevisionLogXML% EQU True (
    SET UserConfig.SVNAllowFetchRevisionLogXML=False
) ELSE (
    SET UserConfig.SVNAllowFetchRevisionLogXML=True
)
CALL :ClearBuffer
GOTO :SettingsSVN_Menu



REM ============================================================



REM # =============================================================================================
REM # Documentation: 7Zip Settings Menu
REM # =============================================================================================
:Settings7Zip_Menu
CALL :DashboardOrClassicalDisplay
ECHO 7Zip Control Panel
ECHO %Separator%
ECHO.
ECHO [1] 7Zip Master Control
ECHO     When set to 'True', this will allow the program to utilize 7Zip features and functionality.
ECHO     - Current Value: [%UserConfig.7ZipMasterControl%]
ECHO     - Detected: [%Detect_SVN%]
ECHO.
ECHO [2] Generate project archive builds
ECHO     This can allow the freshly compiled project to be compacted into a archive file that will be generated by the use of 7zip.
ECHO     - Current Value: [%UserConfig.7ZipGenerateArchive%]
ECHO.
ECHO [X] Exit
CALL :UserInput
GOTO :Settings7Zip_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:Settings7Zip_UserInput
IF "%STDIN%" EQU "1" GOTO :Settings7Zip_ToggleMaster
IF "%STDIN%" EQU "2" GOTO :Settings7Zip_ToggleGenerateArchive
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :Settings7Zip_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to use 7Zip?  If this is set to false, the program is _NOT_ allowed to use 7Zip.
REM # =============================================================================================
:Settings7Zip_ToggleMaster
IF %UserConfig.7ZipMasterControl% EQU True (
    SET UserConfig.7ZipMasterControl=False
) ELSE (
    SET UserConfig.7ZipMasterControl=True
)
CALL :ClearBuffer
GOTO :Settings7Zip_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to create an archive?
REM # =============================================================================================
:Settings7Zip_ToggleGenerateArchive
IF %UserConfig.7ZipGenerateArchive% EQU True (
    SET UserConfig.7ZipGenerateArchive=False
) ELSE (
    SET UserConfig.7ZipGenerateArchive=True
)
CALL :ClearBuffer
GOTO :Settings7Zip_Menu



REM ============================================================



REM # =============================================================================================
REM # Documentation: Inno Setup Builder Settings Menu
REM # =============================================================================================
:SettingsInno_Menu
CALL :DashboardOrClassicalDisplay
ECHO Inno Setup Control Panel
ECHO %Separator%
ECHO.
ECHO [1] Inno Master Control
ECHO     When set to 'True', this will allow the program to utilize Inno features and functionality.
ECHO     - Current Value: [%UserConfig.InnoMasterControl%]
ECHO     - Detected: [%Detect_InnoSetup%]
ECHO.
ECHO [2] Generate project setup executable
ECHO     This can allow the freshly compiled project to be compact within a setup file.  Thus, this allows anyone to easily install the project by using this setup file, which most software comes with today for Windows OS's.
ECHO     - Current Value: [%UserConfig.InnoGenerateSetup%]
ECHO.
ECHO [X] Exit
CALL :UserInput
GOTO :SettingsInno_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:SettingsInno_UserInput
IF "%STDIN%" EQU "1" GOTO :SettingsInno_ToggleMaster
IF "%STDIN%" EQU "2" GOTO :SettingsInno_GenerateSetup
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :SettingsInno_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to use Inno?  If this is set to false, the program is _NOT_ allowed to use Inno Setup Builder.
REM # =============================================================================================
:SettingsInno_ToggleMaster
IF %UserConfig.InnoMasterControl% EQU True (
    SET UserConfig.InnoMasterControl=False
) ELSE (
    SET UserConfig.InnoMasterControl=True
)
CALL :ClearBuffer
GOTO :SettingsInno_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to create an setup package?
REM # =============================================================================================
:SettingsInno_GenerateSetup
IF %UserConfig.InnoGenerateSetup% EQU True (
    SET UserConfig.InnoGenerateSetup=False
) ELSE (
    SET UserConfig.InnoGenerateSetup=True
)
CALL :ClearBuffer
GOTO :SettingsInno_Menu



REM ============================================================



REM # =============================================================================================
REM # Documentation: Visual Studio Settings Menu
REM # =============================================================================================
:SettingsVisualStudio_Menu
CALL :DashboardOrClassicalDisplay
CALL :VisualStudio_FindNiceName
ECHO Visual Studio Control Panel
ECHO %Separator%
ECHO.
ECHO Currently using: [%VisualStudioNiceName%]
ECHO.
ECHO Select Visual Studio Environment
ECHO [1] Visual Studio 2008
ECHO     - Detected: [%Detect_MSVS90COMMTOOLS%]
ECHO.
ECHO [2] Visual Studio 2010
ECHO     - Detected: [%Detect_MSVS100COMMTOOLS%]
ECHO.
ECHO [3] Visual Studio 2012
ECHO     - Detected: [%Detect_MSVS110COMMTOOLS%]
ECHO.
ECHO [4] Visual Studio 2013
ECHO     - Detected: [%Detect_MSVS120COMMTOOLS%]
ECHO.
ECHO [Auto] Automatically determine best version
ECHO     This will try to automatically try to find the best Visual Studio environment version for the %ProjectName% project.
ECHO.
ECHO [X] Exit
CALL :UserInput
GOTO :SettingsVisualStudio_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:SettingsVisualStudio_UserInput
IF "%STDIN%" EQU "1" GOTO :SettingsVisualStudio_Toggle2008
IF "%STDIN%" EQU "2" GOTO :SettingsVisualStudio_Toggle2010
IF "%STDIN%" EQU "3" GOTO :SettingsVisualStudio_Toggle2012
IF "%STDIN%" EQU "4" GOTO :SettingsVisualStudio_Toggle2013
IF /I "%STDIN%" EQU "Auto" GOTO :SettingsVisualStudio_Automatic
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :SettingsVisualStudio_Menu



REM # =============================================================================================
REM # Documentation: Select Visual Studio 2008 as the primary compiler, if possible.
REM # =============================================================================================
:SettingsVisualStudio_Toggle2008
IF %Detect_MSVS90COMMTOOLS% EQU True IF "%VisualStudio%" NEQ "%PathMSVS2008%" SET "VisualStudio=%PathMSVS2008%"
CALL :ClearBuffer
GOTO :SettingsVisualStudio_Menu



REM # =============================================================================================
REM # Documentation: Select Visual Studio 2010 as the primary compiler, if possible.
REM # =============================================================================================
:SettingsVisualStudio_Toggle2010
IF %Detect_MSVS100COMMTOOLS% EQU True IF "%VisualStudio%" NEQ "%PathMSVS2010%" SET "VisualStudio=%PathMSVS2010%"
CALL :ClearBuffer
GOTO :SettingsVisualStudio_Menu



REM # =============================================================================================
REM # Documentation: Select Visual Studio 2012 as the primary compiler, if possible.
REM # =============================================================================================
:SettingsVisualStudio_Toggle2012
IF %Detect_MSVS110COMMTOOLS% EQU True IF "%VisualStudio%" NEQ "%PathMSVS2012%" SET "VisualStudio=%PathMSVS2012%"
CALL :ClearBuffer
GOTO :SettingsVisualStudio_Menu



REM # =============================================================================================
REM # Documentation: Select Visual Studio 2013 as the primary compiler, if possible.
REM # =============================================================================================
:SettingsVisualStudio_Toggle2013
IF %Detect_MSVS120COMMTOOLS% EQU True IF "%VisualStudio%" NEQ "%PathMSVS2013%" SET "VisualStudio=%PathMSVS2013%"
CALL :ClearBuffer
GOTO :SettingsVisualStudio_Menu



REM # =============================================================================================
REM # Documentation: Allow the program to automatically determine the best Visual Studio version.
REM # =============================================================================================
:SettingsVisualStudio_Automatic
CALL :VisualStudio_AutomaticDetection
CALL :ClearBuffer
CALL :SettingsVisualStudio_Menu



REM ============================================================



REM # =============================================================================================
REM # Documentation: Directory Management Settings Menu
REM # =============================================================================================
:SettingsDirectoryManagement_Menu
CALL :DashboardOrClassicalDisplay
ECHO Directory Control Panel
ECHO %Separator%
ECHO.
ECHO [1] Locate %ProjectName% Directory
ECHO     This defines where the program can locate the %ProjectName% directory.
ECHO     This is an important setting that must be properly defined, otherwise this program will not work correctly.
REM pass through the detection
CALL :DetectionProject "%UserConfig.DirProjectWorkingCopy%"
REM ----
REM Capture the string for the detection
CALL :ExitCodeIntToStringCommon %ERRORLEVEL%
ECHO     - Detected: [%ProcessVarA%]
REM ----
ECHO     - Current Value: [%UserConfig.DirProjectWorkingCopy%]
ECHO.
ECHO [2] Keep %ProjectName%'s Setup directory contents
ECHO     The Setup directory usually contains some necessary prerequisites, such as .NET foundation, and SlimDX for example.
ECHO     - Current Value: [%UserConfig.KeepSetupDir%]
ECHO.
ECHO [3] Duplicate the compiled data from %ProjectName% directories to the module's local directory.
ECHO     When True, this will mirror all of the compiled data from the %ProjectName% Build directory to the compiled directory stored in this program.
ECHO        Stored compiled data in this program can be located at:
ECHO          [ %LocalDirectory.Builds% ]
ECHO     - Current Value: [%UserConfig.MirrorCompiledData%]
ECHO.
ECHO [X] Exit
CALL :UserInput
GOTO :SettingsDirectoryManagement_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input.
REM # =============================================================================================
:SettingsDirectoryManagement_UserInput
IF "%STDIN%" EQU "1" GOTO :SettingsDirectoryManagement_TargetProjectDirectory
IF "%STDIN%" EQU "2" GOTO :SettingsDirectoryManagement_ToggleSetupDir
IF "%STDIN%" EQU "3" GOTO :SettingsDirectoryManagement_ToggleFlushCompiledData
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :SettingsDirectoryManagement_Menu



REM # =============================================================================================
REM # Documentation: This function helps the user to safely set the target path of the project.
REM #   Keep in mind, that the target path must point to the directory that contains 'builder.sln' file, otherwise, nothing can be set properly.
REM # =============================================================================================
:SettingsDirectoryManagement_TargetProjectDirectory
CALL :ClearBuffer
CALL :DashboardOrClassicalDisplay
ECHO Target Path: %ProjectName%
ECHO %Separator%
ECHO.
ECHO This setting is very important - as this will help the program to successfully detect where the %ProjectName% project can be located.
ECHO.
ECHO Current Target:
ECHO %UserConfig.DirProjectWorkingCopy%
CALL :DetectionProject "%UserConfig.DirProjectWorkingCopy%"
REM Capture the string for the detection
CALL :ExitCodeIntToStringCommon %ERRORLEVEL%
ECHO Detected: [%ProcessVarA%]
ECHO.
ECHO.
ECHO Enter a new target:
ECHO.
ECHO Other options:
ECHO [X] Exit
CALL :UserInput
REM If the user opts out, leave this function now.
IF /I "%STDIN%" EQU "X" CALL :ClearBuffer& GOTO :SettingsDirectoryManagement_Menu
CALL :SettingsDirectoryManagement_TargetProjectDirectoryManageUpdate-Filter
CALL :DetectionProject "%STDIN%"
CALL :SettingsDirectoryManagement_TargetProjectDirectoryManageUpdate %ERRORLEVEL%
IF %ERRORLEVEL% EQU 0 CALL :Initialization_Driver UpdateProjectTargets
REM -----
REM If the new target exists, then we're done.
IF %ERRORLEVEL% EQU 0 CALL :ClearBuffer& GOTO :SettingsDirectoryManagement_Menu
REM This function is already big enough
CALL :SettingsDirectoryManagement_TargetProjectDirectoryBadLocation
CALL :ClearBuffer&
GOTO :SettingsDirectoryManagement_TargetProjectDirectory



REM # =============================================================================================
REM # Documentation: If the specified path does not exist when the user is attempting to update the project's location within the working copy, this error message will be displayed on the screen.
REM # =============================================================================================
:SettingsDirectoryManagement_TargetProjectDirectoryBadLocation
ECHO.&ECHO.
ECHO ^<!^>       Bad Target       ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO !ERR: The location specified does not exist or the 'Builder.sln' file was not found.
ECHO.
ECHO Directory contains:
ECHO %STDIN%
ECHO %SeparatorLong%
DIR /B "%STDIN%"
ECHO %SeparatorLong%
ECHO.
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the project's Working Copy target.
REM # =============================================================================================
:SettingsDirectoryManagement_TargetProjectDirectoryManageUpdate
IF %1 EQU 1 (
    SET "UserConfig.DirProjectWorkingCopy=%STDIN%"
    SET Detect_ProjectCore=True
    EXIT /B 0
) ELSE (
    REM The target location does not exist or is not what we are wanting
    EXIT /B 1
)



REM # =============================================================================================
REM # Documentation: Filter any trailing back-slashes.  If incase the user adds '\' at the ending of the string, remove it as this can cause issues with some of the programs like Subversion, for example.
REM # =============================================================================================
:SettingsDirectoryManagement_TargetProjectDirectoryManageUpdate-Filter
REM Using the variable value, read the last character from the value.  -1 == One character from the right side
IF "%STDIN:~-1%" EQU "\" (
    REM Select the range, the -1 means we are limiting the right side; we're effectively dropping 'one' character.
    SET "STDIN=%STDIN:~0,-1%"
) ELSE (
    GOTO :EOF
)
REM If incase the user adds more of the back slashes for whatever reason, call the function again until it is fixed.
GOTO :SettingsDirectoryManagement_TargetProjectDirectoryManageUpdate-Filter



REM # =============================================================================================
REM # Documentation: Keep the Setup directory, which contains Doom Builder 2 based prerequisites like SlimDX and .NET 3.5 installation packages?
REM # =============================================================================================
:SettingsDirectoryManagement_ToggleSetupDir
IF %UserConfig.KeepSetupDir% EQU True (
    SET UserConfig.KeepSetupDir=False
) ELSE (
    SET UserConfig.KeepSetupDir=True
)
CALL :ClearBuffer
GOTO :SettingsDirectoryManagement_Menu



REM # =============================================================================================
REM # Documentation: Mirror the compiled data that is stored in the Build directory to the local directory.
REM # =============================================================================================
:SettingsDirectoryManagement_ToggleFlushCompiledData
IF %UserConfig.MirrorCompiledData% EQU True (
    SET UserConfig.MirrorCompiledData=False
) ELSE (
    SET UserConfig.MirrorCompiledData=True
)
CALL :ClearBuffer
GOTO :SettingsDirectoryManagement_Menu