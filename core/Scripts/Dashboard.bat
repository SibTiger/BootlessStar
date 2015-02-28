REM =====================================================================
REM Dashboard
REM ----------------------------
REM The dashboard here is to only highlight important and display what the user needs to know for the program to work correctly.
REM The idea of this dashboard, is to NOT be so verbose or full of details, but only display quick and brief details.
REM This feature - within the core - does not require so much intensive work as there is not write into memory, but only reads.  Turning this feature off will not really help aid the program performance sakes.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: This function is the central point for the Dashboard Viewer tool.
REM # =============================================================================================
:Dashboard
CALL :Dashboard_HeaderBorder
ECHO                  Dashboard Viewer
ECHO Ver: %ProgramVersion%                           %ProgramReleaseDate%
ECHO Preset: %UserConfigurationLoaded%
CALL :Dashboard_FooterBorder
CALL :Dashboard_ExtraLineBreaks
GOTO :EOF



REM # =============================================================================================
REM # Documentation: After displaying the dashboard, this will add a few extra lines.  This will help keep the dashboard's contents from being smashed against other content.
REM # =============================================================================================
:Dashboard_ExtraLineBreaks
ECHO.&ECHO.&ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display the header for the Dashboard Viewer tool
REM # =============================================================================================
:Dashboard_HeaderBorder
ECHO %SeparatorLong%
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Display the footer for the Dashboard Viewer tool
REM # =============================================================================================
:Dashboard_FooterBorder
ECHO %SeparatorLong%
ECHO %SeparatorLong%
GOTO :EOF