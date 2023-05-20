module ObjectsSetup where

import Types


objectDescription :: [Object] -> [String]
objectDecription [] = ["You don't hold such object"]
objectDescription (obj: _) =
  case objectName obj of
     "lantern" -> 
                 ["Your good trusty lantern. You will need it until you finally get a hold of light spell."]
     "old_journal" -> 
                     ["I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."]
     "firefly" ->
                 ["Small, light-emitting beetles. Their light might not be very strong, but If reinforced..."]
     "burned_journal" ->
                        ["[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting 'grab' on it's tail would be funnier. Besides I don't have nightcap for [illegible] spell"]
     "jar" ->
             ["Old jar with a lid. Could be used for storing something small."]
     "key" ->
             ["Small iron key fit more for pendants than doors or chests. (hint: spell component)"]
     "rusty_key" ->
             ["Small iron key fit more for pendants than doors or chests. It should be shiny but you have bathed it in acid so..."]
     "cheat_sheet" ->
                     ["light spell: pros: easy, efficient, stays for a long time; cons: requires life component",
                     "grab spell: pros: nearly anything will do as a component. Just needs to be long; cons: beasts hate it for some reason. It is nearly impossible to cast it near them",
                     "sleep spell: pros: useful to avoid combat; cons: doesn't work on school staff for some reason, If casted on self, you cannot wake up."]
     "magnet" ->
                ["Medium size magnet with carved initials."]
     "rope" ->
              ["Old tattered rope. You wouldn''t trust it to hold your weight.",
              "But it's quite long. You can't throw it too far but maybe you can grab something with a help of some spell?"]
     "potion" ->
                ["You recognise it from your alchemy classes (the only ones that you pass). This is a Far Jump Potion.",
                "You can use it to jump very far, but only once."]
     "nightcap" ->
                  ["It doesn't look too fashionable, but kind of comfy. (hint: spell component)"]
     "note" ->
              ["The code is the year of the Worm Spell disaster.", "You'd better provide the code in the form password_xxxx... Wrong code might have its own consequences."]
     "book_fragment" ->
                       ["There is a more powerful variant of 'open' spell that uses rusty key as a component, which is proven to...",
                       "The words 'more', 'powerful' and 'rusty' are underlined and next to them there is a handwritten note 'Dumb as hell'."]
     "ripped_page" ->
                     ["The Open spell is giving me a hard time. I have no idea how to cast it's a more powerful version so northen door is inaccessible to me.",
                     "I might have a chance with southern door but I have to be careful anyway. With how sloppy my spellcasting is the door might as well lock again just after I get in.",
                     "I have to move on so I'm going to risk it. Wish me luck."]
     "ripped_journal" ->
                        ["My Open spell was so bad my spell component shattered. I am stuck here. I didn't even have a chance to try to enter the code to that machinery.",
                        "I wasn't very good at History of Magic but I think Morris Worm Spell disaster was in 1998 or 1988."]
     "beer" ->
              ["You are a student who failed an exam. There must be beer somewhere in the game."]
     "wolfsbane" ->
                   ["A solid bunch of wolfsbane. Good that you aren't a werewolf."]
     "badge" ->
               ["It has 'School staff member' written on it. It also emits some kind of protection aura."]
     _ ->
         ["Sorry, it's some unknown object. We don't know what to say about it..."]

-- TODO: add jar holding(firefly) mechanism