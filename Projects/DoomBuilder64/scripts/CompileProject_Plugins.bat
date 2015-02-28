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