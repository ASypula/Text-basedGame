/* to add obstacle logic to main game copy unlock, go and look rules. Add apropriate path, subroom, blocked and describe additional truths.*/

/* NEW */
/* These rules describe how to unlock room with obstacle. */

bypass :- 
        at(Item, Place),
        subroom(Place, UnlockedPlace),
        retract(at(Item, Place)),
        assert(at(Item, UnlockedPlace)),
        false.

bypass :-
        i_am_at(Place),
        subroom(Place, UnlockedPlace),
        retract(i_am_at(Place)),
        assert(i_am_at(UnlockedPlace)),
        retract(blocked(UnlockedPlace)),
        write("Obstacle removed"), !, nl.

bypass :- write('No obstacle to bypass here.'), nl.


/* These rules describe how to unlock closed path. */

unlock(Direction) :-
        i_am_at(Place),
        path(Place, Direction, There),
        (retract(blocked(Place, There)) ; retract(blocked(There, Place))), !,
        write('Unlocked'), nl.

unlock(_) :- write('Nothing to unlock here.'), nl.


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


/* These rules define the direction letters as calls to go/1. */

n :- go(n).

s :- go(s).

e :- go(e).

w :- go(w).


/* This rule tells how to move in a given direction. */
go(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        (blocked(Here, There) ; blocked(There, Here)), !,
        write('That path is blocked.'), nl.

go(Direction) :-  /* CHANGED HERE*/
        i_am_at(Here),
        path(Here, Direction, There),
        \+ blocked(There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

go(_) :-
        write("You can't go that way.").


/* This rule tells how to look about you. */

look :-         /* CHANGED HERE*/
        i_am_at(Place),
        describe(Place), !,
        describe_additional(Place), nl,
        notice_objects_at(Place),
        nl.


/* These rules set up a loop to mention all the objects in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* This rule prints inventory contents */

inventory :- write('Your objects:'), nl, fail.
inventory :-
        holding(Item),
        write('    '), write(Item), nl, false.

inventory :- nl.


/*default describe outputs */

describe(_) :- write('[No description for this room yet]').
describe_additional(_) :- true.