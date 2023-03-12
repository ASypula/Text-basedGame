/* <The name of this game>, by <your name goes here>. */

:- dynamic i_am_at/1, at/2, holding/1, blocked/1, blocked/2.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)), retractall(blocked(_)), retractall(blocked(_,_)), retractall(holding(_)). /* CHANGED HERE*/
:- multifile([describe/1, describe_additional/1]).
/*:- ensure_loaded(rooms/room_1), ensure_loaded(rooms/room_2), ensure_loaded(rooms/room_3), ensure_loaded(rooms/room_4).*/


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

path(room1, w, secret_room).
path(secret_room, e, room1).

blocked(room1, secret_room). /* NEW */

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


:- ensure_loaded(rules/rules).

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(object).      -- to pick up an object.'), nl,
        write('inventory.         -- to see all picked up objects.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('describe(object).  -- to take a closer look at an object.'), nl,
        write('use_object(object_to_use, use_on_what).-- to use an object on something.'), nl,
        write('cast(spell, component). -- to cast a spell using correct component.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        write('bypass.            -- debug command to bypass example obstacle in demo.'), nl,
        write('unlock(direction). -- debug command to unlock example blocked path in demo.'), nl,
        nl.



/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.