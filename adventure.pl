/* <The name of this game>, by <your name goes here>. */

:- dynamic i_am_at/1, at/2, holding/1, blocked/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)), retractall(blocked(_)), retractall(holding(_)).
/*:- ensure_loaded(rooms/room_1), ensure_loaded(rooms/room_2), ensure_loaded(rooms/room_3), ensure_loaded(rooms/room_4).*/

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

blocked(blocked_room).

at(orange, room1).
at(apple, room1).

at(rope, blocked_roomN).

unlock :- 
        at(rope, blocked_roomN),
        retract(at(rope, blocked_roomN)),
        assert(at(rope, blocked_room)),
        retract(blocked(blocked_room)),
        false.

unlock :-
        i_am_at(Place),
        retract(i_am_at(Place)),
        assert(i_am_at(blocked_room)),
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

go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        \+ blocked(There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write('You can''t go that way.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        !, nl,
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
describe(blocked_room) :- at(rope, blocked_room), write('You are in blocked room. In the middle there is a deep pit. You see a rope on the northen side.'), nl.
describe(blocked_roomS) :- at(rope, blocked_roomN), write('You are in blocked room. In the middle there is a deep pit. You see a rope on the other side.'), nl.
describe(blocked_roomN) :- at(rope, blocked_roomN), write('You are in blocked room. In the middle there is a deep pit. You see a rope on this side.'), nl.
describe(blocked_room) :- write('You are in blocked room. In the middle there is a deep pit.'), nl.
describe(blocked_roomS) :- write('You are in blocked room. In the middle there is a deep pit.'), nl.
describe(blocked_roomN) :- write('You are in blocked room. In the middle there is a deep pit.'), nl.
describe(room2) :- write('You are in room2.'), nl.

