/* rules about puzzles */
put(Block, Position) :-
    i_am_at(room_7),
    is_block(Block),
    is_position(Position),
    retractall(placed(Block, _)),
    assert(placed(Block, Position)),
    write('You''ve put the '), write(Block), write(' block on pedestal '), write(Position), write('.'), !, nl.

check :-
    i_am_at(room_7),
    placed(Block, Position),
    write('The '), write(Block), write(' block is places on pedestal '), write(Position), write('.'), nl, false.

check :-
    i_am_at(room_7),
    placed(orange, 1),
    placed(red, 2),
    placed(purple, 3),
    placed(blue, 4),
    placed(green, 5),
    write('Damn something is shaking! Is it? Is this a secret passage? It definitely looks like one!'), nl,
    write('You have discovered door on the south wall, congrats'), !, nl.

check :-
    i_am_at(room_7),
    write('You hear insanely loud thunders! It does not seem like you''ve managed to solve the riddle.'), nl,
    write('If you want to be able to hear anything else than your death, you had better give your all next time'), !, nl.