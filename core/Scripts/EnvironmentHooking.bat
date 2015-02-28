REM =====================================================================
REM Environment Hooking
REM ----------------------------
REM Hook the client's working directory to be exactly the same as the program's absolute path.
REM This entire feature is necessary if in case the program is executed with Root access (Administrator access) which the user's working directory will be exactly: %SystemRoot%\system32.  Additionally, for those that use the terminal on Windows and invoke the program from a different working directory that is not the program's path.  In order for this program to work efficiently, we simply must alter the users current working directory to match with the program's working directory.  Once the program has be terminated [safely], the previous working directory is restored -- The user will never know that their working directory has been changed while using this program.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function manages the entire 'Environment Hooking' functionality.
REM # =============================================================================================
:ClientWorkingDirectorySetup_Driver
REM Cache the directory locations for processing
CALL :ClientWorkingDirectorySetup_SetupPathVariables
REM Compare the working dir. and program dir.
CALL :ClientWorkingDirectorySetup_ComparePaths
IF %ERRORLEVEL% EQU 0 (
    REM Hooking passed
    GOTO :ClientWorkingDirectorySetup_Successful
)
REM From here, there was a mismatch.
REM -----
REM when we need update the users WD, this driver is going to manage the entire procedure.
CALL :ClientWorkingDirectorySetup_ChangeUserWD
IF %ERRORLEVEL% EQU 1 (
    EXIT /B 1
)
CALL :ClientWorkingDirectorySetup_ComparePaths
IF %ERRORLEVEL% EQU 0 (
    REM Hooking passed
    GOTO :ClientWorkingDirectorySetup_Successful
) ELSE (
    REM Kill the program
    CALL :ClientWorkingDirectorySetup_Failed
    EXIT /B 2
)



REM # =============================================================================================
REM # Documentation: Cache the directory locations into variables that will be used for processing.
REM # =============================================================================================
:ClientWorkingDirectorySetup_SetupPathVariables
REM cache the current Program Directory.
SET Hook_ProgramDir=%~dp0
REM This caches the filename of the program.
SET ProgramFileName=%~n0
REM Set the users current working directory to memory, regardless if necessary.
SET HookingUserWDCache=%CD%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display the stored contents on the terminal when a serious error occurs.  Ideally, this function is meant to be displayed before the program completely terminates due to a failed hooking operation.
REM # =============================================================================================
:ClientWorkingDirectorySetup_DisplayPaths
ECHO Current Directory Path Setup
ECHO ----------------------------------------
ECHO %ProgramFileName% Directory is:
ECHO   %Hook_ProgramDir%
ECHO %UserName%'s Working Directory is:
ECHO   %CD%\
ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Compare the users working directory against the program's directory.
REM # =============================================================================================
:ClientWorkingDirectorySetup_ComparePaths
ECHO ^> Comparing the user's working directory with the program's directory...
REM Do we need to change the users working directory?
IF "%CD%\" EQU "%Hook_ProgramDir%" (
    REM Match
    ECHO The user's working directory matches with the program's working directory!
    EXIT /B 0
) ELSE (
    REM Mismatch
    ECHO !ERR: The user's working directory does not match with the program's directory!
    EXIT /B 1
)



REM # =============================================================================================
REM # Documentation: Change the user's working directory to match with the program's directory.
REM # =============================================================================================
:ClientWorkingDirectorySetup_ChangeUserWD
ECHO ^> Changing the user's working directory...
CD /D "%Hook_ProgramDir%" || EXIT /B 1
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This function will notify the parent function that this operation was successful.
REM # =============================================================================================
:ClientWorkingDirectorySetup_Successful
SET Hook_Operation=1
ECHO Operation Successful!
EXIT /B 0



REM # =============================================================================================
REM # Documentation: This function will notify the parent function that this operation failed.
REM # =============================================================================================
:ClientWorkingDirectorySetup_Failed
SET Hook_Operation=0
GOTO :EOF