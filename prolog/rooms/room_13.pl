/* Room description */
describe(room_13) :-
    write('Inside there is a skeleton sitting in a corner. Next to it lays a broken jar with some dead insects inside.'), nl,
    write('Apart from that, the room is mostly filled with empty crates.'), nl,
    write('The door is on the north wall.'), nl.

hint(room_13) :-
    write('[Nothing complicated here. You should manage on your own.]'), nl.

/* Room setup */
at(ripped_journal, room_13).