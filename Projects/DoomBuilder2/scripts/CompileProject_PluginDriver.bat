REM -----------------------------------------------------------------
REM =================================================================
REM -----------------------------------------------------------------
REM                      Doom Builder 2 Plugins


REM # =============================================================================================
REM # Parameters: [{int} TypeOfPlugins]
REM # Documentation: This driver will help make sure that the right plugins are compiled.
REM # =============================================================================================
:CompileProject_CompilePlugins
REM This variable is used to describe the drivers main purpose and present the value in the log files.
SET "DriversNiceTask=Compiling selective plugins"
CALL :CompileProject_Display_IncomingTask "%DriversNiceTask%"
REM No plugins
IF %1 EQU 0 CALL :CompileProject_CompilePlugins_NoPlugins || EXIT /B 1
REM Default plugins
IF %1 EQU 1 CALL :CompileProject_CompilePlugins_DefaultPlugins || EXIT /B 1
REM All plugins
IF %1 EQU 2 CALL :CompileProject_CompilePlugins_AllPlugins || EXIT /B 1
CALL :CompileProject_DriverLogFooter "%DriversNiceTask%"
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Do not compile any of the plugins.
REM # =============================================================================================
:CompileProject_CompilePlugins_NoPlugins
CALL :CompileProject_Display_IncomingTaskSubLevelMSG "User requested to not compile any plugins!"
EXIT /B 0


REM # =============================================================================================
REM # Documentation: Compile only the default plugins; this is either determined by the developers of the project, or by 'MakeRelease.bat'.
REM # =============================================================================================
:CompileProject_CompilePlugins_DefaultPlugins
CALL :CompileProject_Display_IncomingTaskSubLevelMSG "Compiling default plugins for the %ProjectName% project"
CALL :CompileProject_CompilePlugins_BuilderModes || (CALL :CaughtErrorSignal& EXIT /B 1)
EXIT /B 0



REM # =============================================================================================
REM # Documentation: Compile all plugins that is known; Any supported plugin that is located in the plugins directory is fair game.
REM # =============================================================================================
:CompileProject_CompilePlugins_AllPlugins
CALL :CompileProject_Display_IncomingTaskSubLevelMSG "Compiling all available plugins for the %ProjectName% project"
CALL :CompileProject_CompilePlugins_BuilderModes || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_CommentsPanel || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_CopyPaste || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_ImageDrawer || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_Statistics || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_TagRange || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_USDF || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_GZDoomVirtualMode || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_WadAuthorVirtualMode || (CALL :CaughtErrorSignal& EXIT /B 1)
CALL :CompileProject_CompilePlugins_VisplaneExplorer || (CALL :CaughtErrorSignal& EXIT /B 1)
EXIT /B 0