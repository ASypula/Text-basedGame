:- multifile describe/1.

/* Room description */
describe(room_1) :-
    write('You see an exit but... it is guarded by bloodthirsty beast!'), nl.

hint(room_1) :-
    write('[It seems there is no hint here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_1) :-
    false.
