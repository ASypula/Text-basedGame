/* Room description */
describe(room_8) :-
    write('The hidden room is filled with books and oracle orbs. It is illuminated by mistical blue light.'), nl,
    write('In the centre of the room stands a skeleton wearing very old tattered hat with "Maggus" on it.'), nl,
    write('Suddenly the skeleton moves and gestures you to come closer.'), nl.

hint(room_8) :-
    write('[Use interact. to speak with the student.]'), nl.

/* Interaction with undead student */
visited_previously(a). /* a = means not visited previously, b = means visited previously, c = means no further interaction possible */

