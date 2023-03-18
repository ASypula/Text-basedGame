/* These rules define interaction with the Undead Student */
interact :-
    i_am_at(room_8),
    visited_previously(a),
    retractall(visited_previously(a)),
    assert(visited_previously(b)),
    write('\"Oh another lost student.\" it says. \"Don''t be afraid, I was once just like you - a lost student.\"'), nl,
    write('\"I believe we can help each other. I found many secrets in this hidden library but unfortunately became bound to it.\"'), nl,
    write('\"I know a spell to defeat the beast but it is no use to me. I will share it with you, but first you need to bring me... a beer. As a memorial of my past.\"'), nl,
    write('\"Some students sneak beer in here, it should be possible to find some.\"'), nl, !.

interact :-
    i_am_at(room_8),
    visited_previously(b),
    write('\"So, do you have it?\" Its empty eye sockets look at you menacingly.'), nl, !.


interact :-
    i_am_at(room_8),
    visited_previously(c),
    write('\"The spell name is power_word_kill and the component is a bunch of wolfsbane.\"'), nl, !.

use_object(beer, _) :-
    i_am_at(room_8),
    holding(beer),
    visited_previously(b),
    retractall(holding(beer)),
    retractall(visited_previously(b)),
    assert(visited_previously(c)),
    write('\"Ah it''s been a while. I probably can''t taste it now though...\"'), nl,
    write('\"Anyway the spell name is power_word_kill and the component is a bunch of wolfsbane.\"'), nl, !.
