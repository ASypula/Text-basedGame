/* Spells available in the game */
spell(light, firefly).
spell(grab, rope).
spell(open, key).
spell(open, rusty_key).
spell(sleep, nightcap).
spell(power_word_kill, wolfsbane).

/* There will be rule named like "spell_in_room" and it will take spell name and rule. The spell_in_room would be described in each room file if there is useful spell to cast there. Default would be something like "This spell can't help you here".
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

cast_at_place(open, room_2) :-
    holding(rusty_key),
    shut(trapdoor),
    retract(shut(trapdoor)),
    write('With the more powerful version of Open Spell even the trapdoor opens!'), nl,
    write('Now let''s figure out how to reach it...'), nl, !.

cast_at_place(open, room_2) :-
    \+ holding(rusty_key),
    shut(trapdoor),
    write('This won''t do. The basic Open Spell can barely open doors. No way it would open a trapdoor.'), nl, !.

cast_at_place(sleep, room_14S) :-
    blocked(room_14),
    bypass(room_14),
    write('You put the dragonling to magical sleep. Now it looks more cute than threatening.'), nl, look, !.
    
cast_at_place(sleep, room_14W) :-
    blocked(room_14),
    bypass(room_14),
    write('You put the dragonling to magical sleep. Now it looks more cute than threatening.'), nl, look, !.
    
cast_at_place(open, room_11) :-
    holding(rusty_key),
    blocked(room_11, room_12), 
    retract(blocked(room_11, room_12)),
    write('That was smart! Special key did the magic and the doors are ajar now.'), !.

cast_at_place(open, room_11) :-
    blocked(room_11, room_12),
    \+ blocked(room_11, room_13),
    write('This mechanic lock seems to be immune to such delicate magic.'), nl, 
    write('Maybe you should try something stronger?'), nl, !.

cast_at_place(open, room_11) :-
    blocked(room_11, room_13),
    retract(blocked(room_11, room_13)),
    write('The smaller doors emit a loud, creaking sound and you wonder If they are not going to collapse...'), nl, 
    write('But fortunately they start opening up, it must have been those rusty hinges.'), nl, !.

cast_at_place(sleep, room_1) :-
    sleep_immunity(beast),
    write('The beast stays awake and untouched as if it was immune or something was dispelling this enchantment...'), nl, !.


cast_at_place(sleep, room_1) :-
    sleep_immunity(beast),
    write('The beast looks at you in disbelief before collapsing to the ground. It starts snoring loudly. The exit is left unguarded.'), nl,
    end_game, nl, ending(b),nl, outro, nl, !.

cast_at_place(power_word_kill, room_1) :-
    sleep_immunity(beast),
    write('The beast looks at you in disbelief before collapsing to the ground. It doesn''t move ever again. The exit is left unguarded.'), nl,
    end_game, nl, ending(a),nl, outro, nl, !.

cast_at_place(power_word_kill, room_14) :-
    write('It''s already asleep. Casting that spell would just be cruel.'), nl, !.

cast_at_place(power_word_kill, room_14S) :-
    write('The dragonling may be dangerous but it looks so helpless in a face of such spell.'), nl,
    write('You don'' really want to kill it. Maby there is some gentler way.'), nl, !.

cast_at_place(power_word_kill, room_14W) :-
    write('The dragonling may be dangerous but it looks so helpless in a face of such spell.'), nl,
    write('You don'' really want to kill it. Maby there is some gentler way.'), nl, !.

cast_at_place(_, _) :-
    write("Not so useful here."), nl.
