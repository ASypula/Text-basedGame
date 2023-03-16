/* Spells available in the game */
spell(light, firefly).
spell(grab, rope).
spell(open, key).

/* there will be rule named like "spell_in_room" and it will take spell name and rule. The spell_in_room would be described in each room file if there is useful spell to cast there. Default would be something like "This spell can't help you here".
In the "cast" rule after checking if correct component is held the spell_in_room would be checked with room you are currently in as second argument. */

cast(Spell_name, Component) :-
    spell(Spell_name, Component),
    holding(Component), 
    i_am_at(Place),
    cast_at_place(Spell_name, Place), !.

cast(Spell_name, Component) :-
    spell(Spell_name, Component),
    \+ holding(Component), 
    write("You don't have that component"), nl, !.

cast(Spell_name, _) :-
    spell(Spell_name, _),
    write("This is not right component for this spell. No wonder you failed your exams."), nl, !.

cast(_, _) :-
    write("Don't know such spell."), nl.

/* Specific spells */

cast_at_place(light, Place) :-
    obscured(Place),
    i_am_at(Place),
    retract(obscured(Place)),
    write("The room has been instantaneously illuminated!"), nl,
    look, !.

cast_at_place(grab, room_16) :-
    retract(at(key, room_16)),
    assert(holding(key)),
    write("With the help of the Grab Spell you pick up a key."), nl, !.

cast_at_place(grab, room_4S) :-
    retract(at(nightcap, room_4N)),
    assert(holding(nightcap)),
    write("With the help of the Grab Spell you pick up a nightcap over the acid pool."), nl, !.


cast_at_place(open, room_4) :-
    blocked(room_5, room_4),
    retract(blocked(room_5, room_4)),
    write('You hear a click sound and the doors are beginning to open slowly.'), nl, !.

cast_at_place(open, room_4N) :-
    blocked(room_5, room_4),
    retract(blocked(room_5, room_4N)),
    retract(blocked(room_5, room_4)),
    write('You hear a click sound and the doors are beginning to open slowly.'), nl, !.

cast_at_place(_, _) :-
    write("Not so useful here."), nl.
