/* Room description */
describe(room_7) :-
    write('This room has weird magical sigils on the walls and some scratches on the ceiling.'), nl.

hint(room_7) :-
    write('[You can put blocks on pedestals using put(color, pedestal)]'), nl,
    write('[To solve the riddle you have to set right sizes to blocks and put them on correct pedestals.'), nl.

/* Room setup */
at(big_journal, room_7).

/* Puzzle set up*/
is_block(red).
is_block(green).
is_block(blue).
is_block(purple).
is_block(orange).

is_size(red, small).
is_size(green, big).
is_size(blue, small).
is_size(purple, small).
is_size(orange, big).

is_position(a).
is_position(b).
is_position(c).
is_position(d).
is_position(e).

placed(red, t).
placed(green, t).
placed(blue, t).
placed(purple, t).
placed(orange, t).

/* Objects */
describe_additional(room_7) :-
    \+ holding(big_journal),
    write('You recognise them as symbols allowing to cast specific transmutation spells without components, but can''t recall which.'), nl, false.

describe_additional(room_7) :-
    blocked(room_8),
    write('The only visible exit is on the west wall.'), nl,
    write('There are 5 pedestals in a line, with letters from a (most left) to e (most right). There is also a pedestal with letter t on it (probably t like trash).'), nl,
    describe_pedestals, false.

describe_additional(room_7) :-
    \+ blocked(room_8),
    write('There are 2 exists. The only visible exit is on the west wall.'), nl,
    write('There is also the hidden passage to the south - the one you have discovered by solving the riddle.'), nl, false.

describe_additional(room_7) :-
    at(big_journal, room_7), 
    write('There is a comedically big journal there. Under it, squished, lays comedically small skeleton wearing a tiny wizard hat.'), nl, false.