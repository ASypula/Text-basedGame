/* Room description */
describe(room_16) :-
    write('You enter a vast, cluttered room. You have to maneuver between shelves, crates and tables to move around.'), nl,
    write('Exits are on the west and north wall.'), nl,
    write('The room is filled with jars, bottles and glass aparature.'), nl.

hint(room_16) :-
    write('[An appropriate spell or something magnetic would help with obtaining the key.]'), nl.

/* Room setup */
at(potion, room_16).
at(jar, room_16).
at(key, room_16).


/* Objects */
describe_additional(room_16) :-
    at(potion, room_16),
    write('Only one of the bottles appears to have something in it.'), nl, false.

describe_additional(room_16) :-
    at(key, room_16),
    nl, 
    write('As you look around the room you notice something shiny between floor tiles, but you cannot grab it with your fingers. '),
    write('Some sort of jewellery? Or maybe a key?'), 
    nl, false.
