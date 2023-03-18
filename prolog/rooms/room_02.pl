/* Room description */
describe(room_2) :-
    write('Beneath the trapdoor - First room. Walls are smooth. On the ceiling far above there is trapdoor, you were tossed here through.'), nl,
    write('There is a slightly open door on the east wall.'), nl,
    write('There is a skeleton in wizard robes.'), nl.

hint(room_2) :-
    write('[It seems there is no hint here]'), nl.

/* Room setup */
at(old_journal, room_2).
shut(trapdoor).

/* Objects */
describe_additional(room_2) :-
    at(old_journal, room_2),
    write('You see a journal near the skeleton in wizard robes'), nl, false.

describe_additional(room_2) :-
    \+ shut(trapdoor),
    write('Now the trapdoor is wide open and you can see light coming through it.'), nl, false.
