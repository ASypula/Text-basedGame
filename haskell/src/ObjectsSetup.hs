module ObjectsSetup where

import Types

objectDescription :: Object -> [String]
objectDescription object
    | name == "lantern"        = [
        "Your good trusty lantern. You will need it until you finally get a hold of light spell."]
    | name == "old_journal"    = [
        "I found the exit! It is to the north, but fierce beast guides it. I'm gonna await next student who's gonna fail their exams and team up with them against the beast."]
    -- | name == "firefly"        = [
    --     "Small, light-emitting beetles. Their light might not be very strong, but If reinforced..."]
    -- | name == "burned_journal" = [
    --     "[illegible] is giving me a hard time. I know the [illegible] spell would be a save way to deal with it, however casting \"grab\" on it's tail would be funnier.",
    --     "Besides I don't have nightcap for [illegible] spell."]
    -- | name == "jar"            = [
    --     "Empty, a bit dusty jar. Can be useful to store something."]
    -- | name == "key"            = [
    --     "Small iron key fit more for pendants than doors or chests. (hint: spell component)"]
    -- | name == "cheat_sheet"    = [
    --     "light spell: pros: easy, efficient, stays for a long time; cons: requires life component",
    --     "grab spell: pros: nearly anything will do as a component. Just needs to be long; cons: beasts hate it for some reason. It is nearly impossible to cast it near them",
    --     "sleep spell: pros: useful to avoid combat; cons: doesn't work on school staff for some reason, If casted on self, you cannot wake up."]
    -- | name == "magnet"         = [
    --     "Medium size magnet with carved initials."]
    -- | name == "rope"           = [
    --     "Old tattered rope. You wouldn''t trust it to hold your weight.",
    --     "But it's quite long. I can't throw it too far but maybe I can grab something with a help of some spell?"]
    -- | name == "potion"         = [
    --     "You recognise it from your alchemy classes (the only ones that you pass). This is a Far Jump Potion.",
    --     "You can use it to jump very far, but only once."]
    -- | name == "nightcap"       = [
    --     "It doesn't look too fashionable, but kind of comfy. (hint: spell component)"]
    -- | name == "note"           = [
    --     "The code is the year of the Worm Spell disaster.",
    --     "You'd better provide the code in the form password_xxxx... Wrong code might have its own consequences."]
    | otherwise                = [
        "Sorry, it's some unknown obejct. We don't know what to say about it..."]
    where name = objectName object