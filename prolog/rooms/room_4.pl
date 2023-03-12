:- multifile describe/1.
:- multifile describe_additional/1.
:- multifile hint/1.

/* Room description */
describe(room_4) :-
    write('Acid Pool - A the center of the large room there is acid pool. It expands from east to west wall and is to wide to jump over it.'), nl,
    write('On the north side of acid pool there are passages north and west. On the south side there is passage south.'), nl.

hint(room_4) :-
    write('[It seems there is no hint here]'), nl.

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_4) :-
    at(firefly, room_4),
    write('Over the pool fly some weird glowing bugs. They look simillar to fireflies.'), nl, false.

describe_additional(room_4) :-
    at(rope, room_4),
    write('On the south side of the pool there is a rope'), nl, false.