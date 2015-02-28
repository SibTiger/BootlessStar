REM =====================================================================
REM Main Menu
REM ----------------------------
REM The main menu and the main navigation central point of the program.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Display the main menu screen.
REM # =============================================================================================
:MainScreen
CALL :DashboardDisplay
ECHO Main Menu
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] Run Project Modules
ECHO [2] Run External Scripts
ECHO [3] User Configuration
ECHO [4] Documentation
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [S] Settings
ECHO [U] Check for Updates
ECHO [R] Restart Program
ECHO [X] Exit
REM Allow the user to input their request into the program.
CALL :UserInput
REM Inspect their input.
GOTO :MainScreen_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:MainScreen_UserInput
REM Read the STDIN and process it
IF "%STDIN%" EQU "1" GOTO :MainScreen_ChoiceRunProjectModule
IF "%STDIN%" EQU "2" GOTO :MainScreen_ChoiceRunExternalScript
IF "%STDIN%" EQU "3" GOTO :MainScreen_ChoiceUserConfiguration
IF "%STDIN%" EQU "4" GOTO :MainScreen_ChoiceDocumentation
IF /I "%STDIN%" EQU "S" GOTO :MainScreen_ChoiceSettings
IF /I "%STDIN%" EQU "U" GOTO :MainScreen_ChoiceUpdates
IF /I "%STDIN%" EQU "R" GOTO :MainScreen_ChoiceRestartProgram
IF /I "%STDIN%" EQU "Restart" GOTO :MainScreen_ChoiceRestartProgram
IF /I "%STDIN%" EQU "X" GOTO :MainScreen_ChoiceExit
IF /I "%STDIN%" EQU "Exit" GOTO :MainScreen_ChoiceExit
IF /I "%STDIN%" EQU "Quit" GOTO :MainScreen_ChoiceExit
CALL :BadInput& GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: This function calls a feature that allows the user to launch scripts that is compatible with the core's environment.
REM # =============================================================================================
:MainScreen_ChoiceRunProjectModule
REM Compile projects
CALL :ClearBuffer 1
CALL :ProjectLoader
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: This function calls the external module and script feature -- these are not core compatible scripts.
REM # =============================================================================================
:MainScreen_ChoiceRunExternalScript
CALL :ClearBuffer 1
CALL :LoadExtScripts
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Allow the user to manage their own personal saved preset configuration files.
REM # =============================================================================================
:MainScreen_ChoiceUserConfiguration
CALL :ClearBuffer 1
CALL :UserConfiguration
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Call the Document Viewer tool.
REM # =============================================================================================
:MainScreen_ChoiceDocumentation
CALL :ClearBuffer 1
CALL :Documents
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Allow the user to make adjustments within the program.
REM # =============================================================================================
:MainScreen_ChoiceSettings
CALL :ClearBuffer 1
CALL :ControlPanel
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Allows the user to check for program updates; requires an internet connection!
REM # =============================================================================================
:MainScreen_ChoiceUpdates
CALL :ClearBuffer 1
CALL :Updates
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Restart the program or specifically - refresh the environment variables.
REM # =============================================================================================
:MainScreen_ChoiceRestartProgram
CALL :ClearBuffer 1
CALL :EnvironmentSetup_Switch Restart
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Terminate the program.
REM # =============================================================================================
:MainScreen_ChoiceExit
CALL :ClearBuffer 1
CALL :KillPrompt
CALL :ClearBuffer 1
GOTO :MainScreen