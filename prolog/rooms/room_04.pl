/* Room description */
describe(room_4) :-
    write('At the center of the large room there is a magical bridge, covering an acid pool. Congrats, this obstacle is not a problem any more.'), nl,
    write('On the north side of the late acid pool there are passages north and west. On the south side there is a passage south.'), nl.

describe(room_4N) :-
    write('Northern side of a large room with an acid pool at its center. It expands from east to west wall and is too wide to jump over it.'), nl,
    write('On your side there are two passages: north and west. On the southern side there is a passage south.'), nl.

describe(room_4S) :-
    write('Southern side of a large room with an acid pool at its center. It expands from east to west wall and is too wide to jump over it.'), nl,
    write('On your side there is one passages south. On the northern side there are two passages: north and west.'), nl.

hint(room_4) :-
    write('[You can traverse the acid pool by using jump potion.]'), nl.

hint(room_4N) :-
    write('[You can traverse the acid pool by using jump potion.]'), nl.

hint(room_4S) :-
    write('[You can traverse the acid pool by using jump potion.]'), nl,
    write('[You can take nightcap from northern side or by using grab spell.]'), nl.

/* Room setup */
at(firefly, room_4).
at(firefly, room_4N).
at(firefly, room_4S).
at(nightcap, room_4N).

subroom(room_4N, room_4). 
subroom(room_4S, room_4). 

go(n) :-
    i_am_at(room_4S),
    write("'You are sure, you would like to go swimming in the acid pool?'"), nl, false.

go(s) :-
    i_am_at(room_4N),
    write("'You are sure, you would like to go swimming in the acid pool?'"), nl, false.

go(w) :-
    i_am_at(room_4N),
    blocked(room_5, room_4),
    write('That door is locked.'), nl, false.

go(w) :-
    i_am_at(room_4),
    blocked(room_5, room_4),
    write('That door is locked.'), nl, false.

/* Objects */
describe_additional(room_4) :-
    write('Over the pool fly some weird glowing bugs. They look similar to fireflies.'), nl, false.

describe_additional(room_4) :-
    (at(nightcap, room_4N) ; at(nightcap, room_4)),
    write('On the north side there is a skeleton wearing a nightcap. It lays in a very comfortable natural position, as if it just layed to eternal sleep here.'), nl, false.

describe_additional(room_4N) :-
    write('Over the pool fly some weird glowing bugs. They look similar to fireflies.'), nl, false.

describe_additional(room_4N) :-
    (at(nightcap, room_4N) ; at(nightcap, room_4)),
    write('On your side there is a skeleton wearing a nightcap. It lays in a very comfortable natural position, as if it just layed to eternal sleep here.'), nl, false.

describe_additional(room_4S) :-
    write('Over the pool fly some weird glowing bugs. They look similar to fireflies.'), nl, false.

describe_additional(room_4S) :-
    (at(nightcap, room_4N) ; at(nightcap, room_4)),
    write('On the other side there is a skeleton wearing a nightcap. It lays in a very comfortable natural position, as if it just layed to eternal sleep here.'), nl, false.
