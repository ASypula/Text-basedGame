/* Room description */
describe(room_15) :-
    write('Rather big room covered with soot spots. It has exits on south and north wall.'), nl,
    write('There is a soot covered skeleton here.'), !.

hint(room_15) :-
    write('[It seems there is no hint here]'), nl.

/* Room setup */
at(burned_journal, room_15).

/* Objects */
describe_additional(room_15) :-
    at(burned_journal, room_15),
    write(' Beside it, there is a partially burned journal.'), false.


describe_additional(room_15) :- nl, false.
