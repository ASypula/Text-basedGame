/* Room description */
describe(room_7) :-
    write('This room has weird magical sigils on the walls.'), nl,
    write('You recognise them as symbols allowing to cast specific transmutation spells without components, but can''t recall which.'), nl,
    write('There are 5 pedestals in a line, numbered from 1 (most left) to 5 (most right).'), nl,
    write('In the room there are also 5 blocks in different colors - red, green, blue, purple and orange. The red, blue and purple are small. Green and orange are bigger.'), nl,
    write('The only visible exit is on the west wall.'), nl.

hint(room_7) :-
    write('[You can put blocks on pedestals using put(color, position)]'), nl,
    write('[To solve the riddle you have to set right sizes to blocks and put them on correct pedestals.'), nl.

/* Room setup */
at(big_journal, room_7).

/* Puzzle set up*/
is_block(red).
is_block(green).
is_block(blue).
is_block(purple).
is_block(orange).

is_position(1).
is_position(2).
is_position(3).
is_position(4).
is_position(5).

placed(red, 0).
placed(green, 0).

/* Objects */
describe_additional(room_7) :-
    at(big_journal, room_7),
    write('There is a comedicly big journal here. Under it there is squished little skeleton wearing small wizard hat.'), nl, false.