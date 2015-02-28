REM =====================================================================
REM Control Panel: Copy Parameters and Switches Configurations Menu
REM ----------------------------
REM This section allows the user to modify the copying software's behavior and how the data is duplicated.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Mass Copy Settings Menu
REM # =============================================================================================
:ControlPanel_CopyBehaviorConfiguration
CALL :DashboardDisplay
ECHO Copy Behavior Selection
ECHO.
ECHO Select the following options:
ECHO %Separator%
ECHO [1] COPY [Internal Command]
ECHO [2] XCOPY
ECHO [3] ROBOCOPY
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Exit
CALL :UserInput
GOTO :ControlPanel_CopyBehaviorConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_CopyBehaviorConfiguration_UserInput
IF "%STDIN%" EQU "1" GOTO :ControlPanel_CopyBehaviorConfiguration_Choice_COPYintCMDConfiguration
IF "%STDIN%" EQU "2" GOTO :ControlPanel_CopyBehaviorConfiguration_Choice_XCOPYConfiguration
IF "%STDIN%" EQU "3" GOTO :ControlPanel_CopyBehaviorConfiguration_Choice_ROBOCOPYConfiguration
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
CALL :BadInput& GOTO :ControlPanel_CopyBehaviorConfiguration



REM # =============================================================================================
REM # Documentation: Call the function that allows the user to modify the intCMD COPY's parameters and switches.
REM # =============================================================================================
:ControlPanel_CopyBehaviorConfiguration_Choice_COPYintCMDConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_intCMDCopyParameterConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanel_CopyBehaviorConfiguration



REM # =============================================================================================
REM # Documentation: Call the function that allows the user to modify XCOPY's parameters and switches.
REM # =============================================================================================
:ControlPanel_CopyBehaviorConfiguration_Choice_XCOPYConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_XCopyParameterConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanel_CopyBehaviorConfiguration



REM # =============================================================================================
REM # Documentation: Call the function that allows the user to modify ROBOCOPY's parameters and switches.
REM # =============================================================================================
:ControlPanel_CopyBehaviorConfiguration_Choice_ROBOCOPYConfiguration
CALL :ClearBuffer 1
CALL :ControlPanel_RoboCopyParameterConfiguration
CALL :ClearBuffer 1
GOTO :ControlPanel_CopyBehaviorConfiguration