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
    is_size(Block, Size),
    write('The '), write(Size), write(' '), write(Block), write(' block is places on pedestal '), write(Position), write('.'), nl, false.

check :-
    i_am_at(room_7),
    placed(orange, 1), is_size(orange, big),
    placed(red, 2), is_size(red, big),
    placed(purple, 3), is_size(purple, small),
    placed(blue, 4), is_size(blue, big),
    placed(green, 5), is_size(green, big),
    write('Damn something is shaking! Is it? Is this a secret passage? It definitely looks like one!'), nl,
    write('You have discovered door on the south wall, congrats'), !, nl.

check :-
    i_am_at(room_7),
    write('You hear insanely loud thunders! It does not seem like you''ve managed to solve the riddle.'), nl,
    write('If you want to be able to hear anything else than your death, you had better give your all next time'), !, nl.

shrink(Block) :-
    i_am_at(room_7),
    is_block(Block),
    is_size(Block, big),
    retractall(is_size(Block, _)),
    assert(is_size(Block, small)),
    write('The '), write(Block), write(' produced some strange noises but you managed to shrink it.'), nl, !.

shrink(Block) :-
    i_am_at(room_7),
    is_block(Block),
    is_size(Block, small),
    write('Nothing has happened. Perhaps you cannot make an already small block even smaller...'), nl, !.

grow(Block) :-
    i_am_at(room_7),
    is_block(Block),
    is_size(Block, small),
    retractall(is_size(Block, _)),
    assert(is_size(Block, big)),
    write('Very bright light has emited from the '), write(Block), write(' block. After a while you notice that is bigger than before.'), nl, !.

grow(Block) :-
    i_am_at(room_7),
    is_block(Block),
    is_size(Block, big),
    write('Nothing has happened. Perhaps you cannot make an already big block even bigger...'), nl, !.
