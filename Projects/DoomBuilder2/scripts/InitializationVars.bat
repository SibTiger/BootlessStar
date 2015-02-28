REM =====================================================================
REM Initialization Driver
REM ----------------------------
REM This driver will manage how to either initialize identifiers or if the configuration needs to be saved.
REM =====================================================================


REM # =============================================================================================
REM # Parameters: [{String} Mode] [{String} Options] [{String} TargetPath]
REM # Documentation: This function, depending how it is called - which is set by the first parameter [MODE], will help set up the environment for the program, create or update a user configuration, or update the project resource targets [plugins, directories, etc].
REM # =============================================================================================
:Initialization_Driver
REM This driver requires parameters:
REM     [Mode] (OPTIONS) (PATH)
REM When starting the program, this function will be executed.
IF %1 EQU Load (
    REM Parameters: [Mode = Load]
    REM Load the environment field when starting up the program or when this block is executed.
    CALL :Initialization_IdentifiersStatic
    CALL :Initialization_IdentifiersUserSettings 0
    CALL :Initialization_LocalDirectories
    CALL :UserPreset_Driver 0
    CALL :Initialization_ProjectDirectories
    CALL :Initialization_UpdateLogging
    GOTO :EOF
)
IF %1 EQU SaveUserConfig (
    REM Parameters: [Mode = SaveUserConfig] [File to Output]
    REM Write the current user configuration that is in current active memory and write it to a file.
    CALL :Initialization_IdentifiersUserSettings 1 "%~2"
    GOTO :EOF
)
IF %1 EQU UpdateProjectTargets (
    CALL :Initialization_ProjectDirectories
    GOTO :EOF
)



REM =====================================================================
REM Module Initialization Functions
REM ----------------------------
REM These functions are designed to help setup the environment
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function sets the static environment for the module, and other variables that is self managed 1ithin the program.
REM # =============================================================================================
:Initialization_IdentifiersStatic
REM Static Variables
SET ProjectName=Doom Builder 2
SET ProjectNameShort=DB2
SET ProjectVersion=1.5.3
SET ReleaseDate=6.June.2014
SET ProjectNameCompact=DoomBuilder2
REM Used as the filename and directory when compiling the project.  This is built in the compiling protocol, just let it as 'UNKNOWN' here and change it later.
SET FileName=UNKNOWN
SET FileName_Archive=UNKNOWN
SET FileName_Setup=UNKNOWN
REM Error Signal for Operations; if the value is not null, there was a general issue with a function or functions in sequence.
SET ErrorSignal=0
REM Exit Code captures ErrorLevel - but retains the xid.
SET ExitCode=0
REM Fatal Exit retains the exit code from the lower level [spine of the program]; if there is an error from the lower level, then this variable will be updated.
SET FatalExit=0
REM What internal or external CMD was called, this is going to be used primarily for logs and error messages.  Make this easy for the user to understand what program was called, do not make it complicated.
SET TaskCaller_NiceProgramName=NULL
REM Compiled version of 'TaskCaller' into one string.
SET TaskCaller_CallLong=NULL
REM Static SVN revision number holders
SET SVNRevisionOld=-1
SET SVNRevisionNew=-1
SET SVNRevisionRange=0
REM A set hard limit for retrieving the SVN change log history
SET SVNRevisionRangeHardLimit=50
REM Can we update the cached revision that is stored in a small ASCII file?
SET SVNRevisionUpdateCachedRevisionID=False
REM This houses the parameters for 7Zip, this gets filled when we need to invoke it.
SET SevenZipCompactParameters=-
REM Can we find the main project?
SET Detect_ProjectCore=False
REM Update the internal project version ID?
SET ProjectModify.UpdateInternalProjectVersion=False
REM Parameters to be used when using MSBuild from Microsoft Visual Studio packages.
SET "MSVSArg=/t:Rebuild /p:Configuration=Release;Platform=x86 /v:quiet"
REM Parameters to be used when using VCUpgrade from Microsoft Visual Studio packages.
SET "MSVSArgVPO=/p:Configuration=Release;Platform=Win32 /v:quiet"
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET DriversNiceTask=UNKNOWN
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will set the Local Directory targets.  These local directories are necessary for the program to work correctly.
REM # =============================================================================================
:Initialization_LocalDirectories
REM Note: DirLocal is merely a simple dedicated directory for output data and saved data.
SET "LocalDirectory.MainRoot=%DirProjects%\%ProjectNameCompact%"
REM Temporary data
SET "LocalDirectory.Temp=%LocalDirectory.MainRoot%\Temp"
REM Preset Configurations
SET "LocalDirectory.UserConfig=%LocalDirectory.MainRoot%\Config"
REM Archive builds [compiled]
SET "LocalDirectory.Archives=%LocalDirectory.MainRoot%\Archives"
REM Inno Setup Builds
SET "LocalDirectory.Setup=%LocalDirectory.MainRoot%\Setup"
REM Regular data files
SET "LocalDirectory.Builds=%LocalDirectory.MainRoot%\Builds"
REM Log Files
SET "LocalDirectory.Logs=%LocalDirectory.MainRoot%\Logs"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function holds the project's resource targets: important directories, executable binaries, solution projects, assembly files, etc.
REM # =============================================================================================
:Initialization_ProjectDirectories
REM Doom Builder 2 Directories
REM NOTE: The root directory is defined within the user configuration.
REM   VersionFromSVN
SET "ProjectDirectory.VersionFromSVN=%UserConfig.DirProjectWorkingCopy%\VersionFromSVN.exe"
REM   Directories
SET "ProjectDirectory.DirCompiledTarget=%UserConfig.DirProjectWorkingCopy%\Build"
SET "ProjectDirectory.DirCompileSetupTarget=%ProjectDirectory.DirCompiledTarget%\Setup"
SET "ProjectDirectory.DirPluginsTarget=%UserConfig.DirProjectWorkingCopy%\Source\Plugins"
SET "ProjectDirectory.DirHelpTarget=%UserConfig.DirProjectWorkingCopy%\Help"
SET "ProjectDirectory.DirSetupTarget=%UserConfig.DirProjectWorkingCopy%\Setup"
SET "ProjectDirectory.DirReleaseTarget=%UserConfig.DirProjectWorkingCopy%\Release"
REM ------------
REM   Core
REM ------------
SET "ProjectDirectory.PathCoreEngine=%UserConfig.DirProjectWorkingCopy%\Source\Core\Builder.csproj"
SET "ProjectDirectory.PathCoreAssembly=%UserConfig.DirProjectWorkingCopy%\Source\Core\Properties\AssemblyInfo.cs"
REM ------------
REM   Plugins
REM ------------
REM    Builder Modes
SET "ProjectDirectory.PathPluginBuilderModes=%ProjectDirectory.DirPluginsTarget%\BuilderModes\BuilderModes.csproj"
SET "ProjectDirectory.PathPluginBuilderModesAssembly=%ProjectDirectory.DirPluginsTarget%\BuilderModes\Properties\AssemblyInfo.cs"
REM ----
REM    Comments Panel
SET "ProjectDirectory.PathPluginCommentsPanel=%ProjectDirectory.DirPluginsTarget%\CommentsPanel\CommentsPanel.csproj"
SET "ProjectDirectory.PathPluginCommentsPanelAssembly=%ProjectDirectory.DirPluginsTarget%\CommentsPanel\Properties\AssemblyInfo.cs"
REM ----
REM    Copy and Paste Sector Properties
SET "ProjectDirectory.PathPluginCopyPaste=%ProjectDirectory.DirPluginsTarget%\CopyPasteSectorProps\CopyPasteSectorProperties.csproj"
SET "ProjectDirectory.PathPluginCopyPasteAssembly=%ProjectDirectory.DirPluginsTarget%\CopyPasteSectorProps\Properties\AssemblyInfo.cs"
REM ----
REM    Image Drawing Example
SET "ProjectDirectory.PathPluginImageDraw=%ProjectDirectory.DirPluginsTarget%\ImageDrawingExample\ImageDrawingExample.csproj"
SET "ProjectDirectory.PathPluginImageDrawAssembly=%ProjectDirectory.DirPluginsTarget%\ImageDrawingExample\Properties\AssemblyInfo.cs"
REM ----
REM    Statistics
SET "ProjectDirectory.PathPluginStatistics=%ProjectDirectory.DirPluginsTarget%\Statistics\Statistics.csproj"
SET "ProjectDirectory.PathPluginStatisticsAssembly=%ProjectDirectory.DirPluginsTarget%\Statistics\Properties\AssemblyInfo.cs"
REM ----
REM    TagRange
SET "ProjectDirectory.PathPluginTagRange=%ProjectDirectory.DirPluginsTarget%\TagRange\TagRange.csproj"
SET "ProjectDirectory.PathPluginTagRangeAssembly=%ProjectDirectory.DirPluginsTarget%\TagRange\Properties\AssemblyInfo.cs"
REM ----
REM    USDF
SET "ProjectDirectory.PathPluginUSDF=%ProjectDirectory.DirPluginsTarget%\USDF\USDF.csproj"
SET "ProjectDirectory.PathPluginUSDFAssembly=%ProjectDirectory.DirPluginsTarget%\USDF\Properties\AssemblyInfo.cs"
REM ----
REM    GZDoom Visual Mode
SET "ProjectDirectory.PathPluginGZDoomVirtualMode=%ProjectDirectory.DirPluginsTarget%\GZDoomEditing\GZDoomEditing.csproj"
SET "ProjectDirectory.PathPluginGZDoomVirtualModeAssembly=%ProjectDirectory.DirPluginsTarget%\GZDoomEditing\Properties\AssemblyInfo.cs"
REM ----
REM    WADAuthor Visual Mode
SET "ProjectDirectory.PathPluginWadAuthorVirtualMode=%ProjectDirectory.DirPluginsTarget%\WadAuthorMode\WadAuthorMode.csproj"
SET "ProjectDirectory.PathPluginWadAuthorVirtualModeAssembly=%ProjectDirectory.DirPluginsTarget%\WadAuthorMode\Properties\AssemblyInfo.cs"
REM ----
REM    Visplane Explorer [Dynamic Link Library]
SET "ProjectDirectory.PathPluginVisplaneExplorerLibraryDir=%ProjectDirectory.DirPluginsTarget%\vpo_dll\"
SET "ProjectDirectory.PathPluginVisplaneExplorerLibrary=%ProjectDirectory.DirPluginsTarget%\vpo_dll\vpo_dll.vcproj"
SET "ProjectDirectory.PathPluginVisplaneExplorerLibraryUpgrade=%ProjectDirectory.DirPluginsTarget%\vpo_dll\vpo_dll.vcxproj"
SET "ProjectDirectory.PathPluginVisplaneExplorerDir=%ProjectDirectory.DirPluginsTarget%\VisplaneExplorer\Resources\"
REM ----
REM    Visplane Explorer
SET "ProjectDirectory.PathPluginVisplaneExplorer=%ProjectDirectory.DirPluginsTarget%\VisplaneExplorer\VisplaneExplorer.csproj"
SET "ProjectDirectory.PathPluginVisplaneExplorerAssembly=%ProjectDirectory.DirPluginsTarget%\VisplaneExplorer\Properties\AssemblyInfo.cs"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{Int} Mode] [{String} UserConfigOutput]
REM # Documentation: This function houses the users settings and customizations; this manages both loading and writing to a file, depending on the argument when this function is called.
REM #  First Parameter:
REM #   0 = Read\Load
REM #   1 = Write to specific file
REM #  Second Parameter:
REM #   Output File
REM # =============================================================================================
:Initialization_IdentifiersUserSettings
REM --------------------------------
REM ================================
REM Subversion Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM Subversion Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Allow the program to use Subversion commandline?
IF %1 EQU 0 (SET UserConfig.SVNMasterControl=True)
IF %1 EQU 1 (ECHO REM Allow the program to use Subversion CUI)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.SVNMasterControl=%UserConfig.SVNMasterControl%)>> "%~2"
REM ----
REM Allow the working copy to be restored to its original state?
IF %1 EQU 0 (SET UserConfig.SVNAllowWorkingCopyRevert=False)
IF %1 EQU 1 (ECHO REM Allow the program to completely revert and clean up the Working Copy?  For safety reasons, this is disabled by default, only enable this if you do NOT plan to leave uncommitted work in that entire directory tree!)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.SVNAllowWorkingCopyRevert=%UserConfig.SVNAllowWorkingCopyRevert%)>> "%~2"
REM ----
REM Allow the working copy to be updated?
IF %1 EQU 0 (SET UserConfig.SVNAllowWorkingCopyUpdate=True)
IF %1 EQU 1 (ECHO REM Allow the program to update the Working Copy.)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.SVNAllowWorkingCopyUpdate=%UserConfig.SVNAllowWorkingCopyUpdate%)>> "%~2"
REM ----
REM Allow the program to fetch for the SVN revision log history?
IF %1 EQU 0 (SET UserConfig.SVNAllowFetchRevisionLog=True)
IF %1 EQU 1 (ECHO REM This allows the program to fetch the SVN revision log.)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.SVNAllowFetchRevisionLog=%UserConfig.SVNAllowFetchRevisionLog%)>> "%~2"
REM ----
REM Allow the program to fetch for the SVN revision log history in XML format?
IF %1 EQU 0 (SET UserConfig.SVNAllowFetchRevisionLogXML=False)
IF %1 EQU 1 (ECHO REM This allows the program to fetch the SVN revision log in XML formatting.)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.SVNAllowFetchRevisionLogXML=%UserConfig.SVNAllowFetchRevisionLogXML%)>> "%~2"


IF %1 EQU 1 (ECHO.)>> "%~2"
REM 7Zip Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM 7Zip Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Allow the program to use 7Zip?
IF %1 EQU 0 (SET UserConfig.7ZipMasterControl=False)
IF %1 EQU 1 (ECHO REM Allow the program to use 7Zip)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.7ZipMasterControl=%UserConfig.7ZipMasterControl%)>> "%~2"
REM ----
REM Allow the program to generate an archive file?
IF %1 EQU 0 (SET UserConfig.7ZipGenerateArchive=False)
IF %1 EQU 1 (ECHO REM This can allow the program to generate an archive file.)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.7ZipGenerateArchive=%UserConfig.7ZipGenerateArchive%)>> "%~2"
REM ----


IF %1 EQU 1 (ECHO.)>> "%~2"
REM Inno Setup Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM Inno Setup Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Allow the program to use Inno Setup Generator?
IF %1 EQU 0 (SET UserConfig.InnoMasterControl=False)
IF %1 EQU 1 (ECHO REM Allow the program to use Inno Setup)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.InnoMasterControl=%UserConfig.InnoMasterControl%)>> "%~2"
REM ----
REM Allow the program to build a setup package?
IF %1 EQU 0 (SET UserConfig.InnoGenerateSetup=False)
IF %1 EQU 1 (ECHO REM Allows the program to generate a setup package.)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.InnoGenerateSetup=%UserConfig.InnoGenerateSetup%)>> "%~2"


IF %1 EQU 1 (ECHO.)>> "%~2"
REM Directory Management Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM Directory Management Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Direct location of the project location [must be in the same path as the solution file]
IF %1 EQU 0 (SET "UserConfig.DirProjectWorkingCopy=%UserProfile%\DoomBuilder\Trunk")
IF %1 EQU 1 (ECHO REM Path to the project.  This is crucially important for the program to have the correct path, otherwise this program will not properly work.)>> "%~2"
IF %1 EQU 1 (ECHO SET "UserConfig.DirProjectWorkingCopy=%UserConfig.DirProjectWorkingCopy%")>> "%~2"
REM ----
REM Allow the program to keep the setup directory, which contains the dependencies for the compiled project.
IF %1 EQU 0 (SET UserConfig.KeepSetupDir=False)
IF %1 EQU 1 (ECHO REM Allow the program to keep the Setup Directory within the Working Copy)>> "%~2"
IF %1 EQU 1 (ECHO SET UserConfig.KeepSetupDir=%UserConfig.KeepSetupDir%)>> "%~2"
REM ----
REM Thrash the data that was transfered to the Standard Output [when only: compacting to archive or setup package]
IF %1 EQU 0 (SET UserConfig.MirrorCompiledData=True)
IF %1 EQU 1 (ECHO REM Remove the compiled data that was transported to DirLocal.)>> "%~2"
IF %1 EQU 1 (ECHO SET "UserConfig.MirrorCompiledData=%UserConfig.MirrorCompiledData%")>> "%~2"


IF %1 EQU 1 (ECHO.)>> "%~2"
REM Program Management Settings
REM -------------------------------------
IF %1 EQU 1 (ECHO REM Program Management Settings)>> "%~2"
IF %1 EQU 1 (ECHO REM --------------------)>> "%~2"
REM ----
REM Choose the default Visual Studio environment when compiling the project and its resources.
IF %1 EQU 0 CALL :VisualStudio_AutomaticDetection
IF %1 EQU 1 (ECHO REM Choose the default Visual Studio environment when compiling the project and its resources.)>> "%~2"
IF %1 EQU 1 (ECHO SET "VisualStudio=%VisualStudio%")
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the log file name, if logging is enabled.
REM # =============================================================================================
:Initialization_UpdateLogging
IF "%ToggleLog%" NEQ "False" SET "STDOUT=%LocalDirectory.Logs%\%ProjectNameCompact%_%core.Date%.txt"
GOTO :EOF