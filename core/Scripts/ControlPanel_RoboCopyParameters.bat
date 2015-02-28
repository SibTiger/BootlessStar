REM =====================================================================
REM Control Panel: Robocopy Behavior
REM ----------------------------
REM This allows the user to change the behavioral of the external command 'Robocopy'.  This section merely adjusts what parameters and switches are to be used when using the command.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: Robocopy [ExtCMD] software Behavior Menu
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration
CALL :DashboardDisplay
ECHO Robocopy Switches and Parameters Configuration
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO This allows the ability for the user to customize the switches that can be utilized when a module copies data using 'ROBOCOPY'
ECHO.
ECHO %Separator%
ECHO [1] Restartable Mode (backup mode if permission failure)
ECHO     Switch: /ZB
ECHO     Current: %ParametersRobocopy.RestartBackup%
ECHO [2] Disallow Deep Paths (exceeding 256 chars)
ECHO     Switch: /256
ECHO     Current: %ParametersRobocopy.RestrictDeepPaths%
ECHO [3] Exclude Junctions Pointers [RECOMMENDED: True]
ECHO     Switch: /XJ
ECHO     Current: %ParametersRobocopy.NoJunctionPoints%
ECHO [4] Verbose Details
ECHO     Switch: /V
ECHO     Current: %ParametersRobocopy.Verbose%
ECHO [5] Display Long Paths
ECHO     Switch: /FP
ECHO     Current: %ParametersRobocopy.FullPath%
ECHO [6] File Sizes are Displayed as Bytes
ECHO     Switch: /BYTES
ECHO     Current: %ParametersRobocopy.BytesFileSize%
ECHO [7] Do Not Display Progress
ECHO     Switch: /NP
ECHO     Current: %ParametersRobocopy.NoProgress%
ECHO [8] Display Estimated Time of Arrival
ECHO     Switch: /ETA
ECHO     Current: %ParametersRobocopy.ETA%
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [MT] Multithreading
ECHO [Retry] Max of Retires
ECHO [Wait] Wait before retry
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_RoboCopyParameterConfiguration_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the users input
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
REM The idea here is to change the initial value and then build the entire RobocopyArg
IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_RestartBackup
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_RestrictDeepPaths
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_NoJunctionPoints
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_Verbose
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_FullPath
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "6" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_BytesFileSize
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "7" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_NoProgress
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF "%STDIN%" EQU "8" (
    CALL :ControlPanel_RoboCopyParameterConfiguration_Toggle_ETA
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF /I "%STDIN%" EQU "Retry" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_RoboCopyParameterConfiguration_Retry
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF /I "%STDIN%" EQU "Wait" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_RoboCopyParameterConfiguration_Wait
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
IF /I "%STDIN%" EQU "MT" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_RoboCopyParameterConfiguration_Multithreading
    CALL :ControlPanel_RoboCopyParameterConfiguration_Builder
    CALL :ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_RoboCopyParameterConfiguration
)
CALL :BadInput& GOTO :ControlPanel_RoboCopyParameterConfiguration



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Network Restartable Mode (use Backup Mode if permission failure)
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_RestartBackup
IF %ParametersRobocopy.RestartBackup% EQU True (
    SET ParametersRobocopy.RestartBackup=False
) ELSE (
    SET ParametersRobocopy.RestartBackup=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable deep paths
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_RestrictDeepPaths
IF %ParametersRobocopy.RestrictDeepPaths% EQU True (
    SET ParametersRobocopy.RestrictDeepPaths=False
) ELSE (
    SET ParametersRobocopy.RestrictDeepPaths=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Follow Junction Pointers (RECOMMEND TO DISABLE THIS!)
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_NoJunctionPoints
IF %ParametersRobocopy.NoJunctionPoints% EQU True (
    SET ParametersRobocopy.NoJunctionPoints=False
) ELSE (
    SET ParametersRobocopy.NoJunctionPoints=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable Verbose messages
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_Verbose
IF %ParametersRobocopy.Verbose% EQU True (
    SET ParametersRobocopy.Verbose=False
) ELSE (
    SET ParametersRobocopy.Verbose=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable displaying long file paths
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_FullPath
IF %ParametersRobocopy.FullPath% EQU True (
    SET ParametersRobocopy.FullPath=False
) ELSE (
    SET ParametersRobocopy.FullPath=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable displaying filesize in bytes
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_BytesFileSize
IF %ParametersRobocopy.BytesFileSize% EQU True (
    SET ParametersRobocopy.BytesFileSize=False
) ELSE (
    SET ParametersRobocopy.BytesFileSize=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable displaying Display Progress
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_NoProgress
IF %ParametersRobocopy.NoProgress% EQU True (
    SET ParametersRobocopy.NoProgress=False
) ELSE (
    SET ParametersRobocopy.NoProgress=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function toggles the value to enable or disable displaying Estimated Time of Arrival
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Toggle_ETA
IF %ParametersRobocopy.ETA% EQU True (
    SET ParametersRobocopy.ETA=False
) ELSE (
    SET ParametersRobocopy.ETA=True
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Update the entire RobocopyArg variable.  This works by simply taking all of the supported parameters and updates the main holder variable
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_Builder
REM First, clear the entire variable by uninitializing it
SET RobocopyArg=
REM Build it again with the newer changes
IF %ParametersRobocopy.RestartBackup% EQU True (
    SET RobocopyArg=%RobocopyArg%/ZB 
)

IF %ParametersRobocopy.RestrictDeepPaths% EQU True (
    SET RobocopyArg=%RobocopyArg%/256 
)

IF %ParametersRobocopy.NoJunctionPoints% EQU True (
    SET RobocopyArg=%RobocopyArg%/XJ 
)

IF %ParametersRobocopy.Verbose% EQU True (
    SET RobocopyArg=%RobocopyArg%/V 
)

IF %ParametersRobocopy.FullPath% EQU True (
    SET RobocopyArg=%RobocopyArg%/FP 
)

IF %ParametersRobocopy.BytesFileSize% EQU True (
    SET RobocopyArg=%RobocopyArg%/BYTES 
)

IF %ParametersRobocopy.NoProgress% EQU True (
    SET RobocopyArg=%RobocopyArg%/NP 
)

IF %ParametersRobocopy.ETA% EQU True (
    SET RobocopyArg=%RobocopyArg%/ETA 
)

REM Statics; always true but values changes
REM ----
REM Maximum Number of Retries for each individual file failure
SET RobocopyArg=%RobocopyArg%/R:%ParametersRobocopy.Retry% 
REM Maximum Numer of Retry Waits
SET RobocopyArg=%RobocopyArg%/W:%ParametersRobocopy.Wait% 
REM Multithreading
SET RobocopyArg=%RobocopyArg%/MT:%ParametersRobocopy.Multithread% 
REM ----
GOTO :EOF



REM # =============================================================================================
REM # Documentation: If the user has the extCMD Robocopy as the primary mass copier, then update the CopyArg parameter.
REM # =============================================================================================
:ControlPanel_RoboCopyParameterConfiguration_CopyArgUpdate
IF %CopyMethod% EQU ROBOCOPY (
    SET "CopyArg=%RobocopyArg%"
)
GOTO :EOF