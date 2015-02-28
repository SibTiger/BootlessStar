REM =====================================================================
REM Debugger Tool
REM ----------------------------
REM This section allows the user to use the debugger tool to either print the users configuration or display the code in real time.  This is not for general purposes, but for debugging and finding errors or inspecting the environment within the current session.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Debugger menu
REM # =============================================================================================
:DebuggerTool
CALL :DashboardDisplay
ECHO Debugger Tool
ECHO.
ECHO Options available:
ECHO %Separator%
ECHO [User] Display User Vars
ECHO [ECHO] Display code in real time
ECHO [X] Cancel
CALL :UserInput
GOTO :DebuggerTool_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:DebuggerTool_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "User" (
    CALL :ClearBuffer 1
    CALL :DebuggerTool_User
    CALL :ClearBuffer 1
    GOTO :DebuggerTool
)
IF /I "%STDIN%" EQU "ECHO" (
    CALL :DebuggerTool_EchoOperations
    CALL :ClearBuffer 1
    GOTO :DebuggerTool
)
CALL :BadInput& GOTO :DebuggerTool



REM # =============================================================================================
REM # Documentation: If the user requests to enable or disable the 'ECHO' mode, this function will manage that setting.  Within this function, this will set the DebugMode variable and will also toggle the ECHO mode.
REM # =============================================================================================
:DebuggerTool_EchoOperations
IF "%DebugMode%" EQU "False" (
    SET DebugMode=True
    ECHO ON
    GOTO :EOF
) ELSE (
    SET DebugMode=False
    ECHO OFF
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: When this function is called, this will output the user's current configuration on to the terminal screen.  This will use the EnvironmentSetup section in order to properly display all of the results.
REM # =============================================================================================
:DebuggerTool_User
ECHO User Variables
ECHO %Separator%
ECHO.
CALL :EnvironmentSetup_Switch DebugUser
CALL :DebuggerTool_FinishedOut
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will be executed when the debug mode or debug request is finished.
REM # =============================================================================================
:DebuggerTool_FinishedOut
ECHO.
ECHO %SeparatorLong%
ECHO Finished
PAUSE
GOTO :EOF