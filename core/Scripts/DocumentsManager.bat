REM =====================================================================
REM Document Viewer
REM ----------------------------
REM Document Viewer allows the user to open simple text files that is located in the documents directory [ "%DirDocuments%" variable ] and display the contents right in the terminal.
REM This feature by itself is limited and most likely is least used, but it is here for those that may need it.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function checks to make sure that the document directory exists.  If the directory does not exist, then simply create it in the filesystem.
REM # =============================================================================================
:DocumentsDirectoryInspect
IF NOT EXIST "%DirDocuments%" MKDIR "%DirDocuments%" || ECHO !ERR_CRIT!: Could not create directory [ %DirDocuments% ] within the local filesystem!
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function will scan the documents directory and output all of the contents that end with '.txt' as the _whole_ filename.
REM # =============================================================================================
:DocumentsDirectoryViewer
DIR /B "%DirDocuments%" | FINDSTR /E /I ".txt" || ECHO !ERR: Could not find the directory!&
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} ASCIIFile]
REM # Documentation: Display the text file that the user requested.
REM # =============================================================================================
:DocumentViewer_Reader
MORE /E "%~1"
GOTO :EOF



REM # =============================================================================================
REM # Documentation: This function displays the document viewer menu.  This will also do a preview of what files where found within the document directory.
REM # =============================================================================================
:Documents
CALL :DashboardDisplay
CALL :DocumentsDirectoryInspect
ECHO Documents Folder
ECHO.
ECHO Document Directory: %DirDocuments%
ECHO %SeparatorLong%
REM Display a preview of what files were found within the document directory.
CALL :DocumentsDirectoryViewer
ECHO %SeparatorLong%
ECHO.&ECHO.
ECHO Other Options:
ECHO %SeparatorSmall%
ECHO [R] Refresh the list
ECHO [X] Cancel
ECHO %Separator%
ECHO.
ECHO Enter a document filename:
CALL :UserInput
GOTO :Documents_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input and determine wither the document exists or if the user chooses another option.
REM # =============================================================================================
:Documents_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF /I "%STDIN%" EQU "Exit" GOTO :EOF
IF /I "%STDIN%" EQU "R" (
    CALL :ClearBuffer 1
    GOTO :Documents
)
IF /I "%STDIN%" EQU "Refresh" (
    CALL :ClearBuffer 1
    GOTO :Documents
)

IF /I EXIST "%DirDocuments%\%STDIN%" CALL :DocumentViewer 0& GOTO :Documents
IF /I EXIST "%DirDocuments%\%STDIN%.txt" CALL :DocumentViewer 1& GOTO :Documents

ECHO Filename could not be found!
PAUSE
CALL :ClearBuffer 1
GOTO :Documents



REM # =============================================================================================
REM # Parameters: [{Int} IncludeFileExtension]
REM # Documentation: Prepare to display the ascii file.
REM # =============================================================================================
:DocumentViewer
IF %1 EQU 1 SET "STDIN=%STDIN%.txt"
CALL :ClearBuffer 0
CALL :DocumentViewer_Body "%STDIN%" "%DirDocuments%\%STDIN%"
CALL :ClearBuffer 1
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{String} FileName] [{String} FullPathFileName]
REM # Documentation: Display the Document Viewer outlook and call the function to display the actual text file within the terminal.
REM # =============================================================================================
:DocumentViewer_Body
ECHO Opening file named '%~1'...
ECHO.
ECHO %SeparatorLong%
ECHO.
CALL :DocumentViewer_Reader "%~2"
ECHO.
ECHO %SeparatorLong%
ECHO.
ECHO Reached end of file marker from '%~1'!
PAUSE > NUL
GOTO :EOF