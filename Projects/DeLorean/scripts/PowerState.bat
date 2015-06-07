REM =====================================================================
REM Power State
REM ----------------------------
REM This section will manage the Power State.  When the initial operation has been successfully completed, the program can be able
REM     to send a signal to the Operating System to enter into a energy saving state that uses - obviously - less power.
REM     This is completely changeable by the user within the program's control panel; this has no effect to the Operating System's standard power settings.
REM =====================================================================



REM # =============================================================================================
REM # Documentation: This function will check the user's power state settings and execute the member function that issues the execution.
REM # =============================================================================================
:PowerState
REM Disabled
IF "%UserConfig.PowerState%" EQU "0" (
    CALL :PowerState_DoNothing
    GOTO :EOF
)

REM Suspend
IF "%UserConfig.PowerState%" EQU "1" (
    CALL :PowerState_SignalSuspend
    GOTO :EOF
)

REM Hibernation
IF "%UserConfig.PowerState%" EQU "2" (
    CALL :PowerState_SignalHibernation
    GOTO :EOF
)

REM Shutdown
IF "%UserConfig.PowerState%" EQU "3" (
    CALL :PowerState_SignalShutdown
    GOTO :EOF
) ELSE (
    REM Bad value; unknown Power State
    CALL :PowerState_BadValue
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: When called, this will manage the PowerState when set to 'disabled'
REM # =============================================================================================
:PowerState_DoNothing
CALL :PowerState_DisplayMessage "disabled; skipping" 0
GOTO :EOF



REM # =============================================================================================
REM # Documentation: When called, this will manage the PowerState when set to 'Suspend'
REM # =============================================================================================
:PowerState_SignalSuspend
CALL :PowerState_DisplayMessage "Suspend" 1
REM ----
Rundll32.exe Powrprof.dll,SetSuspendState Sleep
REM ----
GOTO :EOF



REM # =============================================================================================
REM # Documentation: When called, this will manage the PowerState when set to 'Hibernation'
REM # =============================================================================================
:PowerState_SignalHibernation
CALL :PowerState_DisplayMessage "Hibernation" 1
REM ----
SHUTDOWN /f /h
REM ----
GOTO :EOF



REM # =============================================================================================
REM # Documentation: When called, this will manage the PowerState when set to 'Shutdown'
REM # =============================================================================================
:PowerState_SignalShutdown
CALL :PowerState_DisplayMessage "Shutdown" 1
CALL :PowerState_AbortSignal
REM ----
SHUTDOWN /f /t %UserConfig.PowerStateGraceTime% /s
REM ----
GOTO :EOF



REM # =============================================================================================
REM # Documentation: When called, this will only notify the user that the value for the Power State is unknown.
REM # =============================================================================================
:PowerState_BadValue
CALL :PowerState_DisplayMessage "UNKNOWN_VALUE" 0
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} PowerState Mode]
REM # Documentation: This function will display (and even log) what power state is being issued.
REM # =============================================================================================
:PowerState_DisplayMessage
REM Display that we're starting the backup process
SET "DriversNiceTask=Power State: %~1"
CALL :Operation_Display_IncomingTask "%DriversNiceTask%"

REM If the signal is being sent to the OS, tell the user (and or log it)
IF %~2 EQU 1 (
    CALL :Operation_Display_IncomingTaskSubLevel "Sending signal..."
)
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This method will merely output instructions on how to abort the shutdown grace period.
REM # =============================================================================================
:PowerState_AbortSignal
ECHO.
ECHO ABORT THE COUNT-DOWN INSTRUCTIONS
ECHO ---------------------------------------
ECHO.
ECHO Go to Windows PowerShell or Windows Command (use the search on the Windows Start Menu or Start Screen)
ECHO Type the following into the terminal:
ECHO    SHUTDOWN /A
ECHO This command with the 'A' switch will abort the count-down and the system will continue to run as is.
ECHO.
GOTO :EOF