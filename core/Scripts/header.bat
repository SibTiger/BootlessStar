@REM Created by Nicholas "Tiger" Gautier
@REM Contact: SibTiger_And_Life@Hotmail.com
@REM Website: http://tigersfiles.webs.com/
@REM Details: This program [the core], is designed as a front-end program that sets the environment for any compatible module.  This program depends on external scripts to carry out any specific task or operations the user requests, such external modules can depend on the environment that this program provides to make life easier for both the end-user and the programmer.
@REM ==========================================

@ECHO OFF
ECHO Executing %0...
ECHO.
REM Before we begin the initial program, check the host operating system.
GOTO :IncompatibilityOS_Check