/* Room description */
describe(room_7) :-
    write('This room has weird magical sigils on the walls on some scratches on the ceiling.'), nl,
    write('You recognise them as symbols allowing to cast specific transmutation spells without components, but can''t recall which.'), nl,
    write('There are 5 pedestals in a line, with letters from a (most left) to e (most right).'), nl,
    write('In the room there are also 5 blocks in different colors - red, green, blue, purple and orange. The red, blue and purple are small. Green and orange are bigger.'), nl,
    write('All of these block are placed on some other pedestal with letter t on it (probably t like trash).'), nl,
    write('The only visible exit is on the west wall.'), nl.

hint(room_7) :-
    write('[You can put blocks on pedestals using put(color, pedestal)]'), nl,
    write('[To solve the riddle you have to set right sizes to blocks and put them on correct pedestals.'), nl.

/* Room setup */
at(big_journal, room_7).

blocked(room_8).

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
    at(big_journal, room_7),
    write('There is a comedicly big journal here. Under it there is squished little skeleton wearing small wizard hat.'), nl, false.