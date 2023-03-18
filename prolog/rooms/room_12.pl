/* Room description */
describe(room_12) :-
    obscured(room_12),
    write('It''s strange. You''ve just walk into this room and just by being in here you feel some pain.'), nl.

describe(room_12) :-
    \+ obscured(room_12),
    write('The room is of a medium size. You see many normal and magical herbs and flowers growing here.'), nl.

hint(room_12) :-
    write('[Try using light spell here]').

/* Room setup */
obscured(room_12).
at(wolfsbane, room_12).

describe_additional(room_12) :-
    at(wolfsbane, room_12),
    \+ obscured(room_12),
    write('The wolfsbane catches your eye.'), nl,
    write('And now you see the thorns are because roses grow... black roses but you remember from your herbology lectures that they are not harmfull until you eat them. You have a lot of luck this time.'), nl, false.

describe_additional(room_12) :-
    obscured(room_12),
    write('The room is very dark and smells of dirt and herbs. After even one step in you get scratched by thorns. Let''s hope that wasn''t anything poisonous.'), nl,
    write('There is no way to safely explore this room without magical light.'), nl.