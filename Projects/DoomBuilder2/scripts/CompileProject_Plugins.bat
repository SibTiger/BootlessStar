REM -------------------------------
REM -------------------------------
REM Builder Modes


REM # =============================================================================================
REM # Documentation: Compile the BuilderModes plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_BuilderModes
CALL :CompileProject_CompilePlugins_BuilderModes_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_BuilderModes_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_BuilderModes_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Builder Modes plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginBuilderModesAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_BuilderModes_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Builder Modes plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginBuilderModes%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Comments Panel


REM # =============================================================================================
REM # Documentation: Compile the Comments Panel plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_CommentsPanel
CALL :CompileProject_CompilePlugins_CommentsPanel_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_CommentsPanel_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_CommentsPanel_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Comments Panel plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginCommentsPanelAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_CommentsPanel_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Comments Panel plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginCommentsPanel%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Copy Paste


REM # =============================================================================================
REM # Documentation: Compile the Copy+Paste plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_CopyPaste
CALL :CompileProject_CompilePlugins_CopyPaste_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_CopyPaste_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_CopyPaste_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Sector Copy and Paste Properties plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginCopyPasteAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_CopyPaste_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Sector Copy and Paste Properties plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginCopyPaste%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Image Drawer


REM # =============================================================================================
REM # Documentation: Compile the Image Drawer plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_ImageDrawer
CALL :CompileProject_CompilePlugins_ImageDrawer_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_ImageDrawer_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_ImageDrawer_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Image Drawer plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginImageDrawAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%


:CompileProject_CompilePlugins_ImageDrawer_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Image Drawer plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginImageDraw%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Statistics


REM # =============================================================================================
REM # Documentation: Compile the Statistics plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_Statistics
CALL :CompileProject_CompilePlugins_Statistics_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_Statistics_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_Statistics_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Statistics plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginStatisticsAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_Statistics_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Statistics plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginStatistics%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Tag Range


REM # =============================================================================================
REM # Documentation: Compile the Tag Range plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_TagRange
CALL :CompileProject_CompilePlugins_TagRange_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_TagRange_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_TagRange_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Tag Range plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginTagRangeAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_TagRange_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Tag Range plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginTagRange%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM USDF


REM # =============================================================================================
REM # Documentation: Compile the USDF plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_USDF
CALL :CompileProject_CompilePlugins_USDF_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_USDF_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_USDF_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the USDF plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginUSDFAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_USDF_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the USDF plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginUSDF%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM GZDoom Virtual Mode


REM # =============================================================================================
REM # Documentation: Compile the GZDoom Virtual Mode plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_GZDoomVirtualMode
CALL :CompileProject_CompilePlugins_GZDoomVirtualMode_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_GZDoomVirtualMode_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_GZDoomVirtualMode_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the GZDoom Virtual Mode plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginGZDoomVirtualModeAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_GZDoomVirtualMode_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the GZDoom Virtual Mode plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginGZDoomVirtualMode%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM WadAuthor Virtual Mode


REM # =============================================================================================
REM # Documentation: Compile the WadAuthor plugin
REM # =============================================================================================
:CompileProject_CompilePlugins_WadAuthorVirtualMode
CALL :CompileProject_CompilePlugins_WadAuthorVirtualMode_UpdateVersion || EXIT /B %ERRORLEVEL%
CALL :CompileProject_CompilePlugins_WadAuthorVirtualMode_Compile || EXIT /B %ERRORLEVEL%
EXIT /B 0



:CompileProject_CompilePlugins_WadAuthorVirtualMode_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the WADAuthor Virtual Mode plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginWadAuthorVirtualModeAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_WadAuthorVirtualMode_Compile
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the WADAuthor Virtual Mode plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginWadAuthorVirtualMode%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



REM -------------------------------
REM -------------------------------
REM Visplane Explorer


REM # =============================================================================================
REM # Documentation: Compile the Visplane Explorer plugin; this requires upgrading the source files to the latest version of Visual Studio.
REM # =============================================================================================
:CompileProject_CompilePlugins_VisplaneExplorer
CALL :CompileProject_CompilePlugins_VisplaneExplorer_UpdateVersion || EXIT /B 1
CALL :CompileProject_CompilePlugins_VisplaneExplorer_UpgradeLibrary || EXIT /B 1
REM ----
REM Can we find the file?
CALL :CompileProject_CompilePlugins_VisplaneExplorer_ResourceCheck || EXIT /B 1
REM ----
CALL :CompileProject_CompilePlugins_VisplaneExplorer_Library || EXIT /B 1
CALL :CompileProject_CompilePlugins_VisplaneExplorer_MirrorFiles || EXIT /B 1
CALL :CompileProject_CompilePlugins_VisplaneExplorer_BuildVisplaneExplorer || EXIT /B 1
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_VisplaneExplorer_ResourceCheck
CALL :CompileProject_Display_IncomingTaskSubLevel "Can Visplane Explorer's plugin support version update?"
REM Can we find the upgraded Visplane project?
CALL :CompileProject_CheckResources_CheckTargets_Process "%ProjectDirectory.PathPluginVisplaneExplorerLibraryUpgrade%" || EXIT /B 1
EXIT /B 0



:CompileProject_CompilePlugins_VisplaneExplorer_BuildVisplaneExplorer
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Visplane Explorer plugin"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginVisplaneExplorer%" %MSVSArg%
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_VisplaneExplorer_Library
CALL :CompileProject_Display_IncomingTaskSubLevel "Compiling the Visplane Explorer Dynamic Link Library"
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: MSBuild Compiler Task" /B /WAIT /%PriorityGeneral% MSBUILD "%ProjectDirectory.PathPluginVisplaneExplorerLibraryUpgrade%" %MSVSArgVPO% /property:OutDir=.\
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_VisplaneExplorer_MirrorFiles
CALL :CompileProject_Display_IncomingTaskSubLevel "Transitioning the Visplane Explorer Dynamic Link Library to the Visplane Explorer plugin directory"
SET TaskCaller_NiceProgramName=Copy
SET TaskCaller_CallLong=COPY /V /Z "%ProjectDirectory.PathPluginVisplaneExplorerLibraryDir%vpo.dll" "%ProjectDirectory.PathPluginVisplaneExplorerDir%"
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_VisplaneExplorer_UpgradeLibrary
CALL :CompileProject_Display_IncomingTaskSubLevel "Upgrading the Visplane Explorer project to support the latest Microsoft Visual Studio version"
SET TaskCaller_NiceProgramName=Visual Studio VCUPGRADE
SET TaskCaller_NiceProgramName=Visual Studio MSBuild
SET TaskCaller_CallLong=START "Batch Fork: Project Upgrader Task" /B /WAIT /%PriorityGeneral% VCUPGRADE "%ProjectDirectory.PathPluginVisplaneExplorerLibrary%" /OverWrite
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%



:CompileProject_CompilePlugins_VisplaneExplorer_UpdateVersion
REM ----
REM Can we run this function?
IF %ProjectModify.UpdateInternalProjectVersion% EQU False EXIT /B 0
REM ----
CALL :CompileProject_Display_IncomingTaskSubLevel "Updating the Visplane Explorer plugin version"
SET TaskCaller_CallLong=START "Batch Fork: Update Project Version Task" /B /WAIT /%PriorityGeneral% "%ProjectDirectory.VersionFromSVN%" "%ProjectDirectory.PathPluginVisplaneExplorerAssembly%" -F %SVNRevisionNew%
SET TaskCaller_NiceProgramName=Update Internal Project Version ID
CALL :CompileProject_TaskOperation
EXIT /B %ERRORLEVEL%