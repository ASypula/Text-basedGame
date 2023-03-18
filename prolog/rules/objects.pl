/* Get information about objects */

investigate(lantern) :-
    write("Your good trusty lantern. You will need it until you finally get a hold of light spell."),
    nl, !.

investigate(journal) :-
    write("Be more specific about which journal. (To check out your invetory try command \"inventory\")."),
    nl, !.

investigate(old_journal) :-
    holding(old_journal),
    write("I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."),
    nl, !.

investigate(firefly) :-
    holding(firefly),
    write("Small, light-emitting beetles. Their light might not be very strong, but If reinforced..."),
    nl, !.

investigate(burned_journal) :-
    holding(burned_journal),
    write("[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting \"grab\" on it's tail would be funnier. Besides I don't have nightcap for [illegible] spell"),
    nl, !.

investigate(jar) :-
    holding(jar),
    write("Empty, a bit dusty jar."),
    nl, !.

investigate(key) :-
    holding(key),
    write("Small iron key fit more for pendants than doors or chests. (hint: spell component)"),
    nl, !.

investigate(cheat_sheet) :-
    holding(cheat_sheet),
    write('light spell: prons: easy, efficient, stays for a long time; cons: requires rare component'), nl,
    write("grab spell: prons: nearly anything will do as a component. Just needs to be long; cons: beasts hate it for some reason. It is nearly impossible to cast it near them"), nl,
    write("sleep spell: prons: usefull to aviod combat; cons: doesn't work on school staff fore some reason, If casted on self, you cannot wake up."), 
    nl, !.

investigate(magnet) :-
    holding(magnet),
    write("Medium size magnet with carved initials."),
    nl, !.    

investigate(rope) :-
    holding(rope),
    write("Old tattered rope. You wouldn't trust it to hold your weight."), nl,
    write("But it's quite long. I can't throw it too far but maybe I can grab something with a help of some spell?"),
    nl, !. 

investigate(potion) :-
    holding(potion),
    write('You recognise it from your alchemy classes (the only ones that you pass). This is a Far Jump Potion.'), nl,
    write('You can use it to jump very far, but only once.'), nl, !.

investigate(nightcap) :-
    holding(nightcap),
    write("It doesn't look too fashionable, but kind of comfy. (hint: spell component)"),
    nl, !. 

investigate(note) :-
    holding(note),
    write("The code is the year of the Worm Spell disaster."),
    write("You'd better provide the code in the form password_xxxx... Wrong code might have its own consequences."),
    nl, !. 

investigate(book_fragment) :-
    holding(book_fragment),
    write("There is a more powerful variant of 'open' spell that uses rusty key as a component, which is proven to..."), nl,
    write("The words 'more', 'powerful' and 'rusty' are underlined and next to them there is a handwritten note 'Dumb as hell'."),
    nl, !. 

investigate(big_journal) :-
    holding(big_journal),
    write('I''ve finally decoded the runes on the wall! Some of them allow casting grow, shrink spells (grow(color). and shrink(color).).'), nl,
    write('Others form some kind of a riddle. Good thing that I listened during rune theory lectures. It roughly translates as:'), nl,
    write('1. Red is the same size as Orange.'), nl,
    write('2. Red has both small and big neighbour.'), nl,
    write('3. Purple is small.'), nl,
    write('4. Red and Blue are both next to their colour mix.'), nl,
    write('5. Their size has symmetry about the middle block.'), nl,
    write('6. Blue doesn''t have any small blocks on it''s right.'), nl,
    write('7. Red is more to the left than Green is.'), nl,
    write('\'Oh, and there 2 more things. I believe that spell put(color, pedestal) should move the blocks.'), nl,
    write('And finally I have discovered that the scratches on the ceiling form a word - incomplete but a word: c*eck. Unfortunately, I don''t know what to do with it...'),
    nl, !. 

investigate(ripped_page) :-
    holding(ripped_page),
    write("The Open spell is giving me a hard time. I have no idea how to cast it's a more powerful version so northen door is inaccessible to me."), nl,
    write("I might have a chance with southern door but I have to be careful anyway. With how sloppy my spellcasting is the door might as well lock again just after I get in."), nl,
    write("I have to move on so I'm going to risk it. Wish me luck."),
    nl, !. 

investigate(ripped_journal) :-
    holding(ripped_journal),
    write("My Open spell was so bad my spell component shattered. I am stuck here. I didn't even have a chance to try to enter the code to that machinery."), nl,
    write("I wasn't very good at History of Magic but I think Morris Worm Spell disaster was in 1998 or 1988."),
    nl, !. 

investigate(wolfsbane) :-
    holding(wolfsbane),
    write("A solid bunch of wolfsbane. Good that you aren't a warewolf."),
    nl, !. 

investigate(beer) :-
    holding(beer),
    write("You are a student who failed an exam. There must be beer somewhere in the game."),
    nl, !. 

investigate(lantern) :-
    write("Your good trusty lantern. You will need it until you finally get a hold of light spell."),
    nl, !.

investigate(_) :-
    write('Nothing to describe. Object is not in your inventory'), nl.

/* Specific take actions with objects */

take(journal) :-    /* allows the user to take the correct journal in present room */
    is_journal(Journal),
    i_am_at(Place),
    at(Journal, Place),
    take(Journal), !.


take(firefly) :-
    i_am_at(Place),
    at(firefly, Place),
    write("Hmmm If only you could use something to catch it in."), nl,
    !.

take(key) :-
    i_am_at(room_16),
    write("Sorry, you are not able to easily pick up the key. Think of a different solution."), nl,
    !.

take(nightcap) :-
    i_am_at(Place),
    at(nightcap, Place),
    write('That trouble was worth it. Now you posses a velvet-like nightcap.'), nl, false.

take(nightcap) :-
    i_am_at(room_4S),
    at(nightcap, room_4N),
    write('You are sure, you would like to go swimming in the acid pool?'), 
    nl, !.

take(magnet) :-
    write('Extracting the magnet from the goblin skeleton was not easy, and definitely not pleasurable.'), nl,
    write('But maybe something that can attract metals might come in handy.'), nl, false.

take(note) :-
    write('Ugh, the note must have been here for ages, I have never seen such a thick layer of dust.'), nl, false.

/* These rules describe specific use_object actions */

use_object(jar, firefly) :-
    holding(jar),
    i_am_at(Place),
    at(firefly, Place),
    assert(holding(firefly)),
    write("Wow! You managed to grab a firefly! Be careful not to free it."),
    nl, !.

use_object(magnet, X) :-
    metal(X),
    holding(magnet),
    i_am_at(Place),
    at(X, Place),
    retract(at(X, Place)),
    assert(holding(X)),
    write("Great! You managed to pick up "),
    write(X), write("."), nl, !.

use_object(potion, acid_pool) :-
    holding(potion),
    i_am_at(room_4S),
    write("That was a really loooooong jump."),
    retract(holding(potion)),
    assert(i_am_at(room_4N)),
    retract(i_am_at(room_4S)),
    nl, !.

use_object(potion, acid_pool) :-
    holding(potion),
    i_am_at(room_4N),
    write("That was a really loooooong jump."),
    retract(holding(potion)),
    assert(i_am_at(room_4S)),
    retract(i_am_at(room_4N)),
    nl, !.

use_object(potion, pool) :- use_object(potion, acid_pool), !.

use_object(potion, self) :- 
    (i_am_at(room_4N) ; i_am_at(room_4S)),
    use_object(potion, acid_pool), !.

use_object(potion, myself) :- 
    (i_am_at(room_4N) ; i_am_at(room_4S)),
    use_object(potion, acid_pool), !.

use_object(key, acid) :-
    holding(key),
    (i_am_at(room_4) ; i_am_at(room_4N) ; i_am_at(room_4S)),
    retract(holding(key)),
    assert(holding(rusty_key)),
    write('You dip your tiny key in the pool and instantly hear ominous sizzling noise. As you retract your hand you see that your key is now rusty.'), nl,
    write('You picked up rusty_key.'), nl, !.

use_object(key, acid_pool) :- use_object(key, acid), !.

use_object(key, pool) :- use_object(key, acid), !.

use_object(potion, trapdoor) :-
    holding(potion),
    i_am_at(room_2),
    \+ shut(trapdoor),
    write('You take a sip from the bottle and spring into the air, hoping to reach the trapdoor.'), nl,
    write('You grab the edge of the opening and pull yourself up. You are finally free.'), nl,
    end_game, nl, ending(c),nl, outro, nl, !.

use_object(potion, myself) :- 
    i_am_at(room_2),
    use_object(potion, trapdoor), !.

use_object(potion, self) :-
    i_am_at(room_2),
    use_object(potion, trapdoor), !.


/* rule for easier picking up various journals */

is_journal(burned_journal).
is_journal(old_journal).
is_journal(big_journal).
is_journal(ripped_journal).

/* rules about which objects are metal*/
metal(key).

/* rules for unlocking machinery */
enter(password_1988) :-
    i_am_at(room_5),
    blocked(room_4),
    blocked(room_11, room_12),
    unlock4, unlock11_12, !.

enter(password_1988) :-
    i_am_at(room_5),
    blocked(room_4),
    unlock4, !.

/*@TODO should we hint where to look for the hint with the password?*/
enter(_) :-
    i_am_at(room_5),
    blocked(room_4),
    write('Nope, it''s not the correct code.'), nl,
    write('You can try guessing, but you don''t know If it won''t be your last one...'), nl, 
    write('Maybe start searching for some hints?'), nl, !.

enter(_) :-
    write('This action will not help you now.'), nl, !.

unlock4 :-
    bypass(room_4),
    write('Congratulations! You managed to guess the password!'), nl,
    write('Or maybe you knew which was the year of Morris worm...'), nl,
    write('Noooo, that''s impossible.'), nl,
    write('Accidentally the floor starts to shake slightly and you hear a strange sound.'), nl,
    write('As if some machinery was being laid over a terrain.'), nl,
    write('Your intuition tells you the sounds came from the room with the acid pool.'), nl.

unlock11_12 :-
    retract(blocked(room_11, room_12)),
    write('There was also another sound after that. It seemed to originate further away though.'), nl.