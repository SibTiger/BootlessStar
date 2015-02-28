REM =====================================================================
REM Terminate Program
REM ----------------------------
REM This entire section allows the program to properly exit and do any extra procedures necessary before the program terminates completely.
REM Exit Code:
REM   0 = Clean Exit
REM   1 = Environment Hooking
REM   2 = Incorrect Parameters or Syntax Error
REM   3 = Premature Termination or Crash
REM   4 = Incompatible Operating System
REM =====================================================================


REM # =============================================================================================
REM # Parameters: [{String} Mode]
REM # Documentation: This function primarily deals with error termination procedures.
REM #   Incompatible OS
REM #   Environment Hooking
REM #   Incorrect Parameters or Syntax error.
REM # =============================================================================================
:Kill
IF %IncompatibleOS% EQU True (
    REM Because the Windows 9x and ME Operating Systems do not call a subroutine with parameters, we still have to check by a variable.
    REM Remember, to stay compatible within the ancient Windows Operating Systems.
    SET ExitCode=4
    ECHO !ERR_CRIT!: The host Operating System is not compatible with this program.
    GOTO :Terminator
)
REM --------------
REM Environment Hooking failed
IF %1 EQU Hook_Operation (
    SET ExitCode=1
    ECHO !ERR_CRIT!: Could not successfully modify the users working directory!
    CALL :EnvironmentSetup_Switch Thrash
    GOTO :Terminator
)
REM Bad parameter or incorrect syntax
IF %1 EQU BadParameter (
    SET ExitCode=2
    ECHO !ERR_CRIT!: This program was invoked with incorrect parameters.
    CALL :Terminator
)



REM # =============================================================================================
REM # Documentation: When the user requests to terminate the program from the Main Menu, this this function will be called.
REM # =============================================================================================
:KillPrompt
ECHO ^(?^)   End Program   ^(?^)
ECHO %Separator%
ECHO.
ECHO Are you sure you want to end this program?
ECHO.
ECHO [Y] Yes
ECHO [N] Cancel
CALL :UserInput
GOTO :KillPrompt_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:KillPrompt_UserInput
IF /I "%STDIN%" EQU "Y" GOTO :KillPrompt_ChoiceYes
IF /I "%STDIN%" EQU "Yes" GOTO :KillPrompt_ChoiceYes
IF /I "%STDIN%" EQU "Exit" GOTO :KillPrompt_ChoiceYes
IF /I "%STDIN%" EQU "Quit" GOTO :KillPrompt_ChoiceYes
IF /I "%STDIN%" EQU "N" GOTO :KillPrompt_ChoiceNo
IF /I "%STDIN%" EQU "No" GOTO :KillPrompt_ChoiceNo
CALL :BadInput& GOTO :KillPrompt



REM # =============================================================================================
REM # Documentation: If the user wishes to terminate the program, then prepare to terminate the program.
REM # =============================================================================================
:KillPrompt_ChoiceYes
SET ExitCode=0
REM Thrash anything that might be sensitive
CALL :EnvironmentSetup_Switch Thrash
REM Revert the user's Working Directory to its original state.
CALL :ClientWorkingDirectorySetup_RevertChange
GOTO :Terminator



REM # =============================================================================================
REM # Documentation: If the user does not want to terminate the program, then return the main menu.
REM # =============================================================================================
:KillPrompt_ChoiceNo
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: Terminate the program.
REM # =============================================================================================
:Terminator
ECHO Closing program...
CALL :ClearBuffer 1
EXIT %ExitCode%