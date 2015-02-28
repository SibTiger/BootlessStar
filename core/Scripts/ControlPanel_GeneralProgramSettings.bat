REM =====================================================================
REM Control Panel: General Program Configuration
REM ----------------------------
REM This section houses generalized program settings that the user is able to manipulate.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Advanced settings menu for General Program Configuration
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration
CALL :DashboardDisplay
ECHO General Program Configuration Menu
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] Toggle Explorer.exe Calls
ECHO [2] General Priority
ECHO [3] Toggle Dashboard Tool
ECHO [4] Toggle Module Window Sharing
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Exit
CALL :UserInput
GOTO :ControlPanel_GeneralProgramConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration_UserInput
IF "%STDIN%" EQU "1" GOTO :ControlPanel_GeneralProgramConfiguration_Choice_WindowsExplorer
IF "%STDIN%" EQU "2" GOTO :ControlPanel_GeneralProgramConfiguration_Choice_Priority
IF "%STDIN%" EQU "3" GOTO :ControlPanel_GeneralProgramConfiguration_Choice_DashboardViewerTool
IF "%STDIN%" EQU "4" GOTO :ControlPanel_GeneralProgramConfiguration_Choice_ModuleWindowSharing
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :ControlPanel_GeneralProgramConfiguration



REM # =============================================================================================
REM # Documentation: Call the Windows Explorer settings.
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration_Choice_WindowsExplorer
CALL :ClearBuffer 1
CALL :ControlPanel_WindowsExplorer
CALL :ClearBuffer 1
GOTO :ControlPanel_GeneralProgramConfiguration



REM # =============================================================================================
REM # Documentation:  Call the Windows process priority level.
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration_Choice_Priority
CALL :ClearBuffer 1
CALL :ControlPanel_Priority
CALL :ClearBuffer 1
GOTO :ControlPanel_GeneralProgramConfiguration



REM # =============================================================================================
REM # Documentation: Enable or disable the Dashboard Viewer tool.
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration_Choice_DashboardViewerTool
CALL :ClearBuffer 1
CALL :ControlPanel_DashboardTool
CALL :ClearBuffer 1
GOTO :ControlPanel_GeneralProgramConfiguration



REM # =============================================================================================
REM # Documentation: Enable or disable the modules being executed in the same window as the core.
REM # =============================================================================================
:ControlPanel_GeneralProgramConfiguration_Choice_ModuleWindowSharing
CALL :ClearBuffer 1
CALL :ControlPanel_ModuleExecuteSharingWindow
CALL :ClearBuffer 1
GOTO :ControlPanel_GeneralProgramConfiguration