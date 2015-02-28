REM =====================================================================
REM Host System Compatibility Check
REM ----------------------------
REM Windows 9x\ME batch version will _NOT_ work correctly with this program, and as such - if this program detects that the OS is Windows 9x or Windows ME, the program will terminate.
REM
REM Notes:
REM MS_DOS == Possibly earlier releases before Windows 95, Windows 95, Windows 98, Windows ME
REM Windows_NT == Windows 2000, Windows XP, Windows Vista, Windows 7, Windows 8, Windows 8.1
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function will check the host system's variable [ %OS% - System Variable ] and determine if the host system is compatible with the program.  As a safety precaution, if the OS is not compatible, immediately stop the program from running any further.  However, if the OS is in fact compatible the program, then start the execution process.
REM # =============================================================================================
:IncompatibilityOS_Check
IF "%OS%" EQU "Windows_NT" (
    SET IncompatibleOS=False
    REM Begin the initial program.
    GOTO :Startup_Driver
) ELSE (
    REM MS_DOS or not supported
    REM Host is not compatible
    SET IncompatibleOS=True
    GOTO :Kill
)