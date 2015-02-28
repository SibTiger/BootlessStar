REM =====================================================================
REM Clean-up Local Directories
REM ----------------------------
REM This functionality allows the user to thrash all of the data that is stored in the local directories.
REM This helps the user to remove all of the abundant superfluous data that has accumulated within the user's secondary storage.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Cleanup menu
REM # =============================================================================================
:Cleanup_Menu
CALL :DashboardOrClassicalDisplay
CALL :Cleanup_Menu_Warning
ECHO Clean-up Local Directories Menu
ECHO %Separator%
ECHO.
ECHO Clean-up the following directories:
ECHO.
ECHO [1] Log files
ECHO [2] Compressed files
ECHO [3] Setup files
ECHO [4] Regular build files
ECHO [A] All Local Directories
ECHO [X] Exit
CALL :UserInput
CALL :Cleanup_UserInput



:Cleanup_UserInput
REM Check the parameters and determine how to execute.
IF "%STDIN%" EQU "1" GOTO :Cleanup_Choice_LogFiles
IF "%STDIN%" EQU "2" GOTO :Cleanup_Choice_CompressedFiles
IF "%STDIN%" EQU "3" GOTO :Cleanup_Choice_SetupFiles
IF "%STDIN%" EQU "4" GOTO :Cleanup_Choice_RegBuildFiles
IF /I "%STDIN%" EQU "A" GOTO :Cleanup_Choice_Everything
IF /I "%STDIN%" EQU "X" GOTO :EOF
CALL :BadInput& GOTO :Cleanup_Menu



:Cleanup_Menu_Warning
ECHO ^<?^>       WARNING       ^<?^>
ECHO %SeparatorLong%
ECHO.
ECHO Clean-up will effectively thrash the data that is located with the directories or just specific directories as requested by the user.  This feature will help the end-user to automatically flush all of the superfluous data that might have accumulated over time, which will allow the user to gain back some freespace (from their secondary storage devices).  Please note that files that are deleted by this program are not eligible for quick recovery.
ECHO.&ECHO.
GOTO :EOF



:Cleanup_Choice_LogFiles
REM Remove all of the log files
CALL :Cleanup_Thrash_LogFiles
CALL :ClearBuffer
GOTO :Cleanup_Menu



:Cleanup_Choice_CompressedFiles
REM Remove all of the compressed files
CALL :Cleanup_Thrash_CompressedFiles
CALL :ClearBuffer
GOTO :Cleanup_Menu



:Cleanup_Choice_SetupFiles
REM Remove all of the setup files
CALL :Cleanup_Thrash_SetupFiles
CALL :ClearBuffer
GOTO :Cleanup_Menu



:Cleanup_Choice_RegBuildFiles
REM Remove all of the regular build files
CALL :Cleanup_Thrash_RegBuildFiles
CALL :ClearBuffer
GOTO :Cleanup_Menu



:Cleanup_Choice_Everything
REM Remove all of the files
CALL :Cleanup_Thrash_LogFiles
CALL :Cleanup_Thrash_CompressedFiles
CALL :Cleanup_Thrash_SetupFiles
CALL :Cleanup_Thrash_RegBuildFiles
CALL :Cleanup_Thrash_CachedFiles
CALL :ClearBuffer
GOTO :Cleanup_Menu



REM # =============================================================================================
REM # Documentation: Thrash all of the log files
REM # =============================================================================================
:Cleanup_Thrash_LogFiles
ECHO Thrashing log files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Logs%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the archive files
REM # =============================================================================================
:Cleanup_Thrash_CompressedFiles
ECHO Thrashing compressed files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Archives%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the setup files
REM # =============================================================================================
:Cleanup_Thrash_SetupFiles
ECHO Thrashing setup files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Setup%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the regular compressed files
REM # =============================================================================================
:Cleanup_Thrash_RegBuildFiles
ECHO Thrashing Regular build files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Builds%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Thrash all of the temporary files
REM # =============================================================================================
:Cleanup_Thrash_CachedFiles
ECHO Thrashing cached files. . .
CALL :Cleanup_Thrash_DelCall "%LocalDirectory.Temp%"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This will display an error if incase the local directory files could not successfully expunged.
REM # =============================================================================================
:Cleanup_Thrash_Error
ECHO ^<!^>       ERROR       ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO Could not successfully thrash all of the files!
ECHO.
PAUSE
ECHO.&ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will allow the user to thrash a collection of files as requested.
REM # Parameters: [{string}Directory]
REM # =============================================================================================
:Cleanup_Thrash_DelCall
REM Expunge all data from the directories and subdirectories
DEL /F /Q /S "%~1\*.*" > NUL || CALL :Cleanup_Thrash_Error
REM Expunge all of the directories
FOR /D %%i IN ("%~1\*") DO RMDIR /Q /S "%%i" > NUL || CALL :Cleanup_Thrash_Error
GOTO :EOF