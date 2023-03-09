/* Room description */
look(room_3) :-
    write('Junk Room - The room is covered by unnatural magical darkness, your lantern cannot illuminate.'), nl,
    write('You stumble upon various object scattered on the floor, but there is no way to distinguish whether any of them may be usefull.'), nl,
    write('By touch you find passage north east and west.'), nl.

hint(room_3) :-
    write('[when you cast light you can find usefull objects here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
notice_objects_at(room_3) :-
    write('@TODO'), nl.