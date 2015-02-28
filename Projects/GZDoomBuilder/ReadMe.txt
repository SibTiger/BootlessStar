Project Module
GZDoom Builder


This documentation is based on GZDoom Builder Project Module (version 1.6) for Bootless Star version 1.5 (Codenamed Aditi)



Table of Contents
*   What is GZDoom Builder (Project Module)
*   Features
*   Requirements
*   Configuring: Locate the Subversion Local Copy




What is GZDoom Builder (Project Module)
--------------------------------------------
============================================
The purpose of this shell script is to help compile the 'GZDoom Builder' software directly from the Subversion local working that is stored on the user's system.  After a build has been compiled, it is possible to then generate: an archive (built with 7zip), create a setup build, or simply just keep the generated build - which anyone can simply double-click the binary build and easily start using the program as is.




Features
--------------------------------------------
============================================
Ability to compile the GZDoom Builder project and selective plugins (either all, default, or just the GZDoom Builder core by itself)
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
When using the this script for the first time, there is one matter that is crucially important - - - setting up.  In order to effectively use this program, the user must specify where the Subversion local copy for GZDoom Builder exists within their system.  By default, the program tries to use '%USERPROFILE%\Doombuilder\branches\GZDoomBuilder', however, this is not the case for - almost everyone as every body has different setups.  To change this setting go to:
        Settings:
            Directory Management:
                Locate GZDoom Builder Directory
                NOTE: If you notice that "- Detected: [True]", then the program can already detect the SVN Local working copy of the GZDoom Builder project!
                    And then enter the ABSOLUTE PATH with _NO_ quote(s) and _NO_ variables of any kind.
                    For example: C:\Users\John\SVN Projects\Doom Builder 2\branches\GZDoomBuilder
                    
                    NOTE: As GZDoom Builder contents are specifically at the 'branches\gzdoombuilder', you must deliberately point the program to the GZDoomBuilder directory!  The above example already demonstrates this.