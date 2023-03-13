:- multifile use_object/2.
:- multifile take/1.

/* Get information about objects */

investigate(journal) :-
    write("Be more specyfic about which journal. (To check out your invetory try command \"inventory\")."),
    nl, !.

investigate(old_journal) :-
    holding(old_journal),
    write("I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."),
    nl, !.

investigate(firefly) :-
    holding(firefly),
    write("Small, light-emitting beetles. Their light might not be very strong, but If reinforced..."),
    nl, !.

investigate(burned_journal) :-
    holding(burned_journal),
    write("[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting \"grab\" on it's tail would be funnier. Besides I don't have nightcap for [illegible] spell"),
    nl, !.

investigate(jar) :-
    holding(jar),
    write("Empty, a bit dusty jar."),
    nl, !.

investigate(key) :-
    holding(key),
    write("Small iron key fit more for pendants than doors or chests. (hint: spell component)"),
    nl, !.

investigate(cheat_sheet) :-
    holding(cheat_sheet),
    write("@TODO"),
    nl, !.

investigate(magnet) :-
    holding(magnet),
    write("Medium size magnet with carved initials."),
    nl, !.    

investigate(rope) :-
    holding(rope),
    write("Old tattered rope. You wouldn't trust it to hold your weight."), nl,
    write("But it's quite long. I can't throw it too far but maybe I can grab something with a help of some spell?"),
    nl, !. 

investigate(potion) :-
    holding(potion),
    write('You recognise it from your alchemy classes (the only ones that you pass). This is a Far Jump Potion.'), nl,
    write('You can use it to jump very far, but only once.'), nl, !.

investigate(nightcap) :-
    holding(nightcap),
    write("It doesn't look too fashionable, but kind of comfy. (hint: spell component)"),
    nl, !. 

investigate(note) :-
    holding(note),
    write("The code is year of the Worm Spell disaster."),
    nl, !. 

investigate(book_fragment) :-
    holding(book_fragment),
    write("There is a more powerful variant of 'open' spell that uses rusty key as a component, which is proven to..."), nl,
    write("The words 'more', 'powerful' and 'rusty' are underlined and next to them there is a handwritten note 'Dumb as hell'."),
    nl, !. 

investigate(big_journal) :-
    holding(big_journal),
    write("I finally decoded the runes on the wall. Some of them allow casting grow, shrink spells (grow(object). and shrink(object).)."), nl,
    write("Others form some kind of a riddle. Good thing that I listened during rune theory lectures. It roughly translates as:"), nl,
    write("1. Green block has only one neighbour."), nl,
    write("2. Red has both small and big neighbour."), nl,
    write("3. Purple is small."), nl,
    write("4. Red and blue are both next to their colour mix."), nl,
    write("5. Their size has symmetry about the middle block."), nl,
    write("6. Blue doesn't have any small blocks on it's right."), nl,
    write("7. Red is more to the left than orange is."),
    nl, !. 

investigate(beer) :-
    holding(beer),
    write("[the hero is a student who failed an exam. There must be beer somewhere in the game]"),
    nl, !. 

investigate(lantern) :-
    write("Your good trusty lantern. You will need it until you finally get a hold of light spell."),
    nl, !.

investigate(_) :-
    write('Nothing to describe. Object is not in your inventory'), nl.

/* Specyfic take actions with objects */

take(journal) :-    /* allows the user to take the correct journal in present room */
    is_journal(Journal),
    i_am_at(Place),
    at(Journal, Place),
    take(Journal).


take(firefly) :-
    write("Hmmm If only you could use something to catch it in."), nl,
    false.

take(key) :-
    write("Sorry, you are not able to easily pick up the key. Think of a different solution."), nl,
    false.

/* These rules describe specyfic use_object actions */

use_object(jar, firefly) :-
    holding(jar),
    i_am_at(Place),
    at(firefly, Place),
    assert(holding(firefly)),
    write("Wow! You managed to grab a firefly! Be careful not to free it."),
    nl, !.

use_object(magnet, X) :-
    metal(X),
    holding(magnet),
    i_am_at(Place),
    at(X, Place),
    retract(at(X, Place)),
    assert(holding(X)),
    write("Great! You managed to pick up "),
    write(X), nl.

/* rule for easier picking up various journals */

is_journal(burned_journal).
is_journal(old_journal).
is_journal(big_journal).

/*rules about what objects are metal*/

metal(key).
