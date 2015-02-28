REM =====================================================================
REM Control Panel: 7Zip Generalized Settings
REM ----------------------------
REM Within this section houses all of the 7Zip settings.
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_7Zip_Password_Translator
IF "%SevZipKey%" EQU "" (
    SET ProcessVarA=Not Set!
    GOTO :EOF
) ELSE (
    SET ProcessVarA=Set!
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function is the main password setting menu.
REM # =============================================================================================
:ControlPanel_7Zip_Password
CALL :DashboardDisplay
REM Translate the value to a nicer value
CALL :ControlPanel_7Zip_Password_Translator
ECHO 7Zip Password Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO This allows the user to setup a password key for an archive file.
ECHO.
ECHO Password is currently: %ProcessVarA%
ECHO %Separator%
ECHO [Set] Change key
ECHO [Cancel]
CALL :UserInput
GOTO :ControlPanel_7Zip_Password_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input
REM # =============================================================================================
:ControlPanel_7Zip_Password_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF

IF /I "%STDIN%" EQU "Set" (
    REM Set a new key
    CALL :ControlPanel_7Zip_Password_Manager
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Password
)
CALL :BadInput& GOTO :ControlPanel_7Zip_Password



REM # =============================================================================================
REM # Documentation: Manage the entire password creation procedure process.
REM # =============================================================================================
:ControlPanel_7Zip_Password_Manager
REM Clear the STDIN variable
CALL :ClearSTDIN
REM Fetch the initial key first
CALL :ControlPanel_7Zip_Password_Prompt NewKey
CALL :ControlPanel_7Zip_Password_ManageInput Key
    IF %ERRORLEVEL% GTR 0 GOTO :EOF
REM Clear the STDIN variable
CALL :ClearSTDIN
REM Fetch the confirmation key
CALL :ControlPanel_7Zip_Password_Prompt 1
CALL :ControlPanel_7Zip_Password_ManageInput Confirm
    IF %ERRORLEVEL% GTR 0 GOTO :EOF
REM Clear the STDIN variable
CALL :ClearSTDIN
CALL :ControlPanel_7Zip_Password_CheckInput
REM Clear the working variables that held the key
CALL :ControlPanel_7Zip_Password_ThrashWorkingVariables
GOTO :EOF



REM # =============================================================================================
REM # Parameters: [{string} ModeType]
REM # Documentation: Prompt the user to enter the password.
REM # =============================================================================================
:ControlPanel_7Zip_Password_Prompt
ECHO.
IF %1 EQU NewKey (
    REM Create a new key into memory.
    ECHO Enter password:
    CALL :UserInput
    GOTO :EOF
) ELSE (
    REM Confirm that the key was entered successfully.
    ECHO Confirm password:
    CALL :UserInput
    GOTO :EOF
)



REM # =============================================================================================
REM # Parameters: [{string} ModeType]
REM # Documentation: Store the input into the temporary working variables.
REM # =============================================================================================
:ControlPanel_7Zip_Password_ManageInput
IF /I "%STDIN%" EQU "Cancel" EXIT /B 1

IF %1 EQU Key (
    SET "ProcessVarA=%STDIN%"
    EXIT /B 0
) ELSE (
    SET "ProcessVarB=%STDIN%"
    EXIT /B 0
)



REM # =============================================================================================
REM # Documentation: This function checks the two passwords (that were temporarily stored in the working variables) to be sure that they exactly match, this is case sensitive!
REM # =============================================================================================
:ControlPanel_7Zip_Password_CheckInput
REM Compare the two inputs
IF "%ProcessVarA%" EQU "%ProcessVarB%" (
    CALL :ControlPanel_7Zip_Password_Result 0
    GOTO :EOF
) ELSE (
    CALL :ControlPanel_7Zip_Password_Result 1
    GOTO :EOF
)



REM # =============================================================================================
REM # Parameters: [{bool} Status]
REM # Documentation: This function will set the new key into the SevZipKey variable - if there was a match (determined by the parameter).  If the key did not match, then print an error.
REM # =============================================================================================
:ControlPanel_7Zip_Password_Result
IF %1 EQU 0 (
    REM Key was successfully set
    SET "SevZipKey=%ProcessVarA%"
    GOTO :EOF
) ELSE (
    ECHO !ERR: Mismatch key!
    PAUSE
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function will thrash the working variables that held the password that was inputted by the user.
REM # =============================================================================================
:ControlPanel_7Zip_Password_ThrashWorkingVariables
REM Uninitialize them
SET ProcessVarA=
SET ProcessVarB=
GOTO :EOF



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Archive Format menu
REM # =============================================================================================
:ControlPanel_7Zip_ArchiveFormat
CALL :DashboardDisplay
ECHO 7Zip Archive Format Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When creating an archive file, 7zip software allows the user to utilize different formats.  These formats differ in compression and general uses, though the most commonly used is Zip and 7Z.
ECHO.
ECHO Default Value: 7Z
ECHO Archive Format is currently: %SevZipArchiveFormat%
ECHO %Separator%
ECHO [1] Zip
ECHO [2] GZip
ECHO [3] BZip2
ECHO [4] 7Z
ECHO [5] XZ
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_ArchiveFormat_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_ArchiveFormat_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_ArchiveFormat_Switch Zip
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_ArchiveFormat
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_ArchiveFormat_Switch GZip
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_ArchiveFormat
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_7Zip_ArchiveFormat_Switch BZip2
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_ArchiveFormat
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_7Zip_ArchiveFormat_Switch SevenZip
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_ArchiveFormat
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_7Zip_ArchiveFormat_Switch XZ
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_ArchiveFormat
)
CALL :BadInput& GOTO :ControlPanel_7Zip_ArchiveFormat



REM # =============================================================================================
REM # Parameters: [{String} ArchiveType]
REM # Documentation: Set the primary archive format and file extension.
REM # =============================================================================================
:ControlPanel_7Zip_ArchiveFormat_Switch
IF %1 EQU Zip (
    SET SevZipArchiveFormat=Zip
    SET SevZipFileExtension=zip
    GOTO :EOF
)
IF %1 EQU GZip (
    SET SevZipArchiveFormat=GZip
    SET SevZipFileExtension=gz
    GOTO :EOF
)
IF %1 EQU BZip2 (
    SET SevZipArchiveFormat=BZip2
    SET SevZipFileExtension=bz2
    GOTO :EOF
)
IF %1 EQU SevenZip (
    SET SevZipArchiveFormat=7z
    SET SevZipFileExtension=7z
    GOTO :EOF
)
IF %1 EQU XZ (
    SET SevZipArchiveFormat=XZ
    SET SevZipFileExtension=xz
    GOTO :EOF
)



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_7Zip_Compression_Translator
REM Translate these variables as hardly anyone is going to understand what these integers mean.
IF %SevZipCompressionPass% EQU 0 (
    SET ProcessVarA=Copy
    GOTO :EOF
)
IF %SevZipCompressionPass% EQU 1 (
    SET ProcessVarA=Low
    GOTO :EOF
)
IF %SevZipCompressionPass% EQU 3 (
    SET ProcessVarA=Below Normal
    GOTO :EOF
)
IF %SevZipCompressionPass% EQU 5 (
    SET ProcessVarA=Normal
    GOTO :EOF
)
IF %SevZipCompressionPass% EQU 7 (
    SET ProcessVarA=Above Normal
    GOTO :EOF
)
IF %SevZipCompressionPass% EQU 9 (
    SET ProcessVarA=High
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: Compression ratio menu
REM # =============================================================================================
:ControlPanel_7Zip_Compression
CALL :DashboardDisplay
REM Translate the value to a nicer value
CALL :ControlPanel_7Zip_Compression_Translator
ECHO 7Zip Compression Level Depth Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO During compacting files into an archive file, it is possible to customize the depth of compression for the data within the archive file.  Higher compression - more CPU time is needed but the data is well compressed, Lesser compression - less CPU time is needed but the data is not so well compressed.
ECHO.
ECHO Default Value: Normal
ECHO Compression Depth is currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Copy
ECHO [2] Low
ECHO [3] Below Normal
ECHO [4] Normal
ECHO [5] Above Normal
ECHO [6] High
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_Compression_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_Compression_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_Compression_Switch Copy
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_Compression_Switch Low
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_7Zip_Compression_Switch BelowNormal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_7Zip_Compression_Switch Normal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_7Zip_Compression_Switch AboveNormal
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
IF "%STDIN%" EQU "6" (
    CALL :ControlPanel_7Zip_Compression_Switch High
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Compression
)
CALL :BadInput& GOTO :ControlPanel_7Zip_Compression



REM # =============================================================================================
REM # Parameters: [{string} CompressionRatio]
REM # Documentation: This function sets the compression ratio.
REM # =============================================================================================
:ControlPanel_7Zip_Compression_Switch
IF %1 EQU Copy (
    REM Compression: Copy, no compression.
    SET SevZipCompressionPass=0
    GOTO :EOF
)
IF %1 EQU Low (
    REM Compression: Low
    SET SevZipCompressionPass=1
    GOTO :EOF
)
IF %1 EQU BelowNormal (
    REM Compression: Below Normal
    SET SevZipCompressionPass=3
    GOTO :EOF
)
IF %1 EQU Normal (
    REM Compression: Normal
    SET SevZipCompressionPass=5
    GOTO :EOF
)
IF %1 EQU AboveNormal (
    REM Compression: Above Normal
    SET SevZipCompressionPass=7
    GOTO :EOF
)
IF %1 EQU High (
    REM Compression: High
    SET SevZipCompressionPass=9
    GOTO :EOF
)



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Copy algorithm menu
REM # =============================================================================================
:ControlPanel_7Zip_CopyAlgorithm
CALL :DashboardDisplay
ECHO 7Zip Copy Format Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When importing files into an archive file, the 7Zip software requires that the data must be imported in a certain way for compression and decompression means.
ECHO.
ECHO Default Value: Deflate
ECHO Copy Format is currently: %SevZipCopyFormat%
ECHO %Separator%
ECHO [1] Copy
ECHO [2] Deflate
ECHO [3] Deflate64
ECHO [4] BZip2
ECHO [5] LZMA
ECHO [6] PPMd
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_CopyAlgorithm_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_CopyAlgorithm_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch Copy
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch Deflate
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch Deflate64
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch BZip2
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
IF "%STDIN%" EQU "5" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch LZMA
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
IF "%STDIN%" EQU "6" (
    CALL :ControlPanel_7Zip_CopyAlgorithm_Switch PPMd
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_CopyAlgorithm
)
CALL :BadInput& GOTO :ControlPanel_7Zip_CopyAlgorithm



REM # =============================================================================================
REM # Parameters: [{string} CopyType]
REM # Documentation: This function sets the primary copy algorithm.
REM # =============================================================================================
:ControlPanel_7Zip_CopyAlgorithm_Switch
IF %1 EQU Copy (
    SET SevZipCopyFormat=Copy
    GOTO :EOF
)
IF %1 EQU Deflate (
    SET SevZipCopyFormat=Deflate
    GOTO :EOF
)
IF %1 EQU Deflate64 (
    SET SevZipCopyFormat=Deflate64
    GOTO :EOF
)
IF %1 EQU BZip2 (
    SET SevZipCopyFormat=BZip2
    GOTO :EOF
)
IF %1 EQU LZMA (
    SET SevZipCopyFormat=LZMA
    GOTO :EOF
)
IF %1 EQU PPMd (
    SET SevZipCopyFormat=PPMd
    GOTO :EOF
)



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_7Zip_Multithread_Translator
IF %SevZipMultiThreadingCPU% EQU on SET ProcessVarA=Enable& GOTO :EOF
IF %SevZipMultiThreadingCPU% EQU off SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Multiple threading menu
REM # =============================================================================================
:ControlPanel_7Zip_Multithread
CALL :DashboardDisplay
REM Translate the value to a nicer value
CALL :ControlPanel_7Zip_Multithread_Translator
ECHO 7Zip Multithreading Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO 7Zip can utilize all available CPU cores and threads for processing, which - is faster.  If the CPU does _NOT_ have multiple cores or threads, disable this feature.
ECHO.
ECHO Default Value: Enable
ECHO Multithreading is currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Enable
ECHO [2] Disable
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_Multithread_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_Multithread_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

REM First check if the host system has multithreading capabilities available, and then cache that return value.
CALL :ControlPanel_7Zip_Multithread_Evaluate
SET ProcessVarA=%ERRORLEVEL%

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_Multithread_Toggle False %ProcessVarA%
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Multithread
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_Multithread_Toggle True %ProcessVarA%
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Multithread
)
CALL :BadInput& GOTO :ControlPanel_7Zip_Multithread



REM # =============================================================================================
REM # Parameters: [{string} MultithreadingMode] [{bool} Evaluation]
REM # Documentation: This function sets the multithreading setting.
REM # =============================================================================================
:ControlPanel_7Zip_Multithread_Toggle
IF %1 EQU False (
    IF %2 EQU 1 SET SevZipMultiThreadingCPU=on
    GOTO :EOF
) ELSE (
    SET SevZipMultiThreadingCPU=off
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function will check to see how many logical cores the host system has available.  This function is dedicated for 7Zip program, Multithreading functionality.  If the host system does NOT have any multithreading capabilities available, this program will disable the multithreading functionality when 7Zip is being called.
REM # =============================================================================================
:ControlPanel_7Zip_Multithread_Evaluate
IF %Number_Of_Processors% EQU 0 (
    REM Not possible to utilize Multithreading
    EXIT /B 0
) ELSE (
    REM Multithreading capabilities are possible
    EXIT /B 1
)
GOTO :EOF



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Encryption Algorithm menu
REM # =============================================================================================
:ControlPanel_7Zip_Encryption
CALL :DashboardDisplay
ECHO 7Zip Encryption Algorithm Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO When utilizing password protected archive files, this allows the user to select different encryption types that 7Zip supports.  Best encrypted archives, takes more time to break.
ECHO.
ECHO Default Value: ZipCrypto
ECHO Encryption is currently: %SevZipEncryptionAlgorithm%
ECHO %Separator%
ECHO [1] ZipCrypto
ECHO [2] AES128
ECHO [3] AES192
ECHO [4] AES256
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_Encryption_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_Encryption_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF
IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_Encryption_Switch ZipCrypto
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Encryption
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_Encryption_Switch AES128
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Encryption
)
IF "%STDIN%" EQU "3" (
    CALL :ControlPanel_7Zip_Encryption_Switch AES192
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Encryption
)
IF "%STDIN%" EQU "4" (
    CALL :ControlPanel_7Zip_Encryption_Switch AES256
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Encryption
)
CALL :BadInput& GOTO :ControlPanel_7Zip_Encryption



REM # =============================================================================================
REM # Parameters: [{string} EncryptionType]
REM # Documentation: This function sets the primary encryption type.
REM # =============================================================================================
:ControlPanel_7Zip_Encryption_Switch
IF %1 EQU ZipCrypto (
    SET SevZipEncryptionAlgorithm=ZipCrypto
    GOTO :EOF
)
IF %1 EQU AES128 (
    SET SevZipEncryptionAlgorithm=AES128
    GOTO :EOF
)
IF %1 EQU AES192 (
    SET SevZipEncryptionAlgorithm=AES192
    GOTO :EOF
)
IF %1 EQU AES256 (
    SET SevZipEncryptionAlgorithm=AES256
    GOTO :EOF
)



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_7Zip_Verify_Translator
IF %SevZipVerify% EQU True SET ProcessVarA=Enable& GOTO :EOF
IF %SevZipVerify% EQU False SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Integrity checking menu
REM # =============================================================================================
:ControlPanel_7Zip_Verify
CALL :DashboardDisplay
REM Translate the value to a nicer value
CALL :ControlPanel_7Zip_Verify_Translator
ECHO 7Zip Verification Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO After 7Zip finishes generating an archive file [and everything is already compressed], this option enforces 7Zip to verify the archive file for any potential errors.
ECHO.
ECHO Default Value: Enable
ECHO Integrity Checking is currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Enable
ECHO [2] Disable
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_Verifys_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_Verifys_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_Verify_Toggle True
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Verify
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_Verify_Toggle False
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_Verify
)
CALL :BadInput& GOTO :ControlPanel_7Zip_Verify



REM # =============================================================================================
REM # Parameters: [{string} VerifyMode]
REM # Documentation: This function sets the primary value for the verification process.
REM # =============================================================================================
:ControlPanel_7Zip_Verify_Toggle
IF %1 EQU True (
    SET SevZipVerify=True
    GOTO :EOF
) ELSE (
    SET SevZipVerify=False
    GOTO :EOF
)



REM =============================================================================
REM =============================================================================
REM -----------------------------------------------------------------------------
REM =============================================================================
REM =============================================================================



REM # =============================================================================================
REM # Documentation: Translate the stored value to a working variable.  This will contain a nicer value that will be displayed on the terminal screen.
REM # =============================================================================================
:ControlPanel_7Zip_TogglePassword_Translator
IF %SevZipUseKey% EQU True SET ProcessVarA=Enable& GOTO :EOF
IF %SevZipUseKey% EQU False SET ProcessVarA=Disable
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Toggle password protection menu
REM # =============================================================================================
:ControlPanel_7Zip_TogglePassword
CALL :DashboardDisplay
REM Translate the value to a nicer value
CALL :ControlPanel_7Zip_TogglePassword_Translator
ECHO 7Zip Toggle Passwords Settings
ECHO.
ECHO Description
ECHO %SeparatorSmall%
ECHO A simple switch to enforce archive files to be created with a password.
ECHO.
ECHO Default Value: Disable
ECHO Use Passwords is currently: %ProcessVarA%
ECHO %Separator%
ECHO [1] Enable
ECHO [2] Disable
ECHO.
ECHO Other Options
ECHO %SeparatorSmall%
ECHO [X] Cancel
CALL :UserInput
GOTO :ControlPanel_7Zip_TogglePassword_UserInput



REM # =============================================================================================
REM # Documentation: Inspect the user's input.
REM # =============================================================================================
:ControlPanel_7Zip_TogglePassword_UserInput
IF /I "%STDIN%" EQU "Cancel" GOTO :EOF
IF /I "%STDIN%" EQU "X" GOTO :EOF

IF "%STDIN%" EQU "1" (
    CALL :ControlPanel_7Zip_TogglePassword_Toggle True
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_TogglePassword
)
IF "%STDIN%" EQU "2" (
    CALL :ControlPanel_7Zip_TogglePassword_Toggle False
    CALL :ClearBuffer 1
    GOTO :ControlPanel_7Zip_TogglePassword
)
CALL :BadInput& 
GOTO :ControlPanel_7Zip_TogglePassword



REM # =============================================================================================
REM # Parameters: [{string} PasswordProtectionMode]
REM # Documentation: This function enables or disables the password protection.
REM # =============================================================================================
:ControlPanel_7Zip_TogglePassword_Toggle
IF %1 EQU False (
    SET SevZipUseKey=False
    GOTO :EOF
)
REM Assume true otherwise, but also check to make sure that there is a key already set.
IF "%SevZipKey%" EQU "" (
    REM If incase this setting was already enabled previously, disable it.
    SET SevZipUseKey=False
    CALL :ControlPanel_7Zip_TogglePassword_NoKeySetError
    GOTO :EOF
) ELSE (
    SET SevZipUseKey=True
    GOTO :EOF
)



REM # =============================================================================================
REM # Documentation: This function will be called when the user attempts to enable the use of the password - when the password was never defined within the program.
REM # =============================================================================================
:ControlPanel_7Zip_TogglePassword_NoKeySetError
ECHO.&ECHO.
ECHO ^<!^>    Password Not Declared!    ^<!^>
ECHO %SeparatorLong%
ECHO.
ECHO !ERR: There is no password yet defined!  Please go to Password Setup within the 7Zip configuration!
ECHO.
PAUSE
GOTO :EOF