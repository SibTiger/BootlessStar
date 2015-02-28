REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                          Check Resources


REM # =============================================================================================
REM # Documentation: This function will make sure that the all of the resources that are necessary for this program are available and ready.  If there is _one_ issue, terminate the program - unless it is possible to _assume_ settings automatically.
REM # =============================================================================================
:CompileProject_CheckResources
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Running Self-Check"
REM Print on the screen that the program is trying to self-check
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM ----
REM Check if the project can be detected
CALL :CompileProject_CheckResources_ProjectTarget || EXIT /B 1
REM ----
REM Check if all of the targets exists
CALL :CompileProject_CheckResources_CheckTargets || EXIT /B 1
REM ----
REM Make sure that their is a place to output the compiled data and not removed in the process.
CALL :CompileProject_CheckOutput || EXIT /B 1
REM ----
REM Check to make sure that 7Zip was detected
CALL :CompileProject_CheckResources_7Zip || EXIT /B 1
REM ----
REM Check to make sure that Subversion CommandLine Tools was detected
CALL :CompileProject_CheckResources_SVN || EXIT /B 1
REM ----
REM Check to make sure that Inno Setup Builder was detected
CALL :CompileProject_CheckResources_Inno || EXIT /B 1
REM ----
REM Check to make sure that the resources from Microsoft Visual Studio still exists
CALL :CompileProject_CheckResources_VisualStudio || EXIT /B 1
REM ----
REM Print the footer in the log.
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



:CompileProject_CheckResources_ProjectTarget
REM Were we able to find the projects directory?
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking if %ProjectName%'s directory exists"
IF %Detect_ProjectCore% EQU False (
    REM We can't find the project
    CALL :CompileProject_CheckResources_ProjectTarget_ERR
    EXIT /B 1
)
REM We can find the project
EXIT /B 0



:CompileProject_CheckResources_ProjectTarget_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_ProjectTarget_ERRLog
ECHO !ERR_CRIT!: Could not locate the %ProjectName% project!
ECHO This program can not continue until this issue has been resolved!
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckResources_ProjectTarget_ERRLog
(ECHO !ERR_CRIT!: Could not locate the %ProjectName% project!) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



:CompileProject_CheckResources_CheckTargets
REM Can we find all of the targets?
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking all of %ProjectName%'s resources and files"
REM VersionFromSVN Binary
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.VersionFromSVN%" || EXIT /B 1
REM ---
REM Build Directory
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.DirCompiledTarget%" || EXIT /B 1
REM ----
REM Help Directory
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.DirHelpTarget%" || EXIT /B 1
REM ----
REM Setup Directory
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.DirSetupTarget%" || EXIT /B 1
REM ----
REM Core Engine
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathCoreEngine%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathCoreAssembly%" || EXIT /B 1
REM ----
REM Builder Modes
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginBuilderModes%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginBuilderModesAssembly%" || EXIT /B 1
REM ----
REM Comments Panel
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginCommentsPanel%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginCommentsPanelAssembly%" || EXIT /B 1
REM ----
REM Copy Paste Sector Properties
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginCopyPaste%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginCopyPasteAssembly%" || EXIT /B 1
REM ----
REM Image Drawer
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginImageDraw%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginImageDrawAssembly%" || EXIT /B 1
REM ----
REM Statistics
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginStatistics%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginStatisticsAssembly%" || EXIT /B 1
REM ----
REM Tag Range
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginTagRange%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginTagRangeAssembly%" || EXIT /B 1
REM ----
REM USDF
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginUSDF%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginUSDFAssembly%" || EXIT /B 1
REM ----
REM GZDoom Virtual Mode
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginGZDoomVirtualMode%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginGZDoomVirtualModeAssembly%" || EXIT /B 1
REM ----
REM WADAuthor Virtual Mode
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginWadAuthorVirtualMode%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginWadAuthorVirtualModeAssembly%" || EXIT /B 1
REM ----
REM Visplane Explorer
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorerLibraryDir%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorerLibrary%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorerDir%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorer%" || EXIT /B 1
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorerAssembly%" || EXIT /B 1
REM ----
EXIT /B 0



:CompileProject_CheckResources_CheckTargets_Process
IF NOT EXIST "%~1" (
    CALL :CompileProject_CheckResources_CheckTargets_Process_ERR "%~1"
    EXIT /B 1
)
EXIT /B 0



REM # =============================================================================================
REM # Parameters: [{string} DefinedFile]
REM # Documentation: When a resource is not found within the filesystem, this function will display the error to the user.
REM # =============================================================================================
:CompileProject_CheckResources_CheckTargets_Process_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_CheckTargets_Process_ERRLog "%~1"
ECHO !ERR_CRIT!: Could not find file:
ECHO   %~1
ECHO.
ECHO This program can not continue until this issue has been resolved!  Check for program updates or check to make sure that the location is properly defined.
ECHO.
PAUSE
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} DefinedFile]
REM # Documentation: When a resource is not found within the filesystem, this function will log the error.
REM # =============================================================================================
:CompileProject_CheckResources_CheckTargets_Process_ERRLog
(ECHO !ERR_CRIT!: Could not find file:) >> %STDOUT%
(ECHO   %~1) >> %STDOUT%
(ECHO.) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!  Check for program updates or check to make sure that the location is properly defined.) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that there _is_ going to be an output.
REM # =============================================================================================
:CompileProject_CheckOutput
CALL :CompileProject_Display_IncomingTaskSubLevel "Making sure that there is going to be an output"
CALL :CompileProject_CheckOutput_Scan
CALL :CompileProject_CheckOutput_CheckResults || (CALL :CompileProject_CheckOutput_Scan_ERR& EXIT /B 1)
EXIT /B 0



:CompileProject_CheckOutput_Scan
REM ----
REM Subversion
IF %Detect_SVN% EQU False (SET ProcessVarA=False)
IF %UserConfig.SVNMasterControl% EQU False (SET ProcessVarA=False)
IF %UserConfig.SVNAllowWorkingCopyRevert% EQU True (SET ProcessVarA=False)
REM ----
REM 7Zip
IF %Detect_7Zip% EQU False (SET ProcessVarB=False)
IF %UserConfig.7ZipMasterControl% EQU False (SET ProcessVarB=False)
IF %UserConfig.7ZipGenerateArchive% EQU False (SET ProcessVarB=False)
REM ----
REM Inno Setup
IF %Detect_InnoSetup% EQU False (SET ProcessVarC=False)
IF %UserConfig.InnoMasterControl% EQU False (SET ProcessVarC=False)
IF %UserConfig.InnoGenerateSetup% EQU False (SET ProcessVarC=False)
REM ----
REM Mirror
IF %UserConfig.MirrorCompiledData% EQU False (SET ProcessVarD=False)
GOTO :EOF



:CompileProject_CheckOutput_CheckResults
REM If everything is false, then there's a potential error.
IF %ProcessVarA% EQU False IF %ProcessVarB% EQU False IF %ProcessVarC% EQU False IF %ProcessVarD% EQU False EXIT /B 1
EXIT /B 0



:CompileProject_CheckOutput_Scan_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckOutput_Scan_ERRLog
ECHO !ERR_CRIT!: There is no proper output!
ECHO   After the program has compiled the %ProjectName% project, it will not be available for the user as it will be overwritten in the SVN directory.  Please review the settings and make sure that the compiled output will be either mirrored or in an compact file.
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckOutput_Scan_ERRLog
(ECHO !ERR_CRIT!: There is no proper output!) >> %STDOUT%
(ECHO   After the program has compiled the %ProjectName% project, it will not be available for the user as it will be overwritten in the SVN directory.  Please review the settings and make sure that the compiled output will be either mirrored or in an compact file.) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the 7Zip software was detected from the core.
REM # =============================================================================================
:CompileProject_CheckResources_7Zip
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking if 7Zip was detected"
REM Check to see if the user toggled the Master Switch
CALL :CompileProject_CheckResources_CheckMasterSwitch %UserConfig.7ZipMasterControl% || EXIT /B 0
IF %Detect_7Zip% EQU False (
    REM We couldn't find the 7Zip software
    CALL :CompileProject_CheckResources_7Zip_ERR
    EXIT /B 1
)
REM Detected 7Zip
EXIT /B 0



:CompileProject_CheckResources_7Zip_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_7Zip_ERRLog
ECHO !ERR_CRIT!: Could not find 7Zip software!
ECHO This program can not continue until this issue has been resolved!
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckResources_7Zip_ERRLog
(ECHO !ERR_CRIT!: Could not find 7Zip software!) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the SVN software was detected from the core.
REM # =============================================================================================
:CompileProject_CheckResources_SVN
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking if Subversion CommandLine Tools was detected"
REM Check to see if the user toggled the Master Switch
CALL :CompileProject_CheckResources_CheckMasterSwitch %UserConfig.SVNMasterControl% || EXIT /B 0
IF %Detect_SVN% EQU False (
    REM We couldn't find the SVN software
    CALL :CompileProject_CheckResources_SVN_ERR
    EXIT /B 1
)
REM Detected SVN
EXIT /B 0



:CompileProject_CheckResources_SVN_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_SVN_ERRLog
ECHO !ERR_CRIT!: Could not find Subversion CommandLine Tools!
ECHO This program can not continue until this issue has been resolved!
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckResources_SVN_ERRLog
(ECHO !ERR_CRIT!: Could not find Subversion CommandLine Tools!) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the Inno Setup Builder software was detected from the core.
REM # =============================================================================================
:CompileProject_CheckResources_Inno
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking if Inno Setup Builder was detected"
REM Check to see if the user toggled the Master Switch
CALL :CompileProject_CheckResources_CheckMasterSwitch %UserConfig.InnoMasterControl% || EXIT /B 0
IF %Detect_InnoSetup% EQU False (
    REM We couldn't find the Inno Setup Builder software
    CALL :CompileProject_CheckResources_Inno_ERR
    EXIT /B 1
)
REM Detected Inno
EXIT /B 0



:CompileProject_CheckResources_Inno_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_Inno_ERRLog
ECHO !ERR_CRIT!: Could not find Inno Setup Builder!
ECHO This program can not continue until this issue has been resolved!
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckResources_Inno_ERRLog
(ECHO !ERR_CRIT!: Could not find Inno Setup Builder!) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Check to make sure that the Visual Studio resources still exists.
REM # =============================================================================================
:CompileProject_CheckResources_VisualStudio
CALL :CompileProject_Display_IncomingTaskSubLevel "Checking Microsoft Visual Studio resources are still available"

IF NOT EXIST "%VisualStudio%" (
    REM We couldn't find the resources from Visual Studio
    CALL :CompileProject_CheckResources_VisualStudio_ERR
    EXIT /B 1
)
REM Detected Visual Studio Resources
EXIT /B 0



:CompileProject_CheckResources_VisualStudio_ERR
IF %ToggleLog% EQU True CALL :CompileProject_CheckResources_VisualStudio_ERRLog
ECHO !ERR_CRIT!: Could not find the resources from Microsoft Visual Studio [ %VisualStudioNiceName% ]!
ECHO This program can not continue until this issue has been resolved!
ECHO.
PAUSE
GOTO :EOF



:CompileProject_CheckResources_VisualStudio_ERRLog
(ECHO !ERR_CRIT!: Could not find the resources from Microsoft Visual Studio [ %VisualStudioNiceName% ]!) >> %STDOUT%
(ECHO This program can not continue until this issue has been resolved!) >> %STDOUT%
(ECHO.) >> %STDOUT%
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{Bool} MasterSwitch]
REM # Documentation: Check the master switch value and return it's value in a Return call.
REM # =============================================================================================
:CompileProject_CheckResources_CheckMasterSwitch
IF %1 EQU False (
    REM The user requested that the 
    CALL :CompileProject_Display_IncomingTaskSubLevelMSG "Skipping; user requested."
    EXIT /B 1
) ELSE (
    EXIT /B 0
)