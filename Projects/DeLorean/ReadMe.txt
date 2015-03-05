Project Module
The DeLorean


This documentation is based on The DeLorean Project Module (version 5) for Bootless Star version 1.5 (Codenamed Aditi)



Table of Contents
*   What is The DeLorean (Project Module)
*   Features
*   Requirements




What is The DeLorean (Project Module)
--------------------------------------------
============================================
The DeLorean is a backup program this is designed to only backup the user's personalized data that is stored in their Home Directories in Windows Vista and later.  When backing up, the program will utilize the 7Zip software to compact the data and verify the contents (if specified from the Bootless Star program).  This program will only store new archives varying by dates and will not manage any archive files.  It is possible to unpack the archive files later on, however the unpack data will only be stored in \restore\, a local directory within the DeLorean program.  This directory the user can determine what to do with the data and do as they please and what they will.



Features
--------------------------------------------
============================================
BACK TO THE FUTURE MOVIE QUOTES!!!  It would be insane to call this program 'The DeLorean' and not have Back to the Future quotes, absolutely crazy to think otherwise!
Backup's the user's personalized data that is stored in their home directory (%USERPROFILE%)
Ability to encrypt their backup archive files (this dependable on the Bootless Star settings)
Ability to store backup's in another drive that is dedicated to for system and user backups
Ability to allow or disallow backing up users movies that is stored in [~\Videos, ~\MyVideos, ~\My Videos, ~\Movies, ~\MyMovies, ~\My Movies]
Easily unpack (restore) data; HOWEVER THIS WILL _NOT_ ACTUALLY RESTORE OR OVERWRITE NOR COPY\MOVE DATA TO YOUR HOME DIRECTORY!  Instead, all unpacked data will be moved to \restore\.
After the backup is successful, the program can issue a signal to suspend, hibernate, and shutdown the system.



Requirements
--------------------------------------------
============================================
7Zip