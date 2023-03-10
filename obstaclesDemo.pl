/* <The name of this game>, by <your name goes here>. */

:- dynamic i_am_at/1, at/2, holding/1, blocked/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)), retractall(blocked(_)), retractall(holding(_)). /* CHANGED HERE*/
/*:- ensure_loaded(rooms/room_1), ensure_loaded(rooms/room_2), ensure_loaded(rooms/room_3), ensure_loaded(rooms/room_4).*/

:- ensure_loaded(rules/rules).

/* to add obstacle logic to main game copy unlock, go and look rules. Add apropriate path, subroom, blocked and describe additional truths.*/

i_am_at(room1).
holding(lantern).

path(room1, n, blocked_room).
path(room1, n, blocked_roomS).
path(blocked_room, s, room1).
path(blocked_roomS, s, room1).

path(blocked_room, n, room2).
path(blocked_roomN, n, room2).
path(room2, s, blocked_room).
path(room2, s, blocked_roomN).

path(room1, s, room2).
path(room2, n, room1).

blocked(blocked_room). /* NEW */

at(orange, room1).
at(apple, room1).

at(rope, blocked_roomN).
at(bucket, blocked_roomS).

subroom(blocked_roomN, blocked_room). /* NEW */
subroom(blocked_roomS, blocked_room). 



/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(room1) :- write('You are in room1.'), nl.
describe(blocked_room) :- write('You are in blocked room. In the middle there is a deep pit. Over it hovers magical bridge conjured by debug command.'), nl.
describe(blocked_roomS) :- write('You are in blocked room. In the middle there is a deep pit. You are on the southern side of the pit.'), nl.
describe(blocked_roomN) :- write('You are in blocked room. In the middle there is a deep pit. You are on the northern side of the pit.'), nl.
describe(room2) :- write('You are in room2.'), nl.


/* These rules are to give conditional parts of rooms' descriptions. */ /* NEW */
describe_additional(blocked_room) :- at(rope, blocked_room), write('You see a rope on the northern side.'), nl, false.
describe_additional(blocked_room) :- at(bucket, blocked_room), write('You see a bucket on the southern side.'), nl, false.
describe_additional(blocked_roomS) :- at(rope, blocked_roomN), write('You see a rope on the other side.'), nl, false.
describe_additional(blocked_roomN) :- at(rope, blocked_roomN), write('You see a rope on this side.'), nl, false.
describe_additional(blocked_roomS) :- at(bucket, blocked_roomS), write('You see a bucket on this side.'), nl, false.
describe_additional(blocked_roomN) :- at(bucket, blocked_roomS), write('You see a bucket on the other side.'), nl, false.
describe_additional(_) :- true.

