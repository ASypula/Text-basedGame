/* Get information about objects */

describe(old_journal) :-
    holding(old_journal),
    write("I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."),
    nl, !.

describe(firefly) :-
    holding(firefly),
    write("Small, light-emitting beetles. Their light might not be very strong, but If reinforced..."),
    nl, !.

describe(burned_journal) :-
    holding(burned_journal),
    write("[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting \"grab\" on it's tail would be funnier. Besides I don't have nightcap for [illegible] spell"),
    nl, !.

describe(jar) :-
    holding(jar),
    write("Empty, a bit dusty jar."),
    nl, !.

describe(key) :-
    holding(key),
    write("Small iron key fit more for pendants than doors or chests. (hint: spell component)"),
    nl, !.

metal(key).

describe(cheat_sheet) :-
    holding(cheat_sheet),
    write("@TODO"),
    nl, !.

describe(magnet) :-
    holding(magnet),
    write("Medium size magnet with carved initials."),
    nl, !.    

describe(rope) :-
    holding(rope),
    write("Old tattered rope. You wouldn't trust it to hold your weight."), nl,
    write("But it's quite long. I can't throw it too far but maybe I can grab something with a help of some spell?"),
    nl, !. 

describe(beer) :-
    holding(beer),
    write("[the hero is a student who failed an exam. There must be beer somewhere in the game]"),
    nl, !. 

describe(_) :-
    write('Nothing to describe. Object is not in your inventory'), nl.

/* Actions with objects */

use_object(jar, firefly) :-
    holding(jar),
    i_am_at(Place),
    at(firefly, Place),
    assert(holding(firefly)),
    write("Wow! You managed to grab a firefly! Be careful not to free it."),
    nl, !.

take(key) :-
    write("Sorry, you are not able to easily pick up the key. Think of a different solution."), nl,
    false.

use_object(magnet, X) :-
    metal(X),
    holding(magnet),
    i_am_at(Place),
    at(X, Place),
    retract(at(X, Place)),
    assert(holding(X)),
    write("Great! You managed to pick up "),
    write(X), nl.

