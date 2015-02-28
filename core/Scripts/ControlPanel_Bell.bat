REM =====================================================================
REM Control Panel: Terminal Sounds
REM ----------------------------
REM Within the terminal, it is possible to have a bell [or alarm] signal.  This feature gives the ability to send an alarm to the user if an event happens.  Modules _may_ treat this differently, this is not core specific but module specific.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function is a translator which takes the variable's value and stores a nicer value name to a temporary working variable.
REM # =============================================================================================
:ControlPanel_TerminalSound_Translator
IF %UseBell% EQU 0 SET ProcessVarA=Disabled& GOTO :EOF
IF %UseBell% EQU 1 SET ProcessVarA=Enabled [Notify for all notifications]& GOTO :EOF
IF %UseBell% EQU 2 SET ProcessVarA=Enabled [Notify only for errors]
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Terminal sound menu
REM # =============================================================================================
:ControlPanel_TerminalSound
CALL :DashboardDisplay
REM Translate the actual variable value into another variable with a nicer value.
CALL :ControlPanel_TerminalSound_Translator
ECHO Terminal Sound Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When the program runs into a critical state or an event occurs, this program can alarm the user by supplying a 'Beep' noise.  These notifications, however, can only be played through the system's speakers and not the internal PC Speaker.
ECHO.
ECHO Default Value: Sounds for either successful or failed operations
ECHO Sounds is currently: %ProcessVarA%
ECHO %Separator%
ECHO Notify when:
ECHO [1] Notify for all notifications
ECHO [2] Notify only for errors
ECHO [3] Disabled
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_TerminalSound_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_TerminalSound_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_TerminalSound_Toggle All
    CALL :ClearBuffer 1
    GOTO :ControlPanel_TerminalSound
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_TerminalSound_Toggle Error
    CALL :ClearBuffer 1
    GOTO :ControlPanel_TerminalSound
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_TerminalSound_Toggle Off
    CALL :ClearBuffer 1
    GOTO :ControlPanel_TerminalSound
)
CALL :BadInput& GOTO :ControlPanel_TerminalSound



REM # =============================================================================================
REM # Parameters: [{String} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_TerminalSound_Toggle
IF %1 EQU All (
    REM Always send an alarm when an event happens
    SET UseBell=1
    GOTO :EOF
)
IF %1 EQU Error (
    REM Send an alarm when an error event happens
    SET UseBell=2
    GOTO :EOF
)
IF %1 EQU Off (
    REM Disallow the entire feature.
    SET UseBell=0
    GOTO :EOF
)