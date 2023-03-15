/* Room description */
describe(room_6) :-
    write('Corridor filled with goblin skeletons. Looks like some mage defeated them, you can still sense magic in the air.'), nl,
    write('The corridor leads north. There is also an opening on the east side.'), nl.

hint(room_6) :-
    write('[It seems there is no hint here]'), nl.

/* Room setup */
at(magnet, room_6).

go(e) :-
    i_am_at(room_6),
    blocked(room_5, room_6),
    write('These doors seem to be locked.'), nl,
    write('There used to be a very useful spell for picking locks...'), nl,
    write('And If you remember correctly it required one additional object to succeed.'), nl, !.

/* Objects */
describe_additional(room_6) :-
    at(magnet, room_6),
    write('One of the goblins holds curious looking magnet.'), nl, false.
