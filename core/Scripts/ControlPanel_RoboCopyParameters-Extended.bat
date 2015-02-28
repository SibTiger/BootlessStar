REM =====================================================================
REM Control Panel: Robocopy Behavior [Extended]
REM ----------------------------
REM This allows the user to change the behavioral of the external command 'Robocopy'.  This section merely adjusts special parameters and switches are to be used when using the command.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: Maximum Wait time (seconds) before retrying
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Wait
CALL :DashboardDisplay
ECHO Robocopy Wait Time
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO Wait time between failed retries
ECHO.
ECHO %Separator%
ECHO Enter a new value in terms of seconds of how long it should take to retry processing the requested data file.
ECHO Current Value: %ParametersRobocopy.Wait%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_RoboCopyParameterConfiguration_Wait_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Wait_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM ----
REM Make sure that the users input is a legal integer
ECHO %STDIN%|FINDSTR /R /C:"^[0-9][0-9]*$" > NUL || (CALL :BadInput& GOTO :ControlPanel_RoboCopyParameterConfiguration_Wait)
REM Set the value if it passed
SET ParametersRobocopy.Wait=%STDIN%
GOTO :EOF



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Maximum number of retries for each individual file
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Retry
CALL :DashboardDisplay
ECHO Robocopy Maximum Retries
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO Number of Retries on failed copies.
ECHO.
ECHO %Separator%
ECHO Enter a new value of how many times Robocopy should retry to process the requested file before skipping it.
ECHO Current Value: %ParametersRobocopy.Retry%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_RoboCopyParameterConfiguration_Retry_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Retry_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM ----
REM Make sure that the users input is a legal integer
ECHO %STDIN%|FINDSTR /R /C:"^[0-9][0-9]*$" > NUL || (CALL :BadInput& GOTO :ControlPanel_RoboCopyParameterConfiguration_Retry)
REM Set the value if it passed
SET ParametersRobocopy.Retry=%STDIN%
GOTO :EOF



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: How many threads should Robocopy process
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Multithreading
CALL :DashboardDisplay
ECHO Robocopy Multithreading
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO Do multi-threaded copies with a number of [1-128] threads
ECHO.
ECHO %Separator%
ECHO Enter a new value of how many threads Robocopy should process [1 through 128 threads possible]
ECHO Current Value: %ParametersRobocopy.Multithread%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_RoboCopyParameterConfiguration_Multithreading_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Multithreading_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM ----
REM Make sure that the users input is a legal integer
ECHO %STDIN%|FINDSTR /R /C:"^[0-9][0-9]*$" > NUL || (CALL :BadInput& GOTO :ControlPanel_RoboCopyParameterConfiguration_Multithreading)
REM ----
REM Make sure that the users input is a legal integer [1 -> 128]
IF %STDIN% GEQ 1 (
    IF %STDIN% LEQ 128 SET ParametersRobocopy.Multithread=%STDIN%& GOTO :EOF
)
CALL :BadInput& GOTO :ControlPanel_RoboCopyParameterConfiguration_Multithreading



REM # =============================================================================================
REM # Documentation: Update the ParametersRobocopy.Multithread variable.  This could have been done in the UserInput function, however to make things easier on myself [with how well nested conditional statements works in Batch Shell], lets just update the value here and properly process it through without mistakenly hitting a few bumps.
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Multithreading_Update
SET ParametersRobocopy.Multithread=%STDIN%
GOTO :EOF