    Bootless Star
        About
=============================


Bootless Star, essentially, creates an environment for modules to easily get procedures accomplished with little to none user interaction.  The core program houses an abundance of variables that contains information about the host system state, detected programs, users configuration, and internal variables.  With these available variables, this allows modules to share the same configurations from the user and allows the modules to focus primarily on getting their job done and not having to worry about user settings -- allow the programs to do one thing and one thing well.

Additionally, it is possible to execute non-module programs (scripts that are not supported by the Bootless Star core), however the user settings will not be carried over - nor the core's environment.  This will assure that any sensitive values are not exposed to outside scripts, but all of the variables _will_ have free and easy access to the sensitive variables -- as it should be.

Moreover, Bootless Star does not compile any of the Doom Builder 2 software, for those that used the beta versions.  Since Beta 1 through Beta 7.x - Bootless Star was able to compile any of the supported Doom Builder 2 software, but that has changed since Version 1.  After developing several programs that uses the same core and the same functionality, and to allow easier expansion for Doom Builder 2 based software, I decided to revise the entire Bootless Star foundation to focus primarily on modules.  This idea alone allows greater expansion for updates and newer additions - as it doesn't require having to update the entire program, and and allows the modules to be maintained in a much easier fashion.



Language Written In:
    Windows Command Shell
        Batch, shell script