REM =====================================================================
REM Control Panel: Priority Level [Kernel Throttle Request]
REM ----------------------------
REM When external commands are being processed, they are normally set through the kernel as 'Normal' priority level; however, it is possible to change that priority leveling to either a higher level or lower.
REM Refer to this documentation for more information: http://en.wikipedia.org/wiki/Scheduling_(computing)
REM For more details: http://msdn.microsoft.com/en-us/library/windows/desktop/ms685100(v=vs.85).aspx
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_Priority_Translator
IF /I "%PriorityGeneral%" EQU "Low" (
    SET ProcessVarA=Low
    GOTO :EOF
)
IF /I "%PriorityGeneral%" EQU "BelowNormal" (
    SET ProcessVarA=Below Normal
    GOTO :EOF
)
IF /I "%PriorityGeneral%" EQU "Normal" (
    SET ProcessVarA=Normal
    GOTO :EOF
)
IF /I "%PriorityGeneral%" EQU "AboveNormal" (
    SET ProcessVarA=Above Normal
    GOTO :EOF
)
IF /I "%PriorityGeneral%" EQU "High" (
    SET ProcessVarA=High
    GOTO :EOF
)
IF /I "%PriorityGeneral%" EQU "RealTime" (
    SET ProcessVarA=LUDICROUS SPEED!
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: Priority throttling menu
REM # =============================================================================================
:ControlPanel_Priority
CALL :DashboardDisplay
CALL :ControlPanel_Priority_Translator
ECHO Program Priority Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO It is possible to generally enforce all operations to work either faster or slower, but however, be warned that the faster may not always be better - generally.  For more details, please read Kernel Priority documentation for Windows.
ECHO.
ECHO Default Value: Normal
ECHO Priority Level is Currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Low
ECHO [2] Below Normal
ECHO [3] Normal
ECHO [4] Above Normal
ECHO [5] High
ECHO [6] LUDICROUS SPEED!
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_Priority_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_Priority_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_Priority_Switch Low
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_Priority_Switch BelowNormal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_Priority_Switch Normal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_Priority_Switch AboveNormal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_Priority_Switch High
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
IF "%STDIN%" EQU "6" (
    CALL :ControlPanel_Priority_Switch RealTime
    CALL :ClearBuffer 1
    GOTO :ControlPanel_Priority
)
CALL :BadInput& GOTO :ControlPanel_Priority



REM # =============================================================================================
REM # Parameters: [{String} SettingType]
REM # Documentation: Adjust the variable value as requested by the user.
REM # =============================================================================================
:ControlPanel_Priority_Switch
IF %1 EQU Low (
    SET PriorityGeneral=LOW
    GOTO :EOF
)
IF %1 EQU BelowNormal (
    SET PriorityGeneral=BELOWNORMAL
    GOTO :EOF
)
IF %1 EQU Normal (
    SET PriorityGeneral=NORMAL
    GOTO :EOF
)
IF %1 EQU AboveNormal (
    SET PriorityGeneral=ABOVENORMAL
    GOTO :EOF
)
IF %1 EQU High (
    SET PriorityGeneral=HIGH
    GOTO :EOF
)
IF %1 EQU RealTime (
    SET PriorityGeneral=REALTIME
    GOTO :EOF
)