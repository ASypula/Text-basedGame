/* Room description */
describe(room_11) :-
    write('You are in a long corridor going east and west. In the middle it has two doors in front of each other.'), nl,
    write('The corridor is stained with soot in some places.'), nl.

hint(room_11) :-
    write('[It seems there is no hint here]'), nl.

/* Room setup */
at(ripped_page, room_11).

/* Objects */
describe_additional(room_11) :-
    blocked(room_11, room_12),
    write('The north door is bigger and clearly locked using techno-magic.'), nl, false.

describe_additional(room_11) :-
    blocked(room_11, room_13),
    write('The south door looks normal but is still locked by a regular lock.'), nl, false.

describe_additional(room_11) :-
    at(ripped_page, room_11),
    write('There is a ripped page here.'), nl, false.
