/* Spells available in the game */
spell(light, firefly).

/* @TODO: Connect somehow with a room */
/* there will be rule named like "spell_in_room" and it will take spell name and rule. The spell_in_room would be described in each room file if there is useful spell to cast there. Default would be something like "This spell can't help you here".
In the "cast" rule after checking if correct component is held the spell_in_room would be checked with room you are currently in as second argument. */

cast(Spell_name, Component) :=
    spell(Spell_name, Component),
    holding(Component), 
    i_am_at(Place),
    cast_at_place(Spell_name, Place), !.

cast(Spell_name, Component) :=
    spell(Spell_name, Component),
    \+ holding(Component), 
    write("You don't have that component"), nl, !.

cast(_, _) :-
    write("Don't know such spell."), nl.

cast_at_place(light, dark_room) :-
    write("@TODO, write some outcome here."), !.

cast_at_place(_, _) :-
    write("Not so useful here."), nl.

/* @TODO: add more spells */
