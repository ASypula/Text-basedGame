/* <The name of this game>, by <your name goes here>. */

:- dynamic i_am_at/1, at/2, holding/1, blocked/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)), retractall(blocked(_)), retractall(holding(_)). /* CHANGED HERE*/
/*:- ensure_loaded(rooms/room_1), ensure_loaded(rooms/room_2), ensure_loaded(rooms/room_3), ensure_loaded(rooms/room_4).*/

/* to add obstacle logic to main game copy unlock, go and look rules. Add apropriate path, subroom, blocked and describe additional truths.*/

i_am_at(room1).

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

/* NEW */
/* These rules describe how to unlock closed path. */
unlock :- 
        at(Item, Place),
        subroom(Place, UnlockedPlace),
        retract(at(Item, Place)),
        assert(at(Item, UnlockedPlace)),
        false.

unlock :-
        i_am_at(Place),
        subroom(Place, UnlockedPlace),
        retract(i_am_at(Place)),
        assert(i_am_at(UnlockedPlace)),
        retract(blocked(UnlockedPlace)),
        write("Unlocked"), nl.

/* These rules describe how to pick up an object. */

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        write('OK.'),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.


/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */

go(Direction) :-  /* CHANGED HERE*/
        i_am_at(Here),
        path(Here, Direction, There),
        \+ blocked(There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-         /* CHANGED HERE*/
        i_am_at(Place),
        describe(Place), !,
        describe_additional(Place), nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


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

