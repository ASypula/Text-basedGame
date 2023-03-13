:- dynamic obscured/1.

obscured(room_3).
dark_room(room_3).

/* Room description */
describe(room_3) :-
    obscured(room_3),
    write('Junk Room - The room is covered by unnatural magical darkness, your lantern cannot illuminate.'), nl,
    write('You stumble upon various object scattered on the floor, but there is no way to distinguish whether any of them may be useful.'), nl,
    write('By touch you find passage north east and west.'), nl.

describe(room_3) :-
    \+ obscured(room_3),
    write('Now, when the light provides better visibility, you can distinguish various objects littering the floor.'), nl, 
    write("One of them in particular draws your attention... something polished, a magnet?"), nl.

hint(room_3) :-
    write('[when you cast light you can find useful objects here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_3) :-
    at(torch, room_3),
    \+ obscured(room_3),
    write('Something strange reflects the light of your torch.. is it a magnet?'), nl, false.

describe_additional(room_3) :-
    at(magnet, room_3),
    \+ obscured(room_3),
    write('You were right! This shiny thing is in fact the magnet.'), nl, false.

describe_additional(room_3) :-
    obscured(room_3),
    write("It's too dark to see anything."), 
    nl, !.
