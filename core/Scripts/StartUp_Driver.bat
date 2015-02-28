REM =====================================================================
REM Startup Driver
REM ----------------------------
REM When starting the program, this section will help aid the program to start up correctly and properly set the environment before allowing the user to take control.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Startup procedure function; this will help guide the program to startup correctly.
REM # =============================================================================================
:Startup_Driver
REM Change the users working directory, if necessary.
CALL :ClientWorkingDirectorySetup_Driver
IF %ERRORLEVEL% GEQ 1 (GOTO :Startup_ManageErrHook)
REM ---- ---- ----
REM Pass through the Environment setup
CALL :EnvironmentSetup_Switch StartUp
REM ---- ---- ----
CALL :ClearBuffer 1
GOTO :MainScreen



REM # =============================================================================================
REM # Documentation: When the Environment Hooking reaches an error, this function will call the 'Kill' function.
REM # =============================================================================================
:Startup_ManageErrHook
IF %ErrorLevel% EQU 1 CALL :Kill Hook_Operation ExtCMD
IF %ErrorLevel% EQU 2 CALL :Kill Hook_Operation WDFailure