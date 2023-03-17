/* Room description */
describe(room_14) :-
    write('Now with the dragon not being an issue anymore you can freely traverse the corridor or plunder dragon''s treasure.'), nl,
    write('Corridor takes a turn here. You can go west or south.'), nl.

describe(room_14W) :-
    write('The corridor takes a turn here. You could go south but in the corner lies a dragonling. '),
    write('It guards a pile of student''s robes, books and cheat sheets and looks rather angry. Walls around it are covered in burn marks. '),
    write('You can also go back west.'), nl.

describe(room_14S) :-
    write('The corridor takes a turn here. You could go west but in the corner lies a dragonling. '),
    write('It guards a pile of student''s robes, books and cheat sheets and looks rather angry. Walls around it are covered in burn marks. '),
    write('You can also go back south'), nl.

hint(room_14) :-
    write('[You can pacify the dragon by casting Sleep on it.]'), nl.

/* Room setup */
at(cheat_sheet, room_14).
at(book_fragment, room_14).
at(beer, room_14).

subroom(room_14W, room_14). 
subroom(room_14S, room_14). 

go(w) :-
    i_am_at(room_14S),
    write('Getting burned alive by a cat-sized dragon doesn''t sound like a heroic death.'), nl, false.

go(s) :-
    i_am_at(room_4W),
    write('Getting burned alive by a cat-sized dragon doesn''t sound like a heroic death.'), nl, false.

