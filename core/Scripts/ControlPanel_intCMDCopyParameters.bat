REM =====================================================================
REM Control Panel: IntCMD Copy Behavior
REM ----------------------------
REM This allows the user to change the behavioral of the internal command 'Copy'.  This section merely adjusts what parameters and switches are to be used when using the command.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: Copy [IntCMD] software Behavior Menu
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration
CALL :DashboardDisplay
ECHO Copy [Internal Command] Switches Configuration
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO This allows the ability for the user to customize the switches that can be utilized when a module copies data using the internal command 'COPY'
ECHO.
ECHO %Separator%
ECHO [1] Decrypt Files
ECHO     Switch: /D
ECHO     Current: %ParametersCopy.Decrypt%
ECHO [2] Verify Data
ECHO     Switch: /V
ECHO     Current: %ParametersCopy.Verify%
ECHO [3] Suppress Overwrite Messages
ECHO     Switch: /Y
ECHO     Current: %ParametersCopy.Suppress%
ECHO [4] Network Restart Mode
ECHO     Switch: /Z
ECHO     Current: %ParametersCopy.Restart%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_intCMDCopyParameterConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM The idea here is to change the initial value and then build the entire CopyIntCMDArg
IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Toggle_Decrypt
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Builder
    CALL :ControlPanel_intCMDCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_intCMDCopyParameterConfiguration
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Toggle_Verify
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Builder
    CALL :ControlPanel_intCMDCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_intCMDCopyParameterConfiguration
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Toggle_Suppress
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Builder
    CALL :ControlPanel_intCMDCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_intCMDCopyParameterConfiguration
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Toggle_Restart
    CALL :ControlPanel_intCMDCopyParameterConfiguration_Builder
    CALL :ControlPanel_intCMDCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_intCMDCopyParameterConfiguration
)
CALL :BadInput& GOTO :ControlPanel_intCMDCopyParameterConfiguration



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Decrypt
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_Toggle_Decrypt
IF %ParametersCopy.Decrypt% EQU True (
    SET ParametersCopy.Decrypt=False
) ELSE (
    SET ParametersCopy.Decrypt=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Verify
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_Toggle_Verify
IF %ParametersCopy.Verify% EQU True (
    SET ParametersCopy.Verify=False
) ELSE (
    SET ParametersCopy.Verify=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Suppress Warnings
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_Toggle_Suppress
IF %ParametersCopy.Suppress% EQU True (
    SET ParametersCopy.Suppress=False
) ELSE (
    SET ParametersCopy.Suppress=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Restart
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_Toggle_Restart
IF %ParametersCopy.Restart% EQU True (
    SET ParametersCopy.Restart=False
) ELSE (
    SET ParametersCopy.Restart=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the entire CopyIntCMDArg variable.  This works by simply taking all of the supported parameters and updates the main holder variable
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_Builder
REM First, clear the entire variable by uninitializing it
SET CopyIntCMDArg=
REM Build it again with the newer changes
IF %ParametersCopy.Decrypt% EQU True (
    SET CopyIntCMDArg=%CopyIntCMDArg%/D 
)

IF %ParametersCopy.Verify% EQU True (
    SET CopyIntCMDArg=%CopyIntCMDArg%/V 
)

IF %ParametersCopy.Suppress% EQU True (
    SET CopyIntCMDArg=%CopyIntCMDArg%/Y 
)

IF %ParametersCopy.Restart% EQU True (
    SET CopyIntCMDArg=%CopyIntCMDArg%/Z 
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: If the user has the intCMD COPY as the primary mass copier, then update the CopyArg parameter.
REM # =============================================================================================
:ControlPanel_intCMDCopyParameterConfiguration_CopyArgUpdate
IF %CopyMethod% EQU COPY (
    SET "CopyArg=%CopyIntCMDArg%"
)
GOTO :EOF