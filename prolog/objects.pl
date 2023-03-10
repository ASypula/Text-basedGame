:- dynamic
    possess/1.

/* Get information about objects */

check(old_journal) :-
    possess(old_journal),
    write("I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."),
    nl, !.

check(firefly) :-
    possess(firefly),
    write("TODO"),
    nl, !.

check(burned_journal) :-
    possess(burned_journal),
    write("[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting \"grab\" on it's tail would be funnier. Besides I don't have nightcap for [illegible] spell"),
    nl, !.

check(jar) :-
    possess(jar),
    write("TODO"),
    nl, !.

/* TODO: should we hint that an object is a spell component? */
check(key) :-
    possess(key),
    write("Small iron key fit more for pendants than doors or chests. (hint: spell component)"),
    nl, !.

check(cheat_sheet) :-
    possess(cheat_sheet),
    write("TODO"),
    nl, !.

check(magnet) :-
    possess(magnet),
    write("TODO"),
    nl, !.    

check(rope) :-
    possess(rope),
    write("Old tattered rope. You wouldn't trust it to hold you weight"),
    nl, !. 

check(beer) :-
    possess(magnet),
    write("[the hero is a student who failed an exam. There must be beer somewhere in the game]"),
    nl, !. 

check(_) :-
    write('Nothing to check. Object is not in your possession'), nl.

/* Actions with objects */

grab(firefly, jar) :-
    possess(jar),
    write("Wow! You managed to grab a firefly! Be careful not to free it."),
    nl, !.

possess(firefly) :-
    grab(firefly, jar),
    nl, !.
