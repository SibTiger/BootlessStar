REM =====================================================================
REM Main Compiling Driver
REM ----------------------------
REM This is a simple driver for calling other functions that properly helps to compile the main project.
REM The CompileManager_Driver may seem ugly, but with Batch, readability is a bit - limited....
REM =====================================================================



REM # =============================================================================================
REM # Parameters: [{int} Plugins]
REM # Documentation: This driver will guide the entire compiling procedure.
REM #   Parameters: Plugins: 0=None, 1=Default, 2=All
REM # =============================================================================================
:CompileManager_Driver
CALL :DashboardOrClassicalDisplay

REM Display the header message
CALL :CompileProject_DisplayHeaderMessage

REM Check to make sure that all prerequisites and dependencies are available and ready to be used.  This detection is important, otherwise - everything will be a waste of time if some minor issue occurs.
CALL :CompileProject_CheckResources || GOTO :CompileProject_TerminateWithError


REM ----
REM Update the local working copy to the latest revision
CALL :CompileProject_SVNUpdateProject || GOTO :CompileProject_TerminateWithError


REM ----
REM Find the revision number
CALL :CompileProject_FetchSVNRevisionID || GOTO :CompileProject_TerminateWithError


REM ----
REM Update the project version ID; this is displayed when viewing the 'Help:About' dialog box in the project.
CALL :CompileProject_UpdateInternalProjectVersion || GOTO :CompileProject_TerminateWithError


REM ----
REM Update the file name for the projects output
CALL :CompileProject_GenerateProjectName || GOTO :CompileProject_TerminateWithError


REM ----
REM Load the Visual Studio environment within the session
CALL :CompileProject_MicrosoftVisualStudioEnvironment || GOTO :CompileProject_TerminateWithError


REM ----
REM Compile the core engine of the project.
CALL :CompileProject_CompileCoreEngine || GOTO :CompileProject_TerminateWithError


REM ----
REM Compile the help documentation for the project
CALL :CompileProject_CompileHelpDocumentation || GOTO :CompileProject_TerminateWithError


REM ----
REM Compile the plugins for the project
CALL :CompileProject_CompilePlugins %1 || GOTO :CompileProject_TerminateWithError


REM ----
REM Cleanup the directories
CALL :CompileProject_CleanupCompiledData || GOTO :CompileProject_TerminateWithError


REM ----
REM Fetch the revision log history
CALL :CompileProject_FetchSVNRevisionLogHistory || GOTO :CompileProject_TerminateWithError


REM ----
REM Record the revision to the ASCII file
CALL :CompileProject_SVNUpdateCachedRevision || GOTO :CompileProject_TerminateWithError


REM ----
REM Move the compiled project to the local directory
CALL :CompileProject_ProjectLocalDirectory || GOTO :CompileProject_TerminateWithError


REM ----
REM Place the compiled data in an archive data file
CALL :CompileProject_7ZipCompactData || GOTO :CompileProject_TerminateWithError


REM ----
REM Verify that contents within the archive
CALL :CompileProject_7ZipVerifyData || GOTO :CompileProject_TerminateWithError


REM ----
REM Generate a setup build using Inno
CALL :CompileProject_GenerateSetup || GOTO :CompileProject_TerminateWithError


REM ----
REM Cleanup the local working directory
CALL :CompileProject_CleanupWorkingCopy || GOTO :CompileProject_TerminateWithError


REM ----
REM Pop-up windows of the new builds
CALL :CompileProject_PopupWindowsExplorer || GOTO :CompileProject_TerminateWithError


REM ----
GOTO :CompileProject_TerminateSuccessfully