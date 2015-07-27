@REM This script is no longer supported!
@REM Please consider using the latest Bootless Star [core] version!
@REM This is only available for those that prefer to use this version specifically.
@REM History Note: This foundation is based from Beta 4
@REM    Filename: MakePrivateBuild.bat
@REM    CodeName: Bootless Star


@ECHO Executing %0...
@ECHO OFF
GOTO StartUp

REM =============================
REM TODO List:
::--------------------------------
REM Will Not Fix\Add:
REM * NavVar crashes; unless ported from HotCompiler
REM * Compress newly created projects
REM * Trim the Methods by use of Nested Conditional Statement
REM * Split sections to other scripts.
REM * When bad input or error method is reached, the user will revert to a user interactive method and not where the fault occurred specifically.
REM * Do not allow a setup environment.  Sorry, but I don't want to code this in to the program for personal reasons.
REM =============================


:: As this script file is large and does not call other scripts, Windows Batch will have to read line-by-line to find the proper destination.  As a result, this program may perform sluggish at times.

:StartUp
CLS
ECHO =====================================
ECHO =           Bootless Star           =
ECHO =====================================
ECHO Setting up environment...
ECHO. && ECHO. && ECHO.
GOTO HookClient


REM Hook the client's WD to be exactly the same as the program's absolute path.
REM This is necessary if the program is executed with Root access (Admin access).  Otherwise, the WD will be: %SystemRoot%\system32
:HookClient
REM Work around the ~dp0 value dynamically changing (Windows bug?)
REM This back-port fix from Bootless Star Beta 8
SET HookDir=%~dp0
REM Do we need to hook?
ECHO Comparing User Working Directory with Program Directory
IF "%CD%\" EQU "%HookDir%" (
	ECHO -Hook Skipped!
	GOTO FirstRun)
ECHO -Mismatch!
REM Hook the user
ECHO Hooking User's Working Directory...
CD /D "%HookDir%"
ECHO -Hooked!
ECHO Checking...
IF "%CD%\" EQU "%HookDir%" (
	ECHO -Successfully Hooked!
	GOTO FirstRun
) ELSE (
	ECHO -Failed to Hook!
	SET cacheNavVar=HookFail
	GOTO Kill
)


REM Setup the environment...
:FirstRun
ECHO Setting up static mutable variables...
SET HeadBorder======================================
SET HeadTitle==           Bootless Star           =
SET ProgramName=Bootless Star
SET ProgramVersion=1.00 Beta 7.8.1
SET Separator=-------------------------
ECHO -DONE!

ECHO.

ECHO Setting up navigational mutable variables...
SET NavVar=0
SET cacheNavVar=0
::Used for BadInput variable
SET STDINErr=NULL
SET ChoiceSel=Choice Options Available for User Input:
SET ChoiceKC=[O]kay or [C]ancel
SET ChoiceYN=[Y]es or [N]o
SET ChoiceTF=[T]rue or [F]alse
SET ChoiceNum=1 through 
SET ChoiceAlp=A through 
ECHO -DONE!

ECHO.

ECHO Setting up program mutable variables...
:: {0=Default|1=Everything}
SET Plugins=0
:: [DB2|DB64|GZDB|(Visplane)}
SET Project=UNKNOWN
:: {0=Disable|1=One beep compile & Two beeps for errors|2=Two beeps for errors only}
SET UsePCSpeaker=1
SET PCSpeaker=
:: This is simply useful for temporary storing and processing
SET ProcessValue=NOT_SET
SET CopyMethod=XCOPY
SET XCopyArg=/E /V /C /I /Y /Z
SET RoboCopyArg=/E /Z /COPYALL
:: No, this isn't the dreadful IntCMD.  No way in hell I am going to support it on this program, no - forget it.  Feel free to make a feature request for it and see how quick I will turn it down!
SET CopyArg=%XCopyArg%
SET MSVSArg=/t:Rebuild /p:Configuration=Release;Platform=x86 /v:quiet
SET MSVSArgVPO=/p:Configuration=Release;Platform=Win32 /v:quiet
SET FaultErrorID=0
SET DirSavePresets=.\Presets
SET DirSubScripts=.\Scripts
REM Duplication Detection Scheme [This would work much better within individual scripts; why I'm I focusing on the Users and not the program flexibility and power?]
SET DestroyBuild=UNKNOWN
SET ResumePointer=NOTSET
REM Standard Output
:: Inorder for this to work, we will append everything.  Redirecting only errors may not be possible, or efficient in our findings.
SET STDOUT=NUL
ECHO -DONE!

ECHO.

:: This program is always going to assume that we are outside from the working copy.
:: NOTE: Plugins that are marked as 'default' are based on 'MakeRelease.batch', on each project.
ECHO Setting up the Working Copy Directories mutable variables...
REM Master directory
SET DirParent=.\doombuilder

ECHO  Setting up the (Doom Builder 2) directory mutable variables...
SET DirDB2=%DirParent%\trunk
SET DB2CopyRange=%DirDB2%\Build
SET DB2PlugDir=%DirDB2%\Source\Plugins
SET DB2Help=%DirDB2%\Help
SET DB2Core=%DirDB2%\Source\Core\Builder.csproj
REM Plugins
::Default
::---------------------------
SET DB2PlugBuilderModes=%DB2PlugDir%\BuilderModes\BuilderModes.csproj
::---------------------------
SET DB2PlugComPan=%DB2PlugDir%\CommentsPanel\CommentsPanel.csproj
SET DB2PlugCopyPaste=%DB2PlugDir%\CopyPasteSectorProps\CopyPasteSectorProperties.csproj
SET DB2PlugImageDraw=%DB2PlugDir%\ImageDrawingExample\ImageDrawingExample.csproj
SET DB2PlugStats=%DB2PlugDir%\Statistics\Statistics.csproj
SET DB2PlugTagRange=%DB2PlugDir%\TagRange\TagRange.csproj
SET DB2PlugUSDF=%DB2PlugDir%\USDF\USDF.csproj
SET DB2PlugGZDoomVM=%DB2PlugDir%\GZDoomEditing\GZDoomEditing.csproj
SET DB2PlugWadAuthVM=%DB2PlugDir%\WadAuthorMode\WadAuthorMode.csproj
SET DB2PlugVisExpLib=%DB2PlugDir%\vpo_dll\vpo_dll.vcproj
SET DB2PlugVisExpLibUpgrade=%DB2PlugDir%\vpo_dll\vpo_dll.vcxproj
SET DB2PlugVisExp=%DB2PlugDir%\VisplaneExplorer\VisplaneExplorer.csproj
SET DB2PlugNodeViewer=%DB2PlugDir%\NodesViewer\NodesViewer.csproj
ECHO  -DONE!

ECHO.

ECHO  Setting up the (Builder 64) directory mutable variables...
SET DirDB64=%DirParent%\branches\Builder64
SET DB64CopyRange=%DirDB64%\Build
SET DB64PlugDir=%DirDB64%\Source\Plugins
SET DB64Help=%DirDB64%\Help
SET DB64Core=%DirDB64%\Source\Core\Builder.csproj
REM Plugins
::Default
::---------------------------
SET DB64PlugBuilderModes=%DB64PlugDir%\BuilderModes\BuilderModes.csproj
::---------------------------
SET DB64PlugCopyPaste=%DB64PlugDir%\CopyPasteSectorProps\CopyPasteSectorProperties.csproj
SET DB64PlugImageDraw=%DB64PlugDir%\ImageDrawingExample\ImageDrawingExample.csproj
SET DB64PlugStats=%DB64PlugDir%\Statistics\Statistics.csproj
ECHO  -DONE!

ECHO.

ECHO  Setting up the (GZDoomBuilder) directory mutable variables...
SET DirGZDB=.\GZDoomBuilder
SET GZDBCopyRange=%DirGZDB%\Build
SET GZDBPlugDir=%DirGZDB%\Source\Plugins
SET GZDBHelp=%DirGZDB%\Help
SET GZDBCore=%DirGZDB%\Source\Core\Builder.csproj
REM Plugins
::Default
::---------------------------
SET GZDBPlugBuilderModes=%GZDBPlugDir%\BuilderModes\BuilderModes.csproj
::---------------------------
SET GZDBPlugColorPicker=%GZDBPlugDir%\ColorPicker\ColorPicker.csproj
SET GZDBPlugCommentsPanel=%GZDBPlugDir%\CommentsPanel\CommentsPanel.csproj
SET GZDBPlugCopyPast=%GZDBPlugDir%\CopyPasteSectorProps\CopyPasteSectorProperties.csproj
SET GZDBPlugGZDoomVM=%GZDBPlugDir%\GZDoomEditing\GZDoomEditing.csproj
SET GZDBPlugImageDraw=%GZDBPlugDir%\ImageDrawingExample\ImageDrawingExample.csproj
SET GZDBPlugStats=%GZDBPlugDir%\Statistics\Statistics.csproj
SET GZDBPlugTagExplorer=%GZDBPlugDir%\TagExplorer\TagExplorer.csproj
SET GZDBPlugTagRange=%GZDBPlugDir%\TagRange\TagRange.csproj
SET GZDBPlugUMDF=%GZDBPlugDir%\UMDFControls\UDMFControls.csproj
SET GZDBPlugUSDF=%GZDBPlugDir%\USDF\USDF.csproj
SET GZDBPlugVisExpLib=%GZDBPlugDir%\vpo_dll\vpo_dll.vcproj
SET GZDBPlugVisExpLibUpgrade=%GZDBPlugDir%\vpo_dll\vpo_dll.vcxproj
SET GZDBPlugVisplane=%GZDBPlugDir%\VisplaneExplorer\VisplaneExplorer.csproj
SET GZDBPlugWadAuthVM=%GZDBPlugDir%\WadAuthorMode\WadAuthorMode.csproj
::Based on assumption this will be implemented in GZDoom Builder
SET GZDBPlugNodeViewer=%GZDBPlugDir%\NodesViewer\NodesViewer.csproj
SET GZDBPlugBuilderEffects=%GZDBPlugDir%\BuilderEffects\BuilderEffects.csproj
ECHO  -DONE!

ECHO.

ECHO  Setting up the (Visplane Explorer) directory mutable variables...
SET DirVisplane=%DirParent%\branches\VisplaneExplorer
SET VECopyRange=%DirVisplane%\Build
SET VEHelp=%DirVisplane%\Help
SET VEPlugDir=%DirVisplane%\Source\Plugins
SET VECore=%DirVisplane%\Source\Core\Builder.csproj
REM Plugins
::Default
::---------------------------
SET VEPlugBuilderModes=%VEPlugDir%\BuilderModes\BuilderModes.csproj
::---------------------------
SET VEPlugCommentsPanel=%VEPlugDir%\CommentsPanel\CommentsPanel.csproj
SET VEPlugCopyPaste=%VEPlugDir%\CopyPasteSectorProps\CopyPasteSectorProperties.csproj
SET VEPlugGZDoomVM=%VEPlugDir%\GZDoomEditing\GZDoomEditing.csproj
SET VEPlugImageDraw=%VEPlugDir%\ImageDrawingExample\ImageDrawingExample.csproj
SET VEPlugStats=%VEPlugDir%\Statistics\Statistics.csproj
SET VEPlugTagRange=%VEPlugDir%\TagRange\TagRange.csproj
SET VEPlugUSDF=%VEPlugDir%\USDF\USDF.csproj
SET VEPlugVisExpLib=%VEPlugDir%\vpo_dll\vpo_dll.vcproj
SET VEPlugVisExpLibUpgrade=%VEPlugDir%\vpo_dll\vpo_dll.vcxproj
SET VEPlugVisplane=%VEPlugDir%\VisplaneExplorer\VisplaneExplorer.csproj
SET VEPlugWadAuthVM=%VEPLugDir%\WadAuthorMode\WadAuthorMode.csproj
ECHO  -DONE!

ECHO.
REM Remember, we're connected to a tree here!
ECHO -DONE!

ECHO.

ECHO Setting up Compiler Tools directory mutable variables...
:: Here, we are looking for 'vsvars32' that is included.  Without this, nothing can be done.
SET PATHMSVS=%VS100COMNTOOLS%
:: Microsoft's 'Help' compiling tool.
SET PATHHelp=%ProgramFiles(x86)%\HTML Help Workshop
ECHO -DONE!

ECHO.

ECHO Setting up Final Destination directory variables...
:: When we compile the build, put it here!
SET FinalDestDir=.\Compiled Projects\
ECHO -DONE!
ECHO.
TITLE %ProgramName% ^(%ProgramVersion%^)
ECHO Finished!
GOTO TermsOfUse


:TermsOfUse
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Terms of Use
ECHO. && ECHO. && ECHO.

:: As the other programs, I DON'T WANT THIS HERE!!!!!!!!!!!
ECHO This program comes with absolutely no warranties of both working condition nor damages or loss of data.  When using this program, you understand that the perquisite softwares utilize their own licenses and terms and that this program merely only sends processing commands to the other software supported (Microsoft Visual Studio, Microsoft HTML Workshop and any other software that the source code requires and calls).  This program also does minor alterations to the Doom Builder WC SVN directory, and can alter data either by copy operation and deletion.  When utilizing this program, you (the end-user) understand that you are using this program AT YOUR OWN RISK!
ECHO.
ECHO Do you agree to the terms?
ECHO.
ECHO %ChoiceYN%
:: Fetch STDIN
SET /P NavVar=^>^> 

:: Process the STDIN
IF /I "%NavVar%" EQU "Y" (GOTO Main)
IF /I "%NavVar%" EQU "Yes" (GOTO Main)
IF /I "%NavVar%" EQU "N" (GOTO TermsOfUseDeclined)
IF /I "%NavVar%" EQU "No" (GOTO TermsOfUseDeclined) ELSE (SET STDINErr=TermsOfUse && GOTO BadInput)


:TermsOfUseDeclined
ECHO.
ECHO Program is now terminating...
SET cacheNavVar=ToUDeclined
GOTO Kill


:Main
SET NavVar=0
SET cacheNavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Main Menu
ECHO. && ECHO. && ECHO.

ECHO Select the following options:
ECHO %Separator%
ECHO [1] Compile Project
ECHO [2] Settings
ECHO [3] QuickFinder {Debugger}
ECHO [4] Execute Sub-Scripts
ECHO [5] ReadMe
ECHO [6] View Changelog
ECHO [7] Exit
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%7
:: Fetch STDIN
SET /P NavVar=^>^> 

:: Read the STDIN and process it
IF "%NavVar%" == "1" (GOTO ProjectBuilder)
IF "%NavVar%" == "2" (GOTO Settings)
IF "%NavVar%" == "3" (GOTO QuickFinder)
IF "%NavVar%" == "4" (GOTO LoadExtScripts)
IF "%NavVar%" == "5" (GOTO ReadMe)
IF "%NavVar%" == "6" (GOTO ChangelogViewer)
IF "%NavVar%" == "7" (GOTO Kill)
REM Development purposes (Restart the program)
IF "%NavVar%" == "FirstRun" (GOTO FirstRun) ELSE (SET STDINErr=Main && GOTO BadInput)

:ChangelogViewer
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Changelog Viewer
ECHO. && ECHO. && ECHO.

IF NOT EXIST .\Documents\Changelog.txt (
ECHO Changelog does not exist!
PAUSE
GOTO Main)

ECHO Changelog Viewer [Current Version: %ProgramVersion%]
ECHO --------------------------------------------------------
MORE .\Documents\Changelog.txt || ECHO General Error Occured && PAUSE && GOTO Main
ECHO --------------------------------------------------------
ECHO.
PAUSE
GOTO Main

:LoadExtScripts
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Load External Scripts
ECHO. && ECHO. && ECHO.

IF NOT EXIST %DirSubScripts% (
ECHO Nothing can be loaded!
PAUSE
GOTO Main)
ECHO Scripts available to execute:
ECHO --------------------------------------------------------
ECHO %DirSubScripts%
DIR %DirSubScripts% | Find /I ".bat"
ECHO --------------------------------------------------------
ECHO.
ECHO Select the following scripts to execute:
ECHO NOTE^: Besure to include the filename and the extension.
ECHO    ^(i.e. filename.bat^)
ECHO.
ECHO ^(?^) To Cancel, type: Cancel ^(?^)
ECHO.
SET /P cacheNavVar=^>^> 
ECHO.

IF /I "%cacheNavVar%" EQU "Cancel" (GOTO Main)
IF EXIST %DirSubScripts%\%cacheNavVar% (CALL %DirSubScripts%\%cacheNavVar%
ECHO.
ECHO Script file has finished executing!
:: If incase the external script edited the title, update it.
TITLE %ProgramName% ^(%ProgramVersion%^)
) ELSE (
ECHO Nothing was loaded!)
ECHO.
PAUSE
GOTO Main


:ProjectBuilder
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Project Builder Menu
ECHO. && ECHO. && ECHO.

ECHO Select the follow options:
ECHO %Separator%
ECHO [1] Doom Builder 2
ECHO [2] Doom Builder 64
ECHO [3] GZDoom Builder
REM This project is useless to compile without the visplane plugins
:: ECHO [4] Visplane Explorer
ECHO [4] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%4
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (SET Project=DB2 && GOTO PluginBuilder)
IF "%NavVar%" EQU "2" (SET Project=DB64 && GOTO PluginBuilder)
IF "%NavVar%" EQU "3" (SET Project=GZDB && GOTO PluginBuilder)
:: IF "%NavVar%" EQU "4" (SET Project=Visplane && GOTO PluginBuilder)
IF "%NavVar%" EQU "4" (GOTO Main) ELSE (SET STDINErr=ProjectBuilder && GOTO BadInput)


:PluginBuilder
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Project Builder Menu
ECHO. && ECHO. && ECHO.

ECHO Select the follow options:
ECHO %Separator%
ECHO [1] Compile Only Default Plugins
ECHO [2] Compile All Plugins
ECHO [3] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%3
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (SET Plugins=0 && GOTO ConfirmBuilder)
IF "%NavVar%" EQU "2" (SET Plugins=1 && GOTO ConfirmBuilder)
IF "%NavVar%" EQU "3" (GOTO ProjectBuilder) ELSE (SET STDINErr=PluginBuilder && GOTO BadInput)


:ConfirmBuilder
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Confirm
ECHO. && ECHO. && ECHO.

IF %Project% == DB2 (SET ProcessValue=Doom Builder 2)
IF %Project% == DB64 (SET ProcessValue=Doom Builder 64)
IF %Project% == GZDB (SET ProcessValue=GZDoom Builder)
IF %Project% == Visplane (SET ProcessValue=Visplane Explorer)
ECHO Project to Build: %ProcessValue%

IF %Plugins% == 0 (SET ProcessValue=Default Plugins)
IF %Plugins% == 1 (SET PRocessValue=All Plugins)
ECHO Plugins to Build: %ProcessValue%
ECHO.
ECHO.
ECHO Ready to compile?
ECHO %Separator%
ECHO [1] LETS GO!
ECHO [2] Go Back
ECHO [3] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%3
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (GOTO CompileProject)
IF "%NavVar%" EQU "2" (GOTO ProjectBuilder)
IF "%NavVar%" EQU "3" (GOTO Main) ELSE (SET STDINErr=ConfirmBuilder && GOTO BadInput)


:CompileProject
REM Do not compile the plugins here, but only the core project.
REM This program inherits HotCompiler's error detection system; this is to assure that everything is working as it should.
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Compiling Project...
ECHO. && ECHO. && ECHO.

(ECHO %DATE% - %TIME%
ECHO Compiling main engine
ECHO.) >> %STDOUT%

ECHO Calling Microsoft Visual Studio 'vsvars32.bat'...
CALL "%PATHMSVS%vsvars32.bat"
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileProject && SET ExeExtCMDFault=CALL && GOTO Error)

ECHO.

IF %Project% == DB2 (
ECHO ^>^>^> Compiling Doom Builder 2... >> %STDOUT%
ECHO Compiling Doom Builder 2...
MSBUILD "%DB2Core%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileProject && ExeExtCMDFault=MSBUILD && GOTO Error)
	ECHO -Finished!
	GOTO CompilePluginsDriver
)

IF %Project% == DB64 (
ECHO ^>^>^> Compiling Doom Builder 64... >> %STDOUT%
ECHO Compiling Doom Builder 64...
MSBUILD "%DB64Core%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileProject && ExeExtCMDFault=MSBUILD && GOTO Error)
	ECHO -Finished!
	GOTO CompilePluginsDriver
)

IF %Project% == GZDB (
ECHO ^>^>^> Compiling GZDoom Builder... >> %STDOUT%
ECHO Compiling GZDoom Builder...
MSBUILD "%GZDBCore%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileProject && ExeExtCMDFault=MSBUILD && GOTO Error)
	ECHO -Finished!
	GOTO CompilePluginsDriver
)

IF %Project% == Visplane (
ECHO ^>^>^> Compiling Visplane Explorer... >> %STDOUT%
ECHO Compiling Visplane Explorer...
MSBUILD "%VECore%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileProject && ExeExtCMDFault=MSBUILD && GOTO Error)
	ECHO -Finished!
	GOTO CompilePluginsDriver
)


:CompilePluginsDriver
REM Yes, this would be better to have a nice nested conditional statement for this; however, to keep from reaching into lunacy - just split into several methods.  If someone is welling to have patience within the Batch environment, feel free to submit the code!

IF %Project% EQU DB2 (GOTO CompilePluginsDB2)
IF %Project% EQU DB64 (GOTO CompilePluginsDB64)
IF %Project% EQU GZDB (GOTO CompilePluginsGZDB)
IF %Project% EQU Visplane (GOTO CompilePluginsVisplane)


:CompilePluginsDB2
(ECHO. && ECHO ^>^>^> Compiling Plugins for Doom Builder 2...) >> %STDOUT%

:: Do not check the variable yet
SET ProcessValue=Compiling Doom Builder Visual Mode...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugBuilderModes%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!

::If we are doing defaults only, we're done here
::----------------------------------------------
IF %Plugins% EQU 0 (GOTO CompileHelp)


SET ProcessValue=Compiling Comments Panel...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugComPan%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Copy and Paste Sector Properties...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugCopyPaste%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Image Draw...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugImageDraw%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Statistics...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugStats%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Sector and Thing Tag Range...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugTagRange%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


::Note - I forgot what 'USDF' was...
SET ProcessValue=Compiling USDF...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugUSDF%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling GZDoom Visual Mode...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugGZDoomVM%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling WAD Author Visual Mode...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugWadAuthVM%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Upgrading the Visplane Explorer Library Project...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
VCUPGRADE /OverWrite "%DB2PlugVisExpLib%" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=VCUPGRADE && GOTO Error
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer Library...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugVisExpLibUpgrade%" %MSVSArgVPO% /property:OutDir=%DB2PlugDir%\VisplaneExplorer\Resources\ >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
		IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugVisExp%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!

SET ProcessValue=Compiling Node Viewer...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB2PlugNodeViewer%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!
GOTO CompileHelp


:CompilePluginsDB64
(ECHO. && ECHO ^>^>^> Compiling Plugins for Doom Builder 64...) >> %STDOUT%
:: Defaults
SET ProcessValue=Compiling Builder Modes...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB64PlugBuilderModes%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!

::If we are doing defaults only, we're done here
:: --------------------------------
IF %Plugins% EQU 0 (GOTO CompileHelp)

SET ProcessValue=Compiling Copy and Paste Secotr Properties...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB64PlugCopyPaste%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Image Draw...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB64PlugImageDraw%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Statistics...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%DB64PlugStats%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!
GOTO CompileHelp



:CompilePluginsGZDB
(ECHO. && ECHO ^>^>^> Compiling Plugins for GZDoom Builder...) >> %STDOUT%
:: Defaults
SET ProcessValue=Compiling Builder Modes...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugBuilderModes%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Color Picker...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugColorPicker%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Comments Panel...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugCommentsPanel%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Copy and Paste Sector Properties...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugCopyPast%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Node Viewer...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugNodeViewer%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Statistics...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugStats%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Tag Range...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugTagRange%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


::SET ProcessValue=Compiling UMDF Controls...
::(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
::ECHO %ProcessValue%
::MSBUILD "%GZDBPlugUMDF%" %MSVSArg% >> %STDOUT%
::	SET FaultErrorID=%ERRORLEVEL%
::	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
::ECHO -Finished!


SET ProcessValue=Compiling Tag Explorer...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugTagExplorer%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Upgrading the Visplane Explorer Library Project...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
VCUPGRADE /OverWrite "%GZDBPlugVisExpLib%" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=VCUPGRADE && GOTO Error
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer Library...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
:: As the default 'Output' path uses the main solution as base, MSBuild is only going to assume that this is the based solution.  As a result, the output path is not going to work right.  To resolve this issue, we are going to override one property.
REM NOTE: You might notice the 'OutDir' does not have quotes.  As it 'SHOULD' have quotes, but MSBuild will take the quotes as illegal characters.  Once the directory has spaces, this breaks.
MSBUILD "%GZDBPlugVisExpLibUpgrade%" %MSVSArgVPO% /property:OutDir=%GZDBPlugDir%\VisplaneExplorer\Resources\ >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugVisplane%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Builder Effects...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugBuilderEffects%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


::If we are doing defaults only, we're done here
:: --------------------------------
IF %Plugins% EQU 0 (GOTO CompileHelp)


REM This is no longer necessary since revision 1649
::SET ProcessValue=Compiling GZDoom Visual Mode...
::(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
::ECHO %ProcessValue%
::MSBUILD "%GZDBPlugGZDoomVM%" %MSVSArg% >> %STDOUT%
::	SET FaultErrorID=%ERRORLEVEL%
::	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
::ECHO -Finished!


REM ImageDrawingExample is just an example plugin, which has no practical use
SET ProcessValue=Compiling Image Draw...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugImageDraw%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


REM USDF is not finished and is useless in its current state.
SET ProcessValue=Compiling USDF...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugUSDF%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


REM WadAutherVisualMode is not finished and is useless in its current state.
SET ProcessValue=Compiling Wad Author Visual Mode...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%GZDBPlugWadAuthVM%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!
GOTO CompileHelp


:CompilePluginsVisplane
(ECHO. && ECHO ^>^>^> Compiling Plugins for Visplane Explorer...) >> %STDOUT%
:: Defaults
SET ProcessValue=Compiling Builder Modes...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugBuilderModes%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!

::If we are doing defaults only, we're done here
::----------------------------------
IF %Plugins% EQU 0 (GOTO CompileHelp)

SET ProcessValue=Compiling Comments Panel...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugCommentsPanel%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Copy and Paste Secotr Properties...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugCopyPaste%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling GZDoom Visual Mode...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugGZDoomVM%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Image Draw...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugImageDraw%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Statistics...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugStats%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Tag Range...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugTagRange%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling USDF...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugUSDF%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Wad Author Visual Mode...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugWadAuthVM%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!

::Due to inconsistency issues, jump away from here
:: --------------------------
GOTO CompileHelp


SET ProcessValue=Upgrading the Visplane Explorer Library Project...
(ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
VCUPGRADE /OverWrite "%VEPlugVisExpLib%" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=VCUPGRADE && GOTO Error
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer Library...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugVisExpLibUpgrade%" %MSVSArgVPO% /property:OutDir=%VEPlugDir%\VisplaneExplorer\Resources\ >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!


SET ProcessValue=Compiling Visplane Explorer...
(ECHO. && ECHO ^>^>^> %ProcessValue%) >> %STDOUT%
ECHO %ProcessValue%
MSBUILD "%VEPlugVisplane%" %MSVSArg% >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompilePlugins && SET ExeExtCMDFault=MSBUILD && GOTO Error)
ECHO -Finished!
GOTO CompileHelp



:CompileHelp
(ECHO. && ECHO ^>^>^> Compiling Help Data... && ECHO.) >> %STDOUT%
ECHO Compiling Help Data...
IF %Project% == DB2 (
start /B /WAIT "Compile Help Documents..." "%PATHHelp%\hhc" %DB2Help%\Refmanual.hhp >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileHelp && SET ExeExtCMDFault=HHC && GOTO Error)
	ECHO -Finished!
	GOTO CompileMirroringDriver
)

IF %Project% == DB64 (
start /B /WAIT "Compile Help Documents..." "%PATHHelp%\hhc" %DB64Help%\Refmanual.hhp >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileHelp && SET ExeExtCMDFault=HHC && GOTO Error)
	ECHO -Finished!
	GOTO CompileMirroringDriver
)

IF %Project% == GZDB (
start /B /WAIT "Compile Help Documents..." "%PATHHelp%\hhc" %GZDBHelp%\Refmanual.hhp >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileHelp && SET ExeExtCMDFault=HHC && GOTO Error)
	ECHO -Finished!
	GOTO CompileMirroringDriver
)

IF %Project% == Visplane (
start /B /WAIT "Compile Help Documents..." "%PATHHelp%\hhc" %VEHelp%\Refmanual.hhp >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileHelp && SET ExeExtCMDFault=HHC && GOTO Error)
	ECHO -Finished!
	GOTO CompileMirroringDriver
)


REM Again, lunacy with nested conditional statements
:CompileMirroringDriver
ECHO.
ECHO Saving Project...
ECHO.

IF NOT EXIST "%FinalDestDir%" (
ECHO Creating project directory...
MKDIR "%FinalDestDir%"
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=CompileMirroring && SET ExeExtCMDFault=MKDIR && GOTO Error)
ECHO -Finished!
)

ECHO Duplicating...
IF %Project% EQU DB2 (GOTO CompileMirrorDB2)
IF %Project% EQU DB64 (GOTO CompileMirrorDB64)
IF %Project% EQU GZDB (GOTO CompileMirrorGZDB)
IF %Project% EQU Visplane (GOTO CompileMirrorVE)


:CompileMirrorFault
REM Because the Exit Codes in XCopy and ROBOCOPY are too unique, they must be dealt with differently.
REM For example: '0' in XCopy=Passed with no errors, in ROBOCOPY=Nothing was done
SET FaultMethodID=CompileMirroring
SET ExeExtCMDFault=%CopyMethod%
GOTO Error


:CompileMirrorDB2
REM Whatever is in 'Build', move it where the user can easily fetch it
IF EXIST "%FinalDestDir%Doom Builder 2" (SET DestroyBuild=Doom Builder 2&& SET ResumePointer=CompileMirrorDB2&& GOTO DestroyBuild)
%CopyMethod% %CopyArg% %DB2CopyRange% "%FinalDestDir%Doom Builder 2" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %CopyMethod% EQU XCopy (IF %FaultErrorID% NEQ 0 GOTO CompileMirrorFault)
	IF %CopyMethod% EQU ROBOCOPY (IF %FaultErrorID% NEQ 1 GOTO CompileMirrorFault)
ECHO -Finished!
ECHO.
GOTO CompileSuccess


:CompileMirrorDB64
REM Whatever is in 'Build', move it where the user can easily fetch it
IF EXIST "%FinalDestDir%Doom Builder 64" (SET DestroyBuild=Doom Builder 64&& SET ResumePointer=CompileMirrorDB64&& GOTO DestroyBuild)
%CopyMethod% %CopyArg% %DB64CopyRange% "%FinalDestDir%Doom Builder 64" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %CopyMethod% EQU XCopy (IF %FaultErrorID% NEQ 0 GOTO CompileMirrorFault)
	IF %CopyMethod% EQU ROBOCOPY (IF %FaultErrorID% NEQ 1 GOTO CompileMirrorFault)
ECHO -Finished!
ECHO.
GOTO CompileSuccess


:CompileMirrorGZDB
REM Whatever is in 'Build', move it where the user can easily fetch it
IF EXIST "%FinalDestDir%GZDoom Builder" (SET DestroyBuild=GZDoom Builder&& SET ResumePointer=CompileMirrorGZDB&& GOTO DestroyBuild)
%CopyMethod% %CopyArg% %GZDBCopyRange% "%FinalDestDir%GZDoom Builder" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %CopyMethod% EQU XCopy (IF %FaultErrorID% NEQ 0 GOTO CompileMirrorFault)
	IF %CopyMethod% EQU ROBOCOPY (IF %FaultErrorID% NEQ 1 GOTO CompileMirrorFault)
ECHO -Finished!
ECHO.
GOTO CompileSuccess


:CompileMirrorVE
REM Whatever is in 'Build', move it where the user can easily fetch it
IF EXIST "%FinalDestDir%Visplane Explorer" (SET DestroyBuild=Visplane Explorer&& SET ResumePointer=CompileMirrorVE&& GOTO DestroyBuild)
%CopyMethod% %CopyArg% %VECopyRange% "%FinalDestDir%Visplane Explorer" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %CopyMethod% EQU XCopy (IF %FaultErrorID% NEQ 0 GOTO CompileMirrorFault)
	IF %CopyMethod% EQU ROBOCOPY (IF %FaultErrorID% NEQ 1 GOTO CompileMirrorFault)
ECHO -Finished!
ECHO.
GOTO CompileSuccess


:CompileSuccess
ECHO ^<^<^< Operation Finished! >> %STDOUT%
ECHO Compile was successful!
IF %UsePCSpeaker% EQU 1 (ECHO %PCSpeaker%)
PAUSE
GOTO Main


REM SoftScreen Error (poor attempt to daisy chain methods)
:DestroyBuild
SET NavVar=0
ECHO. && ECHO.
ECHO ^<?^>   FOUND EXISTING FOLDER!   ^<?^>
	ECHO.
	ECHO Found an already existing folder named %DestroyBuild%!
	ECHO This program is going to import of the compiled contents and all of the resources and databases into the same directory, thus any customized files will be lost forever!
	ECHO Please run a backup now before continuing!
	ECHO.
	ECHO Continue?
	ECHO %ChoiceYN%
	ECHO.
:: Fetch STDIN
SET /P NavVar=^>^> 

IF /I "%NavVar%" == "Y" (GOTO DestroyBuildKill)
IF /I "%NavVar%" == "Yes" (GOTO DestroyBuildKill)
:: Abort!
IF /I "%NavVar%" == "N" (GOTO CompileSuccess)
IF /I "%NavVar%" == "No" (GOTO CompileSuccess) ELSE (SET STDINErr=DestroyBuild && GOTO BadInput)


:DestroyBuildKill
ECHO Thrashing %DestroyBuild% directory...
ECHO.
DEL /F /S /Q "%FinalDestDir%%DestroyBuild%"\* >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=DestroyBuildKill && SET ExeExtCMDFault=DEL && GOTO Error)
RD /Q /S "%FinalDestDir%%DestroyBuild%" >> %STDOUT%
	SET FaultErrorID=%ERRORLEVEL%
	IF %FaultErrorID% NEQ 0 (SET FaultMethodID=DestroyBuildKill && SET ExeExtCMDFault=RD && GOTO Error)
GOTO %ResumePointer%


:Settings
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Settings Menu
ECHO. && ECHO. && ECHO.

ECHO Select the following options:
ECHO %Separator%
ECHO [1] Copy Method
ECHO [2] Directory Setup
ECHO [3] Sound
ECHO [4] Save Settings
ECHO [5] Load Settings
ECHO [6] Logging
ECHO [7] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%7
:: Fetch STDIN
SET /P NavVar=^>^> 

:: Read the STDIN and process it
IF "%NavVar%" == "1" (GOTO CopyMethod)
IF "%NavVar%" == "2" (GOTO DirectorySetup)
IF "%NavVar%" == "3" (GOTO Sound)
IF "%NavVar%" == "4" (GOTO SaveSettings)
IF "%NavVar%" == "5" (GOTO LoadSettings)
IF "%NavVar%" == "6" (GOTO LogFile)
IF "%NavVar%" == "7" (GOTO Main) ELSE (SET STDINErr=Settings && GOTO BadInput)


:LogFile
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Copy Method
ECHO. && ECHO. && ECHO.

IF "%STDOUT%" EQU "NUL" (SET ProcessValue1=False) ELSE (SET ProcessValue1=True)
ECHO Currently Logging is: %ProcessValue1%
ECHO.
ECHO Select the Following Options:
ECHO %Separator%
ECHO [1] Disable Logging (Default)
ECHO [2] Enable Logging
ECHO [3] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%3
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (SET STDOUT=NUL && SET ProcessValue=Disabled Logging && GOTO SettingsSet)
IF "%NavVar%" EQU "2" (SET STDOUT=BootlessStar_CompileLog.txt && SET ProcessValue=Enabled Logging && GOTO SettingsSet)
IF "%NavVar%" EQU "3" (GOTO Settings) ELSE (SET STDINErr=LogFile && GOTO BadInput)


:CopyMethod
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Copy Method
ECHO. && ECHO. && ECHO.

ECHO Current Copy Program Value: %CopyMethod%
ECHO.
ECHO Select the Following Copy Method:
ECHO %Separator%
ECHO [1] XCOPY (Default)
ECHO [2] ROBOCOPY
ECHO [3] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%3
:: Fetch STDIN
SET /P NavVar=^>^> 

:: Read the STDIN and process it
IF "%NavVar%" EQU "1" (SET CopyMethod=XCOPY
	SET ProcessValue=XCOPY
	SET CopyArg=%XCopyArg%
	GOTO SettingsSet)
IF "%NavVar%" EQU "2" (SET CopyMethod=ROBOCOPY
	SET ProcessValue=ROBOCOPY
	SET CopyArg=%RoboCopyArg%
	GOTO SettingsSet)
IF "%NavVar%" EQU "3" (GOTO Settings) ELSE (SET STDINErr=CopyMethod && GOTO BadInput)


:Sound
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Sound Options
ECHO. && ECHO. && ECHO.

IF %UsePCSpeaker% EQU 0 (SET ProcessValue=Disabled)
IF %UsePCSpeaker% EQU 1 (SET ProcessValue=Enabled [Success and Error Alerts])
IF %UsePCSpeaker% EQU 2 (SET ProcessValue=Enabled [Error Alerts Only!])
ECHO The Current Sound Value is: %ProcessValue%
ECHO.
ECHO Select the Following Sound Properties:
ECHO %Separator%
ECHO [1] Disable all sounds
ECHO [2] Alert me when a build is completed and when errors are present
ECHO [3] Only alert me of errors
ECHO [4] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%4
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (SET UsePCSpeaker=0
	SET ProcessValue=Disable all Sounds
	GOTO SettingsSet)
IF "%NavVar%" EQU "2" (SET UsePCSpeaker=1
	SET ProcessValue=Enabled [Success and Error Alerts]
	GOTO SettingsSet)
IF "%NavVar%" EQU "3" (SET UsePCSpeaker=2
	SET ProcessValue=Enabled [Error Alerts Only!]
	GOTO SettingsSet)
IF "%NavVar%" EQU "4" (GOTO Settings) ELSE (SET STDINErr=Sound && GOTO BadInput)


:DirectorySetup
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Directory Setup
ECHO. && ECHO. && ECHO.

:: Display if the program was able to find what it needs; allow the user to know what to alter.
ECHO Detection: Microsoft Visual Studio [vsvars32]:
IF EXIST "%PATHMSVS%vsvars32.bat" (ECHO -Found!) ELSE (ECHO -Not Found!)
ECHO Detection: Microsoft HTML Workshop:
IF EXIST "%PATHHelp%\hhw.exe" (ECHO -Found!) ELSE (ECHO -Not Found!)
ECHO.
ECHO Select the following Sub-Menus:
ECHO %Separator%
ECHO [1] Microsoft Visual Studio ^{File Specific: vsvars32^}
ECHO [2] Microsoft's HTML Workshop
ECHO [3] Cancel
ECHO.
ECHO %ChoiceSel%
ECHO %ChoiceNum%3
:: Fetch STDIN
SET /P NavVar=^>^> 

IF "%NavVar%" EQU "1" (SET cacheNavVar=PATHMSVS && GOTO DirectorySetupSplitter)
IF "%NavVar%" EQU "2" (SET cacheNavVar=PATHHelp && GOTO DirectorySetupSplitter)
IF "%NavVar%" EQU "3" (GOTO Settings) ELSE (SET STDINErr=DirectorySetup && GOTO BadInput)


:DirectorySetupSplitter
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Directory Setup
ECHO. && ECHO. && ECHO.

ECHO Setup Directory
ECHO %Separator%
IF %cacheNavVar% == PATHMSVS (GOTO DirectorySetupMSVS)
IF %cacheNavVar% == PATHHelp (GOTO DirectorySetupMSHTML)


:DirectorySetupMSVS
ECHO Setup directory for Microsoft Visual Studio
ECHO.
ECHO Detection: Microsoft Visual Studio [vsvars32]:
IF EXIST "%PATHMSVS%vsvars32.bat" (ECHO -Found!) ELSE (ECHO -Not Found!)
ECHO.
ECHO Current Directory Set:
ECHO %PATHMSVS%
ECHO.
ECHO Enter New Path:
ECHO NOTE: Don't add quotes to the absolute directory path!
ECHO ^(?^) To Cancel, type: Cancel ^(?^)
SET /P NavVar=^>^> 

IF /I "%NavVar%" EQU "Cancel" (GOTO DirectorySetup)
IF EXIST "%NavVar%\vsvars32.bat" (
SET PATHMSVS=%NavVar%
ECHO Found!
) ELSE (
ECHO Not Found!
PAUSE
GOTO DirectorySetupSplitter
)
PAUSE
GOTO DirectorySetup


:DirectorySetupMSHTML
ECHO Setup directory for Microsoft HTML Workshop
ECHO.
ECHO Detection: Microsoft HTML Workshop Setup:
IF EXIST "%PATHHelp%" (ECHO -Found!) ELSE (ECHO -Not Found!)
ECHO.
ECHO Current Directory Set:
ECHO %PATHHelp%
ECHO.
ECHO Enter New Path:
ECHO NOTE: Don't add quotes to the absolute directory path!
ECHO ^(?^) To Cancel, type: Cancel ^(?^)
SET /P NavVar=^>^> 

IF /I "%NavVar%" EQU "Cancel" (GOTO DirectorySetup)
IF EXIST "%NavVar%\hhw.exe" (
SET PATHHelp=%NavVar%
ECHO Found!
) ELSE (
ECHO Not Found!
PAUSE
GOTO DirectorySetupSplitter
)
PAUSE
GOTO DirectorySetup


:SaveSettings
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Save Presets
ECHO. && ECHO. && ECHO.

ECHO Enter a filename:
ECHO ^(?^) To Cancel, type: Cancel ^(?^)
SET /P cacheNavVar=^>^> 
ECHO.
IF /I "%cacheNavVar%" EQU "Cancel" (GOTO Settings)
SET ProcessValue=%DirSavePresets%\%cacheNavVar%

ECHO Saving to file %ProcessValue%...
IF NOT EXIST "%DirSavePresets%" (MKDIR "%DirSavePresets%")
ECHO.

REM Chunk to store
ECHO ECHO Loading %cacheNavVar%...> "%ProcessValue%.bat"
ECHO ECHO Preset was Generated with %ProgramName% %ProgramVersion%>> "%ProcessValue%.bat"
ECHO SET UsePCSpeaker=%UsePCSpeaker% >> "%ProcessValue%.bat"
ECHO SET CopyMethod=%CopyMethod%>> "%ProcessValue%.bat"
ECHO SET PATHMSVS=%PATHMSVS%>> "%ProcessValue%.bat"
ECHO SET PATHHelp=%PATHHelp%>> "%ProcessValue%.bat"
ECHO SET CopyArg=%CopyArg%>> "%ProcessValue%.bat"
ECHO SET STDOUT=%STDOUT%>> "%ProcessValue%.bat"
ECHO ECHO Done!>> "%ProcessValue%.bat"
ECHO GOTO :eof>> "%ProcessValue%.bat"
::) > "%ProcessValue%.bat"
ECHO.
IF EXIST "%ProcessValue%.bat" (
ECHO Finished!
) ELSE (
ECHO Could not save data!)
PAUSE
GOTO Settings


:LoadSettings
SET NavVar=0
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Load Settings
ECHO. && ECHO. && ECHO.

IF NOT EXIST %DirSavePresets% (
ECHO Nothing was previously saved!
PAUSE
GOTO Settings)
ECHO Load settings available:
ECHO --------------------------------------------------------
ECHO %DirSavePresets%
DIR %DirSavePresets% | Find /I ".bat"
ECHO --------------------------------------------------------
ECHO.
ECHO Select the following presets to load:
ECHO NOTE^: Besure to include the filename and the extension.
ECHO    ^(i.e. filename.bat^)
ECHO.
ECHO ^(?^) To Cancel, type: Cancel ^(?^)
ECHO.
SET /P cacheNavVar=^>^> 
ECHO.

IF /I "%cacheNavVar%" EQU "Cancel" (GOTO Settings)
IF EXIST %DirSavePresets%\%cacheNavVar% (CALL %DirSavePresets%\%cacheNavVar%) ELSE (ECHO Nothing was loaded!)
ECHO.
ECHO Finished!
PAUSE
GOTO Settings


:SettingsSet
ECHO. && ECHO.
ECHO Value was changed to: %ProcessValue%
ECHO.
PAUSE
GOTO Settings


:QuickFinder
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO QuickFinder
ECHO. && ECHO. && ECHO.

ECHO Internal Static Variable(s)
ECHO %Separator%
ECHO   Program Name: ----------------------- = %ProgramName%
ECHO   Program Version: -------------------- = %ProgramVersion%
ECHO.

ECHO.
ECHO Detection Variable(s)
ECHO %Separator%
IF EXIST "%PATHMSVS%vsvars32.bat" (SET ProcessValue=Found!) ELSE (SET ProcessValue=Not Found!)
ECHO  Microsoft Visual Studio [vsvars32.bat] = %ProcessValue%
ECHO    Directory Pointer: ----------------- = %PATHMSVS%
IF EXIST "%PATHHelp%\hhw.exe" (SET ProcessValue=Found!) ELSE (SET ProcessValue=Not Found!)
ECHO  Microsoft HTML Workshop: ------------- = %ProcessValue%
ECHO    Directory Pointer: ----------------- = %PATHHelp%
ECHO.

ECHO.
ECHO Program Setting Variable(s)
ECHO %Separator%
IF %UsePCSpeaker% GTR 0 (SET ProcessValue=Enabled) ELSE (SET ProcessValue=Disabled)
ECHO  System Sounds: ----------------------- = %ProcessValue%
IF %UsePCSpeaker% EQU 1 (SET ProcessValue=Compile Success AND Compile Error)
IF %UsePCSpeaker% EQU 2 (SET ProcessValue=Compile Error only)
IF %UsePCSpeaker% EQU 0 (SET ProcessValue=Disabled)
ECHO    Alarm the user when: --------------- = %ProcessValue%
ECHO  Copy Method: ------------------------- = %CopyMethod%
ECHO    Copy Arguments: -------------------- = %CopyArg%
IF "%STDOUT%" EQU "NUL" (SET ProcessValue=Disabled) ELSE (SET ProcessValue=Enabled)
ECHO  Logging: ----------------------------- = %ProcessValue%
ECHO.

ECHO.
ECHO Directory Variable(s)
ECHO %Separator%
ECHO  User Saved Presets: ------------------ = %DirSavePresets%
ECHO  Compiled Builds: --------------------- = %FinalDestDir%
ECHO  Parent Directory to Working Copy: ---- = %DirParent%
IF EXIST "%DirParent%" (SET ProcessValue=Found!) ELSE (SET ProcessValue=Not Found!)
ECHO    Parent Directory Found: ------------ = %ProcessValue%
ECHO.
ECHO Press any key to return to the Main Menu . . .
PAUSE > NUL
GOTO Main


:ReadMe
REM Hey hotshot!  Don't copy or open the links on to an Internet Browser from the text buffer!  There is intentional extra characters within the links so that it would display properly within the terminal!
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Read Me!
ECHO. && ECHO. && ECHO.
ECHO Please make sure that of the following:
ECHO   1) Microsoft Visual Studio Express (2010) is installed and ready!
ECHO       URL: http://www.microsoft.com/express
ECHO   2) SlimDX Version 2011 September.
ECHO       URL: http://slimdx.org/download_sep11.php
ECHO   3) [Optional] Be sure that 'Microsoft HTML Help compiler' is installed
ECHO       URL: http://www.microsoft.com/download/en/details.aspx?displaylang=en^&id^=21138
ECHO.
ECHO Press any key to return to the Main Menu . . .
PAUSE > NUL
GOTO Main


:Error
ECHO.
ECHO [ERRORKILLTASK] Thinking...
IF %ExeExtCMDFault% == MKDIR (GOTO ERR_LIB_MAKEDIR)
IF %ExeExtCMDFault% == XCOPY (GOTO ERR_LIB_XCOPY)
IF %ExeExtCMDFault% == RD (GOTO ERR_LIB_REMOVEDIR)
IF %ExeExtCMDFault% == DEL (GOTO ERR_LIB_DELETE)
IF %ExeExtCMDFault% == ROBOCOPY (GOTO ERR_LIB_ROBOCOPY)
IF %ExeExtCMDFault% == MSBUILD (GOTO ERR_LIB_MSBUILD)
IF %ExeExtCMDFault% == CALL (GOTO ERR_LIB_CALL)



:ERR_LIB_CALL
IF %FaultErrorID% == 1 (SET ProcessValue=Could not successfully call another script file! && GOTO ErrorPrint)
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_MSBUILD
IF %FaultErrorID% == 1 (SET ProcessValue=Could not successfully compile the requested project! && GOTO ErrorPrint)
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_MAKEDIR
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_XCOPY
IF %FaultErrorID% == 0 (SET ProcessValue=Could not detect the generated cache data! && GOTO ErrorPrint)
IF %FaultErrorID% == 1 (SET ProcessValue=Missing files that were supposed to be duplicated! && GOTO ErrorPrint)
IF %FaultErrorID% == 2 (SET ProcessValue=User aborted operation while building cache data! && GOTO ErrorPrint)
IF %FaultErrorID% == 4 (SET ProcessValue=A very general error occurred!  Yes, I know this doesn't help much to know what could have caused this error.... && GOTO ErrorPrint)
IF %FaultErrorID% == 5 (SET ProcessValue=A Input\Output failure occurred; be sure that this program has write permissions. && GOTO ErrorPrint)
IF %FaultErrorID% == 255 (SET ProcessValue=A Critical fault occurred! && GOTO ErrorPrint)
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_REMOVEDIR
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_DELETE
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:ERR_LIB_ROBOCOPY
IF %FaultErrorID% == 0 (SET ProcessValue=Nothing was copied!  Most likely there was no match or the directory was already empty. && GOTO ErrorPrint)
IF %FaultErrorID% == 1 (SET ProcessValue=No errors were detected and all data was duplicated successfully!  This error should have never occurred! && GOTO ErrorPrint)
IF %FaultErrorID% == 2 (SET ProcessValue=There was additional files within the destination directory that was not included from the source!  However, nothing was duplicated. && GOTO ErrorPrint)
IF %FaultErrorID% == 3 (SET ProcessValue=There was additional files that were already present within the destination, but the requested source data was successfully duplicated! && GOTO ErrorPrint)
IF %FaultErrorID% == 5 (SET ProcessValue=There were some files that did match the source files.  Thus, meaning, an integrity errors have occurred. && GOTO ErrorPrint)
IF %FaultErrorID% == 6 (SET ProcessValue=Other files existed within the destination directory that were not duplicated from the source.  Additionally, integrity errors have also occurred on some of the duplicated files! && GOTO ErrorPrint)
IF %FaultErrorID% == 7 (SET ProcessValue=Other files existed within the destination directory that were not duplicated from the source.  Additionally, integrity errors have also occurred on some of the duplicated files! && GOTO ErrorPrint)
IF %FaultErrorID% == 8 (SET ProcessValue=Some of the files within the source directory could not be copied to the destination! && GOTO ErrorPrint)
IF %FaultErrorID% == 16 (SET ProcessValue=A very serious and vague error has occurred! && GOTO ErrorPrint)
IF %FaultErrorID% == 9009 (SET ProcessValue=The command does not exist! && GOTO ErrorPrint)
GOTO BadFaultErrorID


:BadFaultErrorID
REM Less repetitive this way
SET ProcessValue=Could not find Exit Code in Bootless Star's registry, thus this error is unknown!
GOTO ErrorPrint


:ErrorPrint
CLS
ECHO %HeadBorder%
ECHO %HeadTitle%
ECHO %HeadBorder%
ECHO Fault Error
ECHO. && ECHO. && ECHO.
IF %UsePCSpeaker% GTR 0 (ECHO %PCSpeaker% && ECHO %PCSpeaker%)
ECHO ^<!^>    Program Failure    ^<!^>
ECHO.
ECHO %ProcessValue%
ECHO.
ECHO Command Executed or Requested: %ExeExtCMDFault%
ECHO Exit Code: %FaultErrorID%
ECHO At: %FaultMethodID%
ECHO. && ECHO.
PAUSE
GOTO Main


:Kill
SET NavVar=0
:: Exit Codes
:: 0=Clean Exit | 1=User Declined the ToU | 2=Hook Fault
IF %cacheNavVar% EQU ToUDeclined (EXIT /B 1)
IF %cacheNavVar% EQU HookFail (EXIT /B 2)
CLS
ECHO ^(?^)   End Program   ^(?^)
ECHO.
ECHO Are you sure you want to end this program?
ECHO %ChoiceSel%
ECHO %ChoiceYN%
SET /P NavVar=^>^> 

IF /I "%NavVar%" EQU "Y" (ECHO Terminated program && EXIT /B 0)
IF /I "%NavVar%" EQU "Yes" (ECHO Terminated program && EXIT /B 0)
IF /I "%NavVar%" EQU "N" (GOTO Main)
IF /I "%NavVar%" EQU "No" (GOTO Main) ELSE (SET STDINErr=Kill && GOTO BadInput)


:BadInput
CLS
ECHO ^<!^>   Bad Input   ^<!^>
ECHO.
ECHO The input by the user did not match what the program was wanting.
ECHO User Input was reported = "%NavVar%"
ECHO.
ECHO Press any key to restart this section...
PAUSE>NUL
SET NavVar=0
GOTO %STDINErr%