REM =====================================================================
REM Control Panel: XCopy Behavior
REM ----------------------------
REM This allows the user to change the behavioral of the external command 'XCopy'.  This section merely adjusts what parameters and switches are to be used when using the command.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: XCopy [ExtCMD] software Behavior Menu
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration
CALL :DashboardDisplay
ECHO XCopy Switches Configuration
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO This allows the ability for the user to customize the switches that can be utilized when a module copies data using 'XCOPY'
ECHO.
ECHO %Separator%
ECHO [1] Verify Data
ECHO     Switch: /V
ECHO     Current: %ParametersXCopy.Verify%
ECHO [2] Continue Operation regardless of Errors
ECHO     Switch: /C
ECHO     Current: %ParametersXCopy.Continue%
ECHO [3] Files encrypted stays encrypted (even if destination does not allow it)
ECHO     Switch: /G
ECHO     Current: %ParametersXCopy.Encrypt%
ECHO [4] Suppress Overwrite Messages
ECHO     Switch: /Y
ECHO     Current: %ParametersXCopy.Suppress%
ECHO [5] Network Restart Mode
ECHO     Switch: /Z
ECHO     Current: %ParametersXCopy.Restart%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_XCopyParameterConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM The idea here is to change the initial value and then build the entire XCopyArg
IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_XCopyParameterConfiguration_Toggle_Verify
    CALL :ControlPanel_XCopyParameterConfiguration_Builder
    CALL :ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_XCopyParameterConfiguration
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_XCopyParameterConfiguration_Toggle_Continue
    CALL :ControlPanel_XCopyParameterConfiguration_Builder
    CALL :ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_XCopyParameterConfiguration
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_XCopyParameterConfiguration_Toggle_Encrypt
    CALL :ControlPanel_XCopyParameterConfiguration_Builder
    CALL :ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_XCopyParameterConfiguration
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_XCopyParameterConfiguration_Toggle_Suppress
    CALL :ControlPanel_XCopyParameterConfiguration_Builder
    CALL :ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_XCopyParameterConfiguration
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_XCopyParameterConfiguration_Toggle_Restart
    CALL :ControlPanel_XCopyParameterConfiguration_Builder
    CALL :ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_XCopyParameterConfiguration
)
CALL :BadInput& GOTO :ControlPanel_XCopyParameterConfiguration



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Continue
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Toggle_Continue
IF %ParametersXCopy.Continue% EQU True (
    SET ParametersXCopy.Continue=False
) ELSE (
    SET ParametersXCopy.Continue=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Encryption to destination
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Toggle_Encrypt
IF %ParametersXCopy.Encrypt% EQU True (
    SET ParametersXCopy.Encrypt=False
) ELSE (
    SET ParametersXCopy.Encrypt=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Verify
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Toggle_Verify
IF %ParametersXCopy.Verify% EQU True (
    SET ParametersXCopy.Verify=False
) ELSE (
    SET ParametersXCopy.Verify=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Suppress Warnings
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Toggle_Suppress
IF %ParametersXCopy.Suppress% EQU True (
    SET ParametersXCopy.Suppress=False
) ELSE (
    SET ParametersXCopy.Suppress=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Restart
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Toggle_Restart
IF %ParametersXCopy.Restart% EQU True (
    SET ParametersXCopy.Restart=False
) ELSE (
    SET ParametersXCopy.Restart=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the entire XCopyArg variable.  This works by simply taking all of the supported parameters and updates the main holder variable
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_Builder
REM First, clear the entire variable by uninitializing it
SET XCopyArg=
REM Build it again with the newer changes
IF %ParametersXCopy.Verify% EQU True (
    SET XCopyArg=%XCopyArg%/V 
)

IF %ParametersXCopy.Continue% EQU True (
    SET XCopyArg=%XCopyArg%/C 
)

IF %ParametersXCopy.Encrypt% EQU True (
    SET XCopyArg=%XCopyArg%/G 
)

IF %ParametersXCopy.Suppress% EQU True (
    SET XCopyArg=%XCopyArg%/Y 
)

IF %ParametersXCopy.Restart% EQU True (
    SET XCopyArg=%XCopyArg%/Z 
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: If the user has the extCMD XCOPY as the primary mass copier, then update the CopyArg parameter.
REM # =============================================================================================
:ControlPanel_XCopyParameterConfiguration_CopyArgUpdate
IF %CopyMethod% EQU XCOPY (
    SET "CopyArg=%XCopyArg%"
)
GOTO :EOF