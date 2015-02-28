REM =====================================================================
REM Global Functions
REM ----------------------------
REM These functions listed below is used to reduce redundancy within the code.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function simply clears the terminal buffer and also the StandardIn [STDIN] identifier.
REM # =============================================================================================
:ClearBuffer
CLS
REM Clear the STDIN
SET STDIN=
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function captures the user's input from the keyboard.
REM # =============================================================================================
:UserInput
ECHO.
ECHO %SeparatorSmall%
SET /P STDIN=^>^>^>^> 
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function determines wither to render the Dashboard Viewer tool or only the classical header.  This is determined by the users settings based from the core, not this module.
REM # =============================================================================================
:DashboardOrClassicalDisplay
IF %DashboardViewerTool% EQU True (
    CALL :Dashboard
) ELSE (
    ECHO %ProjectName% Module Version: %ProjectVersion%
)
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} Target]
REM # Documentation: This function will call the Windows Explorer and open the destination that is given when calling this function with a parameter.
REM # =============================================================================================
:Call_WindowsExplorer
EXPLORER "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will be called when the user's input does not meet the criteria that the program was wanting.  This is typically used when using the menu selections.
REM # =============================================================================================
:BadInput
ECHO.&ECHO.
ECHO ^<!^>       Invalid Input       ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO !ERR: Incorrect feedback from the user.
ECHO User Feedback: "%STDIN%"
ECHO.
PAUSE
CALL :ClearBuffer
GOTO :EOF