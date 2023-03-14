/* Room description */
describe(room_1) :-
    write('Exit - On the north side of a room you see big golden door with "exit" engraved on them. Unfortunately it is guarded by a beast.'), nl,
    write('It has a body of a lion but is definitely bigger than a normal animal. The head belongs to deceptively beautiful woman with blue eyes and cruel smile.'), nl,
    write('The beast rises its double scorpion tail as if already prepared to attack.'), nl,
    write('The only slightly amusing thing about it is a big, metal, old-fashioned school staff badge attached to its fur.'), nl,
    write('The room is filled with skeletons in wizard apprentice robes.'), nl,
    write('You can still back off to the south.'), nl.

/*@TODO do we want to add such a powerful hint here?*/
hint(room_1) :-
    write('[You can cast power word kill on it to bypass it or use magnet on a badge and then cast sleep.]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_1) :-
    at(_, _),
    write('Nothing...'), nl, false.
