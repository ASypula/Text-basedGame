/*@TODO add possible paths and blockers */

/* Room description */
describe(room_1) :-
    write('Exit - On the north side of a room you see big golden door with "exit" engraved on them. Unfortunately it is guarded by a beast.'), nl,
    write('The room is filled with skeletons in wizard apprentice robes.'), nl,
    write('You can still back off to the south.'), nl, nl,
    write('The beast has a body of a lion but is definitely bigger than a normal animal.'), nl, 
    write('The head belongs to deceptively beautiful woman with blue eyes and cruel smile.'), nl,
    write('The beast rises its double scorpion tail as if already prepared to attack.'), nl.

hint(room_1) :-
    write('[No hint here...]'), nl.

/* Enemies */
sleep_immunity(beast).

/* Puzzles */

/* Objects */
describe_additional(room_1) :-
    sleep_immunity(beast),
    write('The only slightly amusing thing about it is a big, metal, old-fashioned school staff badge attached to its fur.'), nl, false.

