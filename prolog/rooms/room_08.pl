/* Room description */
describe(room_8) :-
    write('The hidden room is filled with books and oracle orbs. It is illuminated by mistical blue light.'), nl,
    write('In the centre of the room stands a skeleton wearing very old tattered hat with "Maggus" on it.'), nl,
    write('[Use interact. to speek with the student.]').


/* Interaction with undead student */
visited_previously(a). /* a = means not visited previously, b = means visited previously, c = means no further interaction possible */

describe_additional(room_8) :-
    at(old_journal, room_8),
    write('You see a journal near the skeleton in wizard robes'), nl, false.
