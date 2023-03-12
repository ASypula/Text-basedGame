/* Room description */
describe(room_3) :-
    write('Junk Room - The room is covered by unnatural magical darkness, your lantern cannot illuminate.'), nl,
    write('You stumble upon various object scattered on the floor, but there is no way to distinguish whether any of them may be usefull.'), nl,
    write('By touch you find passage north east and west.'), nl.

hint(room_3) :-
    write('[when you cast light you can find usefull objects here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_3) :-
    at(torch, room_3),
    write('Something strange reflects the light of your tourch.. is it a magnet?'), nl, false.

describe_additional(room_3) :-
    at(magnet, room_3),
    write('You were right! This shiny thing is in fact the magnet.'), nl, false.