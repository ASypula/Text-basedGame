/* Room description */
describe(room_5) :-
    write('The room is filled with techno-magic machinery. It is not considered difficult magic, but you overslept that exam and failed it anyway.'), nl,
    write('There is a door on the east wall.'), nl.

hint(room_5) :-
    write('[It seems there is no hint here]'), nl.

/* Room setup */
at(note, room_5).

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_5) :-
    blocked(room_4),
    write('There is a control panel but it is blocked by a 4 digit code password (use enter(password_xxxx). command).'), nl, false.

describe_additional(room_5) :-
    at(note, room_5),
    write('On the back of the control panel, there is a very old, dusty sticky note'), nl, false.
