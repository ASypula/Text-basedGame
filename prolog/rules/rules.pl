/* to add obstacle logic to main game copy unlock, go and look rules. Add apropriate path, subroom, blocked and describe additional truths.*/

/* NEW */
/* These rules describe how to unlock room with obstacle. */

bypass(LockedPlace) :- 
        blocked(LockedPlace),
        at(Item, Place),
        \+ at(Item, LockedPlace),
        subroom(Place, LockedPlace),
        retract(at(Item, Place)),
        assert(at(Item, LockedPlace)),
        false.

bypass(LockedPlace) :-
        blocked(LockedPlace),
        i_am_at(Place),
        subroom(Place, LockedPlace),
        retract(i_am_at(Place)),
        assert(i_am_at(LockedPlace)),
        false.

bypass(LockedPlace) :-
        blocked(LockedPlace),
        retract(blocked(LockedPlace)),
        write("Obstacle removed"), !, nl.

bypass(_) :- write('No obstacle to bypass here.'), nl.


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
        write('You picked up '),
        write(X), write("."),
        !, nl.

take(_) :-
        write('You don''t see it here or you can''t pick it up.'),
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
        write('You can''t go that way.').


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
        \+ obscured(Place),
        write('There is a '), write(X), write(' here.'), nl,
        false.

notice_objects_at(_).


/* This rule prints inventory contents */

inventory :- write('Your objects:'), nl, false.
inventory :-
        holding(Item),
        write('    '), write(Item), nl, false.

inventory :- nl.

/* This rule is a basic form and each room should implement it */
describe_additional(_) :-
    true.

/*default describe outputs */

describe(_) :- write('[No description for this room yet]').

use_object(Object, _) :-
        \+ holding(Object),
        write('You don''t have such object.'), nl, !.

use_object(_, _) :- write('Not helpful here.'), nl.


/* rules describing game end */
end_game :-
        i_am_at(Place),
        retract(i_am_at(Place)),
        retractall(holding(_)).



/* endings */
ending(a) :-
        write('You did it. You made it out alive. The exams surely can''t be worse than this. However there is something that might...'), nl,
        write('The High University of Magic was not thrilled with an idea of student actually getting out of their deadly dungeon.'), nl,
        write('The High Wizards were especially irritated about the loss of their favourite beast. You will have to settle this with the Dean of Magic himself.'), nl,
        write('You escaped the deadly dungeon only to start much more frightening battle - writing an official letter.'), nl.

ending(b) :-
        write('You did it. You made it out alive. '), nl,
        write('You used your wits to bypass the beast without fighting it and acquired authentic badge of the High University of Magic staff member.'), nl,
        write('You retake you exams and pass them with flying colors. You cannot stop thinking about that badge. What if it became trully yours? How about joining the staff?'), nl,
        write('The cursed badge slowly takes over you and before you realise it, your body is twisted into this new beastly form.'), nl,
        write('To your surprise, you retain your senses and consciousness. Teaching and research at University feels amazing, although you sometimes wish you had human hands again.'), nl.

ending(c) :-
        write('You did it. You made it out alive. '), nl,
        write('There wasn''t even a need of fighting the deadly beast. The escape through the trapdoor had some unforseen consequences though...'), nl,
        write('The University''s magical database system was not capable of processing your way of escaping and spectacularly collapsed.'), nl,
        write('Personal data of many wizards and apprentices were lost. With the new-arisen chaos there is no way the High Wizard Council will let you continue studies.'), nl,
        write('Good think that your data was also lost. You can change your name, bluff your way through and retake the whole year. You seem like you need that anyway.'), nl.

outro :- write('Thank you for playin our textgame.'), nl.