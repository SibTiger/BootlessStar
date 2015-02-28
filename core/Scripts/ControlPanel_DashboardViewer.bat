REM =====================================================================
REM Control Panel: Dashboard Viewer Tool
REM ----------------------------
REM Allow the user to configure the dashboard tool.
REM For some modules, disabling this feature might help with over all performances.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function is a translator which takes the variable's value and stores a nicer value name to a temporary working variable.
REM # =============================================================================================
:ControlPanel_DashboardTool_Translator
IF %DashboardViewerTool% EQU True SET ProcessVarA=Enable& GOTO :EOF
IF %DashboardViewerTool% EQU False SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Dashboard Viewer menu
REM # =============================================================================================
:ControlPanel_DashboardTool
CALL :DashboardDisplay
REM Translate the actual variable value into another variable with a nicer value.
CALL :ControlPanel_DashboardTool_Translator
ECHO Dashboard Viewer Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO The Dashboard Viewer tool only displays quick and brief information that the user will likely need to know.
ECHO.
ECHO Default Value: Enable
ECHO Dashboard Viewer is Currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Disable
ECHO [2] Enable
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_DashboardTool_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_DashboardTool_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_DashboardTool_Toggle Disable
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DashboardTool
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_DashboardTool_Toggle Enable
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DashboardTool
)
CALL :BadInput& GOTO :ControlPanel_DashboardTool



REM # =============================================================================================
REM # Parameters: [{Bool} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_DashboardTool_Toggle
IF %1 EQU Enable (
    SET DashboardViewerTool=True
    GOTO :EOF
) ELSE (
    SET DashboardViewerTool=False
    GOTO :EOF
)