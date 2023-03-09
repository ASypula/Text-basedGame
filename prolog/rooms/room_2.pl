/* Room description */
look(room_2) :-
    write('Beneath the trapdoor - First room. Walls are smooth. On the celling far above there is trapdoor, you were tossed here through.'), nl,
    write('There is a skeleton in wizard robes and a journal.'), nl,
    write('There are a slightly open door on the east wall.'), nl.

hint(room_2) :-
    write('[It seems there is no hint here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
notice_objects_at(room_2) :-
    write('@TODO'), nl.
