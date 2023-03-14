/* Room description */
describe(room_4) :-
    write('Acid Pool - At the center of the large room there is an acid pool. It expands from east to west wall and is too wide to jump over it.'), nl,
    write('On the north side of acid pool there are passages north and west. On the south side there is a passage south.'), nl.

hint(room_4) :-
    write('[You can traverse the acid pool by using jump potion.]'), nl,
    write('[You can take nightcap from northen side or by using grab spell.]'), nl.

/* Room setup */
at(firefly, room_4).
at(nightcap, room_4).

/* Enemies */

/* Puzzles */

/* Objects */
describe_additional(room_4) :-
    at(firefly, room_4),
    write('Over the pool fly some weird glowing bugs. They look simillar to fireflies.'), nl, false.

describe_additional(room_4) :-
    at(nightcap, room_4),
    write('On the north side there is a skeleton wearing a nightcap. It lays in a very comfortable natural position, as if it just layed to eternal sleep here.'), nl, false.
