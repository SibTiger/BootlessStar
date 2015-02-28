@ECHO OFF
REM This is a small script to determine if the detection works properly within the host system.
GOTO :main



:main
CALL :dotNET1
CALL :dotNET1-1
CALL :dotNET2
CALL :dotNET2_64
CALL :dotNET3
CALL :dotNET3_64
CALL :dotNET3-5
CALL :dotNET3-5_64
CALL :dotNET4
CALL :dotNET4_64
CALL :Exit



:dotNET1
CALL :DisplayResult "v1.0" %Detect_dotNET1%
GOTO :EOF



:dotNET1-1
CALL :DisplayResult "v1.1" %Detect_dotNET1.1%
GOTO :EOF



:dotNET2
CALL :DisplayResult "v2.0" %Detect_dotNET2%
GOTO :EOF



:dotNET2_64
CALL :DisplayResult "v2.0 [64]" %Detect_dotNET2-64%
GOTO :EOF



:dotNET3
CALL :DisplayResult "v3.0" %Detect_dotNET3%
GOTO :EOF



:dotNET3_64
CALL :DisplayResult "v3.0 [64]" %Detect_dotNET3-64%
GOTO :EOF



:dotNET3-5
CALL :DisplayResult "v3.5" %Detect_dotNET3.5%
GOTO :EOF



:dotNET3-5_64
CALL :DisplayResult "v3.5 [64]" %Detect_dotNET3.5-64%
GOTO :EOF



:dotNET4
CALL :DisplayResult "v4.0" %Detect_dotNET4%
GOTO :EOF



:dotNET4_64
CALL :DisplayResult "v4.0 [64]" %Detect_dotNET4-64%
GOTO :EOF



:DisplayResult
REM Parameters: (string: version of .NET) (Bool: Detection Result)
ECHO =======================================
ECHO Detection for .NET Framework %~1
CALL :NiceResult %2
ECHO Detected: %NiceResult%
ECHO.
GOTO :EOF



:NiceResult
IF %1 EQU True (
    SET NiceResult=Found!
) ELSE (
    SET NiceResult=Not Found!
)
GOTO :EOF



:Exit
EXIT 0