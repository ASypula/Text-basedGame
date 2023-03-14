:- dynamic obscured/1.

/* Room description */
describe(room_3) :-
    obscured(room_3),
    write('Junk Room - The room is covered by unnatural magical darkness, your lantern cannot illuminate.'), nl,
    write('You stumble upon various object scattered on the floor, but there is no way to distinguish whether any of them may be useful.'), nl,
    write('By touch you find passage north, east and west.'), nl.

describe(room_3) :-
    write('Now, when the light provides better visibility, you can distinguish various objects littering the floor.'), nl, 
    write('One of them in particular draws your attention... a beige pile of something but you need to look closer to name it.'), nl,
    write('Now the possible exits are more clearly visible: three different passages leading north, east and west.'), nl.

hint(room_3) :-
    write('[when you cast light you can find useful objects here]'), nl.

/* Room setup */
obscured(room_3).
at(rope, room_3).
path(room_3, w, room_2).
path(room_3, n, room_4).
path(room_3, e, room_16).

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_3) :-
    at(rope, room_3),
    \+ obscured(room_3),
    write('You were right! It''s a bunch of material, a rope.'), nl, false.

describe_additional(room_3) :-
    obscured(room_3),
    write('It''s too dark to see anything.'), 
    nl, !.
