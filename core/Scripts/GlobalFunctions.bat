REM =====================================================================
REM Global Functions
REM ----------------------------
REM These functions listed below is used to reduce redundancy within the program by having these functions to be generally used within the code.
REM =====================================================================


REM # =============================================================================================
REM # Parameters: [{Bool} FlushData]
REM # Documentation: This function simply clears the terminal buffer, and depending on the parameter this can also clear the StandardIn [STDIN] identifier.
REM # =============================================================================================
:ClearBuffer
CLS
REM Clear the STDIN
IF %1 EQU 1 SET STDIN=
GOTO :EOF


REM # =============================================================================================
REM # Documentation: This function will simply clear the STDIN variable
REM # =============================================================================================
:ClearSTDIN
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
REM # Documentation: This function will call the main Dashboard function directly, this is if the user has enabled the Dashboard functionality within the program.
REM # =============================================================================================
:DashboardDisplay
IF %DashboardViewerTool% EQU True CALL :Dashboard
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} Target]
REM # Documentation: This function will call the Windows Explorer and open the destination that is given when calling this function with a parameter.
REM # =============================================================================================
:Call_WindowsExplorer
EXPLORER "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} File]
REM # Documentation: This function will update the title of the core and display what script is being executed.
REM # =============================================================================================
:UpdateCoreTitleExecutingScript
SET "ProcessVarA=%core.Title% [Running: %~n1]"
TITLE %ProcessVarA%
REM ProcessVarA is left as is so the caller (that called this function) can utilize it if needed
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will only display a read error message when the user requests to install a script.
REM # =============================================================================================
:CantInstallScriptErrorMessage
ECHO The directory could not be found!  It is not possible to install or even execute any scripts!
ECHO.
ECHO Possible Solutions:
ECHO 1) Check user permissions on the system.
ECHO 2) The program [%ProgramName%] is not in a tightly limited permissive directory
ECHO 3) Hardware faults; check for File System corruptions and health of the Secondary Storage device [HDD and\or SDD]
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will be called when the user's input does not meet the criteria that the program was wanting.  This is typically used when using the menu selections.
REM # =============================================================================================
:BadInput
ECHO.&ECHO.
ECHO ^<!^>    Invalid Input    ^<!^>
ECHO %Separator%
ECHO.
ECHO !ERR: Incorrect feedback from the user.
ECHO User Feedback: "%STDIN%"
ECHO.
PAUSE
CALL :ClearBuffer 1
GOTO :EOF