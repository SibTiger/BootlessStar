REM =====================================================================
REM Control Panel: Directory Setup
REM ----------------------------
REM This section allows the user to customize the directory or file location of resources that is supported in the program.  This will allow compatible modules to easily take advantage of such resources that can be detect and supported without having to add more redundancy code or making it inconvenient to the user.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Main directory menu
REM # =============================================================================================
:ControlPanel_DirectorySetup
CALL :DashboardDisplay
REM Check see if the resources exists
CALL :EnvironmentSetup_Switch CheckExternalResources
ECHO Directory Setup
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO In order to compile other projects, there is in need of necessary prerequisites.  Not all of the listed tools maybe required, to be sure what you need in order to compile a project - refer to documentation.
ECHO.
ECHO Choose the following to modify:
ECHO %Separator%
ECHO [1] Microsoft Visual Studio Category
ECHO [2] Microsoft HTML Workshop
ECHO      Detected: [ %Detect_MSHTMLWorkShop% ]
ECHO [3] MinGW
ECHO      Detected: [ %Detect_MinGW% ]
ECHO [4] 7Zip
ECHO      Detected: [ %Detect_7Zip% ]
ECHO [5] Inno Setup
ECHO      Detected: [ %Detect_InnoSetup% ]
ECHO [6] Python v3.x
ECHO      Detected: [ %Detect_Python3% ]
ECHO [7] Python v2.7.x
ECHO      Detected: [ %Detect_Python2% ]
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_DirectorySetup_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:ControlPanel_DirectorySetup_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_MSVisualStudio
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "2" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "HTML Workshop" "%PathMSHTMLWorkShop%" "Microsoft HTML Workshop path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "3" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "MinGW" "%PathMinGW%" "MinGW path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "4" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Seven Zip" "%Path7Zip%" "Seven Zip path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "5" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Inno Installer" "%PathInnoSetup%" "Inno Installer path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "6" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Python3" "%PathPython3%" "Python v3 path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
IF "%STDIN%" EQU "7" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Python2" "%PathPython2%" "Python v2.7.x path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup
)
CALL :BadInput& GOTO :ControlPanel_DirectorySetup



REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Microsoft Visual Studio Directory setting menu
REM # =============================================================================================
:ControlPanel_DirectorySetup_MSVisualStudio
CALL :DashboardDisplay
REM Check to see if the Microsoft Visual Studio products can be detected.
CALL :EnvironmentSetup_Switch CheckExternalResources
ECHO Directories: Microsoft Visual Studio Versions
ECHO %SeparatorSmall%
ECHO [1] Visual Studio 2005
ECHO      Detected: [ %Detect_MSVS80COMMTOOLS% ]
ECHO [2] Visual Studio 2008
ECHO      Detected: [ %Detect_MSVS90COMMTOOLS% ]
ECHO [3] Visual Studio 2010
ECHO      Detected: [ %Detect_MSVS100COMMTOOLS% ]
ECHO [4] Visual Studio 2012
ECHO      Detected: [ %Detect_MSVS110COMMTOOLS% ]
ECHO [5] Visual Studio 2013
ECHO      Detected: [ %Detect_MSVS120COMMTOOLS% ]
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_DirectorySetup_MSVisualStudio_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:ControlPanel_DirectorySetup_MSVisualStudio_UserInput
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Visual Studio 2005" "%PathMSVS2005%" "Microsoft Visual Studio 2005 [Common Tools] path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_MSVisualStudio
)
IF "%STDIN%" EQU "2" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Visual Studio 2008" "%PathMSVS2008%" "Microsoft Visual Studio 2008 [Common Tools] path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_MSVisualStudio
)
IF "%STDIN%" EQU "3" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Visual Studio 2010" "%PathMSVS2010%" "Microsoft Visual Studio 2010 [Common Tools] path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_MSVisualStudio
)
IF "%STDIN%" EQU "4" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Visual Studio 2012" "%PathMSVS2012%" "Microsoft Visual Studio 2012 [Common Tools] path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_MSVisualStudio
)
IF "%STDIN%" EQU "5" (
    CALL :ClearBuffer 1
    CALL :ControlPanel_DirectorySetup_ChangePathCommon "Visual Studio 2013" "%PathMSVS2013%" "Microsoft Visual Studio 2013 [Common Tools] path"
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_MSVisualStudio
)
CALL :BadInput& GOTO :ControlPanel_DirectorySetup_MSVisualStudio



REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================



REM # =============================================================================================
REM # Parameters: [{string} ProductName] [{string} FilePath] [{string} LongString] 
REM # Documentation: When inputting a new file location, this function is going to be called.  This will manage all of the external resource file locations and will set the file path - only if the detection is able to locate the file or directory.
REM # =============================================================================================
:ControlPanel_DirectorySetup_ChangePathCommon
CALL :DashboardDisplay
REM Does the file location exists?
CALL :ControlPanel_DirectorySetup_Finder_Status "%~2"
CALL :ControlPanel_DirectorySetup_ChangePathCommon_FixUninitializedVariables "%~2"
ECHO Modifying: %~3
ECHO %SeparatorSmall%
ECHO Current location:
ECHO    %ProcessVarB%
ECHO Detection Status:
ECHO    %ProcessVarA%
ECHO.
CALL :ControlPanel_DirectorySetup_CommonSetupSubMenuDisplay
CALL :UserInput
REM Inspect the users input; does the file or directory exists?
CALL :ControlPanel_DirectorySetup_Finder "%~1" "%STDIN%"
REM If the user wishes to abort
IF %ERRORLEVEL% EQU 2 GOTO :EOF
IF %ERRORLEVEL% EQU 1 (
    CALL :ClearBuffer 1
    GOTO :ControlPanel_DirectorySetup_ChangePathCommon
)
    IF "%~1" EQU "Visual Studio 2005" SET "PathMSVS2005=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Visual Studio 2008" SET "PathMSVS2008=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Visual Studio 2010" SET "PathMSVS2010=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Visual Studio 2012" SET "PathMSVS2012=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Visual Studio 2013" SET "PathMSVS2013=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "HTML Workshop" SET "PathMSHTMLWorkShop=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "MinGW" SET "PathMinGW=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Seven Zip" SET "Path7Zip=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Inno Installer" SET "PathInnoSetup=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Python3" SET "PathPython3=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF
    IF "%~1" EQU "Python2" SET "PathPython2=%STDIN%"& CALL :ClearBuffer 1& GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} FilePath]
REM # Documentation: If the variable is uninitialized during the initialization phase (such as not having Microsoft Visual Studio 2005 or it's environment variables), then properly display the result on the screen instead of the standalone ECHO message.
REM # =============================================================================================
:ControlPanel_DirectorySetup_ChangePathCommon_FixUninitializedVariables
REM Cache the value so we can determine if it was ever defined at all
SET "ProcessVarB=%~1"
REM Determine how the output is going to be on the screen
IF NOT DEFINED ProcessVarB (
    SET ProcessVarB=!ERROR!
)
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} ProductName] [{string} FilePath]
REM # Documentation: Inspect the users input; if the directory or file exists - then report back a success, if the file or directory does not exist - report an error.  Also manage if the user wishes to cancel or revert a setting.
REM # =============================================================================================
:ControlPanel_DirectorySetup_Finder
REM If incase the user wishes to abort
IF /I "%STDIN%" EQU "X" CALL :ClearBuffer 1& EXIT /B 2
IF /I "%STDIN%" EQU "Cancel" CALL :ClearBuffer 1& EXIT /B 2
IF /I "%STDIN%" EQU "Exit" CALL :ClearBuffer 1& EXIT /B 2
REM Allow the user to restore a variable value target to its default setting.
IF /I "%STDIN%" EQU "Restore" CALL :ControlPanel_DirectorySetup_RestoreDefauts "%~1"& EXIT /B 2

REM The user must specify the _exact_ file.
REM %1 = Program Name or File Name
REM %2 = Program Path Variable or STDIN
IF EXIST "%STDIN%" (
    EXIT /B 0
) ELSE (
    ECHO.
    ECHO !ERR: Could not find the file or program ^'%~1^'
    ECHO       at location: %~2
    PAUSE
    EXIT /B 1
)



REM # =============================================================================================
REM # Parameters: [{string} ProductName]
REM # Documentation: This function will restore the requested target value; this specifically will call the Environment Setup to properly restore the value.
REM # =============================================================================================
:ControlPanel_DirectorySetup_RestoreDefauts
CALL :EnvironmentSetup_Switch PathRestore "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} FilePath]
REM # Documentation: This function checks to make sure that the target actually exists.  This will only change the working variable's value that will be used to print the detection status.
REM # =============================================================================================
:ControlPanel_DirectorySetup_Finder_Status
IF EXIST "%~1" (
    SET ProcessVarA=Found!
    GOTO :EOF
) ELSE (
    SET ProcessVarA=Not Found!
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function merely contains the common information that is used when inputting a new file location.
REM # =============================================================================================
:ControlPanel_DirectorySetup_CommonSetupSubMenuDisplay
ECHO Other Options:
ECHO %SeparatorSmall%
ECHO [Cancel] [Restore]
ECHO.
ECHO  Notes:
ECHO   + Do NOT use quotes
ECHO       For Example, do _NOT_: "C:\Users\Admin\Travra.ps"
ECHO                              ^^                        ^^
ECHO   + Use Absolute Path
ECHO       For Example: C:^\Program Files\RequestedProgram.exe
ECHO   + Include specific filename including file extension
ECHO       For Example: ExecutableFile.exe or MyShellScript.sh
ECHO                                   ^^                   ^^
ECHO.
ECHO Enter new direct location and specific filename
GOTO :EOF