/* Spells available in the game */
spell(light, firefly).
spell(open, key).

/* @TODO: Connect somehow with a room */
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

cast_at_place(light, Place) :-
    obscured(Place),
    cast(light, firefly),
    i_am_at(Place),
    retract(obscured(Place)),
    write("The room has been instantaneously illuminated!"), !.

cast_at_place(_, _) :-
    write("Not so useful here."), nl.

/* Specific spells */
/* I am not sure If we can write the cast differently - not to overwrite the function
    If we don't check all the requirements here, then the unblock will work when we are not sure if e.g. someone is holding the key */
cast(open, key) :-
    i_am_at(room_6),
    blocked(room_5, room_6),
    holding(key),
    retract(blocked(room_5, room_6)),
    write('You hear a click sound and the doors are beginning to open slowly.'), nl, false.