Project Module
Doom Builder 64


This documentation is based on Doom Builder 64 Project Module (version 1.5) for Bootless Star version 1.5 (Codenamed Aditi)



Table of Contents
*   What is Doom Builder 64 (Project Module)
*   Features
*   Requirements
*   Configuring: Locate the Subversion Local Copy




What is Doom Builder 64 (Project Module)
--------------------------------------------
============================================
The purpose of this shell script is to help compile the 'Doom Builder 64' software directly from the Subversion local working that is stored on the user's system.  After a build has been compiled, it is possible to then generate: an archive (built with 7zip), create a setup build, or simply just keep the generated build - which anyone can simply double-click the binary build and easily start using the program as is.




Features
--------------------------------------------
============================================
Ability to compile the Doom Builder 64 project and selective plugins (either all, default, or just the Doom Builder 64 core by itself)
Update the SVN Local Working Copy
Fetch changelog history [readable txt, or XML formatting]
Upkeep (or clean) the SVN Local Working Copy
Compact the newly compiled build into an 7z archive and\or create a setup executable




Requirements
--------------------------------------------
============================================
Microsoft Visual Studio 2008
    OR
        Microsoft Visual Studio 2010
        Microsoft Visual Studio 2012
        Microsoft Visual Studio 2013
TortoiseSVN
    WITH Commandline Toolset

OPTIONAL
    7Zip
    Inno Setup Generator




Configuring: Locate the Subversion Local Copy
--------------------------------------------
============================================
When using the this script for the first time, there is one matter that is crucially important - - - setting up.  In order to effectively use this program, the user must specify where the Subversion local copy for Doom Builder 64 exists within their system.  By default, the program tries to use '%USERPROFILE%\Doombuilder\branches\builder64', however, this is not the case for - almost everyone as every body has different setups.  To change this setting go to:
        Settings:
            Directory Management:
                Locate Doom Builder 64 Directory
                NOTE: If you notice that "- Detected: [True]", then the program can already detect the SVN Local working copy of the Doom Builder 64 project!
                    And then enter the ABSOLUTE PATH with _NO_ quote(s) and _NO_ variables of any kind.
                    For example: C:\Users\John\SVN Projects\Doom Builder 2\branches\builder64\
                    
                    NOTE: As Doom Builder 64 contents are specifically at the 'branches\builder64', you must deliberately point the program to the builder64 directory!  The above example already demonstrates this.