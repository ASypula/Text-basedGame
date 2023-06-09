/* "Escape from detention" by Aleksandra Sypuła, Eryk Sztanga and Mateusz Wasilewski. */

:- dynamic i_am_at/1, at/2, holding/1, blocked/1, blocked/2, visited_previously/1, shut/1, placed/2, is_size/2, sleep_immunity/1.
:- multifile([describe/1, describe_additional/1, take/1, use_object/2, hint/1, go/1, at/2, obscured/1, subroom/2, blocked/1, describe_pedestals/0, interact/0]).
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)), retractall(blocked(_)), retractall(blocked(_,_)), retractall(holding(_)). 

/*It is important that the rooms are loaded before rules, because in rooms there are more specific cases of some rules (ex. describe)*/
:- ensure_loaded([rooms/room_01, rooms/room_02, rooms/room_03, rooms/room_04, rooms/room_05]).
:- ensure_loaded([rooms/room_06, rooms/room_07, rooms/room_08, rooms/room_10, rooms/room_11]).
:- ensure_loaded([rooms/room_12, rooms/room_13, rooms/room_14, rooms/room_15, rooms/room_16]).

:- ensure_loaded([rooms/paths, rooms/blocked_paths]).

:- ensure_loaded([rules/spells, rules/objects, rules/puzzles, rules/undead_student]).
:- ensure_loaded(rules/rules).  /* this has to be included at the end in order not to obscure more specific rules */

i_am_at(room_2).
holding(lantern).

/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(object).      -- to pick up an object.'), nl,
        write('inventory.         -- to see all picked up objects.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('investigate(object).-- to take a closer look at an object.'), nl,
        write('use_object(object_to_use, use_on_what).-- to use an object on something.'), nl,
        write('cast(spell, component). -- to cast a spell using correct component.'), nl,
        write('interact.          -- to interact with sentient beings.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('hint.              -- to see hints for current location.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.

game_intro :-
        write('You are a wizard apprentice who failed their final exams, thus General University of magic put you in deadly dungeon.'), nl,
        write('Were you to escape, Wizard Council would let you retake exams.'), nl, nl.



/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        game_intro,
        look.
