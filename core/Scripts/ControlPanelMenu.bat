REM =====================================================================
REM Control Panel Menu
REM ----------------------------
REM Main setting screen; this allows the user to expeditiously modify the program settings and make any other customizations necessary.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Settings menu
REM # =============================================================================================
:ControlPanel
CALL :DashboardDisplay
ECHO Settings Menu
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] Copy Settings
ECHO [2] Directory Setup
ECHO [3] Terminal Sounds
ECHO [4] Logging Settings
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [A] Advanced Settings
ECHO [D] Debug %ProgramName%
ECHO [X] Exit
CALL :UserInput
GOTO :ControlPanel_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_UserInput
IF "%STDIN%" EQU "1" GOTO :ControlPanel_Choice_Copy
IF "%STDIN%" EQU "2" GOTO :ControlPanel_Choice_DirectorySetup
IF "%STDIN%" EQU "3" GOTO :ControlPanel_Choice_TerminalSounds
IF "%STDIN%" EQU "4" GOTO :ControlPanel_Choice_Logging
IF /I "%STDIN%" EQU "A" GOTO :ControlPanel_Choice_ControlPanelAdvanced
IF /I "%STDIN%" EQU "D" GOTO :ControlPanel_Choice_Debug
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Allow the ability for the user to change their preferred duplicating software.
REM # =============================================================================================
:ControlPanel_Choice_Copy
CALL :ClearBuffer 1
CALL :ControlPanel_CopyConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Allow the ability for the user to change the variable target that hoses either directories or exact file locations.
REM # =============================================================================================
:ControlPanel_Choice_DirectorySetup
CALL :ClearBuffer 1
CALL :ControlPanel_DirectorySetup
CALL :ClearBuffer 1
GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Terminal alarm settings.
REM # =============================================================================================
:ControlPanel_Choice_TerminalSounds
CALL :ClearBuffer 1
CALL :ControlPanel_TerminalSound
CALL :ClearBuffer 1
GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Allow the user to enable or disable the ability to log.
REM # =============================================================================================
:ControlPanel_Choice_Logging
CALL :ClearBuffer 1
CALL :ControlPanel_LogSettings
CALL :ClearBuffer 1
GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Call the debugger setting tool.
REM # =============================================================================================
:ControlPanel_Choice_Debug
CALL :ClearBuffer 1
CALL :DebuggerTool
CALL :ClearBuffer 1
GOTO :ControlPanel



REM # =============================================================================================
REM # Documentation: Call the advanced control panel.
REM # =============================================================================================
:ControlPanel_Choice_ControlPanelAdvanced
CALL :ClearBuffer 1
CALL :ControlPanelAdvanced
CALL :ClearBuffer 1
GOTO :ControlPanel