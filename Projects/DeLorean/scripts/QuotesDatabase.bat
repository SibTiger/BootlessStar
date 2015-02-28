REM =====================================================================
REM Back to the Future Quotes Database Manager
REM ----------------------------
REM This block contains quotes from the movie Back to the Future [1-3] and will randomly print on the screen.  Why call the program the 'DeLorean' and not have Back to the Future quotes?!  That's just crazy!
REM =====================================================================


REM # =============================================================================================
REM # Documentation: Quote Database Driver
REM # =============================================================================================
:QuoteDatabase
REM Does the user want the quotes to be even displayed on the terminal buffer screen?
IF %UserConfig.BackToTheFutureQuotes% EQU False GOTO :EOF
REM Fetch a random number
CALL :QuoteDatabase_RandNum
REM Scan through the registry and output a quote
CALL :QuoteDatabase_ScanQuotes %ERRORLEVEL%
REM Separate the quote from rest of the programs output.
CALL :QuoteDatabase_Footer
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Leave additional spaces after the quote has been printed on the screen.
REM # =============================================================================================
:QuoteDatabase_Footer
ECHO.& ECHO.
GOTO :EOF



REM # =============================================================================================
REM # Documentation: Fetch a number within a specific range and return the value.
REM # =============================================================================================
:QuoteDatabase_RandNum
SET /A ProcessVarA=%RANDOM% %% 42
EXIT /B %ProcessVarA%



REM # =============================================================================================
REM # Parameters: [{int} RandomNum]
REM # Documentation: Using the random number, scan through the quote database and print the quote on the terminal buffer.
REM #   I am sorry, there's no switch statement in Batch and I wont use a for-loop [assuming that is remotely possible]....
REM #
REM #  Quotes Resources:
REM #    IMDb
REM #      http://www.imdb.com/title/tt0088763/quotes
REM #      http://www.imdb.com/title/tt0096874/quotes
REM #      http://www.imdb.com/title/tt0099088/quotes
REM # =============================================================================================
:QuoteDatabase_ScanQuotes
IF %1 EQU 0 (
    ECHO Marty McFly: Wait a minute, Doc. Ah... Are you telling me that you built a time machine... out of a DeLorean?
    ECHO Dr. Emmett Brown: The way I see it, if you're gonna build a time machine into a car, why not do it with some style? 
    GOTO :EOF
)

IF %1 EQU 1 (
    ECHO Dr. Emmett Brown: If my calculations are correct, when this baby hits 88 miles per hour... you're gonna see some serious shit.
    GOTO :EOF
)

IF %1 EQU 2 (
    ECHO Marty McFly: Hey, Doc, we better back up. We don't have enough road to get up to 88.
    ECHO Dr. Emmett Brown: Roads? Where we're going, we don't need roads.
    GOTO :EOF
)

IF %1 EQU 3 (
    ECHO Dr. Emmett Brown: Great Scott!
    GOTO :EOF
)

IF %1 EQU 4 (
    ECHO Marty McFly: This is heavy.
    GOTO :EOF
)

IF %1 EQU 5 (
    ECHO Biff Tannen: Since you're new here, I-I'm gonna cut you a break, today. So, why don't you make like a tree and get outta here?
    GOTO :EOF
)

IF %1 EQU 6 (
    ECHO Younger Dr. Emmett Brown: 1.21 gigawatts! 1.21 gigawatts. Great Scott!
    ECHO Marty McFly: What-what the hell is a gigawatt?
    GOTO :EOF
)

IF %1 EQU 7 (
    ECHO Dr. Emmett Brown: [looks at his watch] Damn! Where is that kid?
    ECHO  [looks at a small alarm clock in his other hand]
    ECHO Dr. Emmett Brown: Damn!
    ECHO  [looks at a second watch on his other wrist]
    ECHO Dr. Emmett Brown: Damn! Damn!
    GOTO :EOF
)

IF %1 EQU 8 (
    ECHO George McFly: Last night, Darth Vader came down from Planet Vulcan and told me that if I didn't take Lorraine out, that he'd melt my brain.
    GOTO :EOF
)

IF %1 EQU 9 (
    ECHO Dr. Emmett Brown: I'm sure that in 1985, plutonium is available in every corner drugstore, but in 1955, it's a little hard to come by.
    GOTO :EOF
)

IF %1 EQU 10 (
    ECHO Dr. Emmett Brown: No wonder your president has to be an actor. He's gotta look good on television.
    GOTO :EOF
)

IF %1 EQU 11 (
    ECHO Marty McFly: This is heavy.
    ECHO Dr. Emmett Brown: Weight has nothing to do with it.
    GOTO :EOF
)

IF %1 EQU 12 (
    ECHO Marty McFly: If you put your mind to it, you can accomplish anything.
    GOTO :EOF
)

IF %1 EQU 13 (
    ECHO George McFly: You really think I ought to swear?
    ECHO Marty McFly: Yes, definitely. Goddamn it, George, swear.
    GOTO :EOF
)

IF %1 EQU 14 (
    ECHO Dr. Emmett Brown: Things have certainly changed around *here*. I remember when this was all farmland as far the eye could see. Old man Peabody owned all of this. He had this crazy idea about breeding pine trees.
    GOTO :EOF
)

IF %1 EQU 15 (
    ECHO Marty McFly: Okay. Time circuit's on. Flux capacitor, fluxing. Engine running. All right.
    ECHO  [the engine stops suddenly]
    GOTO :EOF
)

IF %1 EQU 16 (
    ECHO Marty McFly: Whoa. This is heavy.
    ECHO Dr. Emmett Brown: There's that word again. "Heavy." Why are things so heavy in the future? Is there a problem with the Earth's gravitational pull?
    GOTO :EOF
)

IF %1 EQU 17 (
    ECHO Dr. Emmett Brown: What on Earth is this thing I'm wearing?
    ECHO Marty McFly: Ah, this, this is a radiation suit.
    ECHO Dr. Emmett Brown: Radiation suit? Of course. 'Cause of all the fallout from the atomic wars.
    GOTO :EOF
)

IF %1 EQU 18 (
    ECHO Dr. Emmett Brown: [Marty is showing Doc Brown the flux capacitor in the DeLorean time vehicle] It works! It works!
    ECHO  [grabs Marty]
    ECHO Dr. Emmett Brown: I finally invent something that works!
    ECHO Marty McFly: You bet your ass it works.
    GOTO :EOF
)

IF %1 EQU 19 (
    ECHO Dr. Emmett Brown: You'll have to forgive the crudeness of this model. I didn't have time to paint it or build it to scale.
    GOTO :EOF
)

IF %1 EQU 20 (
    REM This is not a quote, but something I added ;)
    ECHO 2015 is the year of hoverboards!
    GOTO :EOF
)

IF %1 EQU 21 (
    ECHO Young Biff: Why don't you make like a tree and get out of here?
    ECHO Old Biff: It's *leave*, you idiot! "Make like a tree, and leave." You sound like a damn fool when you say it wrong.
    ECHO Young Biff: All right then, LEAVE! And take your book with you!
    GOTO :EOF
)

IF %1 EQU 22 (
    ECHO Doc: The time-traveling is just too dangerous. Better that I devote myself to study the other great mystery of the universe: women!
    GOTO :EOF
)

IF %1 EQU 23 (
    ECHO Marty McFly: I don't get it, Doc. I mean, how can all this be happening? It's like we're in Hell or something.
    ECHO Doc: No, it's Hill Valley. Although I can't imagine Hell being much worse!
    GOTO :EOF
)

IF %1 EQU 24 (
    ECHO Television announcer: Broadcasting beautiful views 24 hours a day: you're tuned to the Scenery Channel.
    GOTO :EOF
)

IF %1 EQU 25 (
    ECHO Doc: Marty! What in the name of Sir Isaac H. Newton happened here?
    GOTO :EOF
)

IF %1 EQU 26 (
    ECHO Goldie Wilson III: [in TV Commercial] Hi friends, Goldie Wilson III for Wilson Hover Conversion Systems. You know, when my Grandpa was Mayor of Hill Valley, he had to worry about traffic problems. But now, you don't have to worry about traffic. I'll hover convert your old road car into a skyway flyer! For only $39,999.95. So come on down and see me Goldie Wilson III, at any one of our 29 convenient locations. Remember, keep 'em flying!
    GOTO :EOF
)

IF %1 EQU 27 (
    ECHO Young Doc: Nice talking to you. Maybe we'll bump into each other sometime again in the future.
    ECHO Older Doc: Or in the past.
    GOTO :EOF
)

IF %1 EQU 28 (
    ECHO Marty McFly: [showing the two boys how to play the shoot 'em up video game] I'll show you, kid. I'm a crack shot at this.
    ECHO  [shoots a perfect score with the electronic gun]
    ECHO Video Game Boy #1: You mean you have to use your hands?  That's like a baby's toy!
    GOTO :EOF
)

IF %1 EQU 29 (
    ECHO Old Biff: Buttheads...
    GOTO :EOF
)

IF %1 EQU 30 (
    ECHO Doc: I went to a rejuvenation clinic and got a whole natural overhaul. They took out some wrinkles, did hair repair, changed the blood, added a good 30 to 40 years to my life. They also replaced my spleen and colon. What do you think?
    GOTO :EOF
)

IF %1 EQU 31 (
    ECHO Data: Hey McFly, you bojo, those boards don't work on water!
    ECHO Whitey: Unless you've got POWER!
    GOTO :EOF
)

IF %1 EQU 32 (
    ECHO Marty McFly: [arriving in 1955] Oh, this is heavy, Doc. I mean, it's like I was just here yesterday.
    ECHO Doc: You were here yesterday, Marty.
    GOTO :EOF
)

IF %1 EQU 33 (
    ECHO Young Doc: Well, good luck for both of our sakes. See you in the future.
    ECHO Marty McFly: You mean the past?
    ECHO Young Doc: Exactly.
    GOTO :EOF
)

IF %1 EQU 34 (
    ECHO Doc: You're just not thinking fourth dimensionally!
    ECHO Marty McFly: Right, right. I have a real problem with that.
    GOTO :EOF
)

IF %1 EQU 35 (
    ECHO Young Doc: No wonder this circuit failed. It says "Made in Japan".
    ECHO Marty McFly: What do you mean, Doc? All the best stuff is made in Japan.
    ECHO Young Doc: Unbelievable.
    GOTO :EOF
)

IF %1 EQU 36 (
    ECHO Marty McFly: Great Scott!
    ECHO Doc: I know, this is heavy.
    GOTO :EOF
)

IF %1 EQU 37 (
    ECHO Buford "Mad Dog" Tannen: What's your name, dude?
    ECHO Marty McFly: Uh, Mar- Eastwood. Clint Eastwood.
    ECHO Buford "Mad Dog" Tannen: What kind of stupid name is that?
    GOTO :EOF
)

IF %1 EQU 38 (
    ECHO Colt Gun Salesman: [the gun salesman is amazed at Marty's gunmanship at a shooting gallery] Uh, just tell me one thing. Where'd you learn to shoot like that?
    ECHO Marty McFly: 7-Eleven.
    GOTO :EOF
)

IF %1 EQU 39 (
    ECHO Marty McFly: [holding up a plate that says "Frisbee"] Hey, Frisbee, far-out.
    ECHO Seamus McFly: What was the meanin' of that?
    ECHO Maggie McFly: It was right in front of him.
    GOTO :EOF
)

IF %1 EQU 40 (
    ECHO Marty McFly: You're the doc, Doc.
    GOTO :EOF
)

IF %1 EQU 41 (
    ECHO Bartender: [On the day Marty is set to face Buford in a shootout] Seamus! I didn't expect to see you here this early!
    ECHO Seamus McFly: Aye. But somethin' told me I should be here, as if my future had something to do with it.
    GOTO :EOF
)

ECHO !ERR: Quote Address [ %1 ] is not registered!
GOTO :EOF