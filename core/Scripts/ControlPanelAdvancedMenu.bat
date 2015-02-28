REM =====================================================================
REM Control Panel Advanced Menu
REM ----------------------------
REM This section allows the user to modify more advanced settings that most users will not generally care about.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Advanced settings menu
REM # =============================================================================================
:ControlPanelAdvanced
CALL :DashboardDisplay
ECHO Advanced Settings Menu
ECHO For the Power Users!
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] General Program Settings
ECHO [2] 7Zip Settings
ECHO [3] Copy Parameter Settings
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Exit
CALL :UserInput
GOTO :ControlPanelAdvanced_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanelAdvanced_UserInput
IF "%STDIN%" EQU "1" GOTO :ControlPanelAdvanced_Choice_GeneralProgramConfiguration
IF "%STDIN%" EQU "2" GOTO :ControlPanelAdvanced_Choice_7ZipConfiguration
IF "%STDIN%" EQU "3" GOTO :ControlPanelAdvanced_Choice_CopyParameterConfiguration
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :ControlPanelAdvanced



REM # =============================================================================================
REM # Documentation: Call the Advanced Menu for: General Program Settings.
REM # =============================================================================================
:ControlPanelAdvanced_Choice_GeneralProgramConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_GeneralProgramConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanelAdvanced



REM # =============================================================================================
REM # Documentation: Call the Advanced Menu for: 7Zip Configuration.
REM # =============================================================================================
:ControlPanelAdvanced_Choice_7ZipConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_7Zip
CALL :ClearBuffer 1
GOTO :ControlPanelAdvanced



REM # =============================================================================================
REM # Documentation: Call the Advanced Menu for: Copy Parameter Configurations menu.
REM # =============================================================================================
:ControlPanelAdvanced_Choice_CopyParameterConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_CopyBehaviorConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanelAdvanced