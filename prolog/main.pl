/* <The name of this game>, by <your name goes here>. */

:- dynamic
        i_am_at/1,
        at/2,
        holding/1.

:-
        retractall(at(_, _)),
        retractall(i_am_at(_)),
        retractall(alive(_)).

:-
        ensure_loaded(rooms/room_1),
        ensure_loaded(rooms/room_2),
        ensure_loaded(rooms/room_3),
        ensure_loaded(rooms/room_4),
        ensure_loaded(rooms/paths),
        ensure_loaded(rooms/blocked_paths),
        ensure_loaded(rules/rules),
        ensure_loaded(objects),
        ensure_loaded(spells).

i_am_at(room_2).
