REM =====================================================================
REM Control Panel: Log Settings
REM ----------------------------
REM This allows the user to toggle the Logfile functionality within this entire program.  This can be useful for debugging or viewing the output from all tasks and operations, such as MSBUILD, XCopy, moving, etc....
REM For faster performance disable this option, however, enable this if you want to know 'every' step that the compiler phase is doing.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function is a translator which takes the variable's value and stores a nicer value name to a temporary working variable.
REM # =============================================================================================
:ControlPanel_LogSettings_Translator
IF %ToggleLog% EQU True SET ProcessVarA=Enable& GOTO :EOF
IF %ToggleLog% EQU False SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Logfile menu
REM # =============================================================================================
:ControlPanel_LogSettings
CALL :DashboardDisplay
REM Translate the actual variable value into another variable with a nicer value.
CALL :ControlPanel_LogSettings_Translator
ECHO Log Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When compiling projects or tasks are performed for a project, logging will allow the user to view exactly what is being done in the background and even more verbose information that may not be available on the terminal screen.  For faster performance, leave this setting disabled.
ECHO.
ECHO Default Value: Disable
ECHO Logging is currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Disable Logging
ECHO [2] Enable Logging
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_LogSettings_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_LogSettings_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_LogSettings_Toggle False
    CALL :ClearBuffer 1
    GOTO :ControlPanel_LogSettings
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_LogSettings_Toggle True
    CALL :ClearBuffer 1
    GOTO :ControlPanel_LogSettings
)
CALL :BadInput& GOTO :ControlPanel_LogSettings



REM # =============================================================================================
REM # Parameters: [{Bool} SettingType]
REM # Documentation: Adjust the variable value as requested by the user, this will set the STDOUT variable live.
REM # =============================================================================================
:ControlPanel_LogSettings_Toggle
IF %1 EQU True (
    SET ToggleLog=True
    SET STDOUT=%ProgramName%_%core.Date%_%Project%.txt
    GOTO :EOF
) ELSE (
    SET ToggleLog=False
    SET STDOUT=NUL
    GOTO :EOF
)