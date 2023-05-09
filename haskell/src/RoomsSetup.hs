module RoomsSetup where

import Types

-- order matters (room_3)
roomDescription :: Maybe Room -> [String]
roomDescription (Just room)
    | name == "room_1" = [
        "Exit - On the north side of a room you see big golden door with \"exit\" engraved on them. Unfortunately it is guarded by a beast.",
        "The room is filled with skeletons in wizard apprentice robes.",
        "You can still back off to the south.",
        "The head belongs to deceptively beautiful woman with blue eyes and cruel smile.",
        "The beast rises its double scorpion tail as if already prepared to attack.", ""]
    | name == "room_2" = [
        "Beneath the trapdoor - First room. Walls are smooth. On the ceiling far above there is trapdoor, you were tossed here through.",
        "There is a slightly open door on the east wall.",
        "There is a skeleton in wizard robes."]
    | name == "room_3" && "obscured" `elem` additionsList = [
        "Junk Room - The room is covered by unnatural magical darkness, your lantern cannot illuminate.",
        "You stumble upon various object scattered on the floor, but there is no way to distinguish whether any of them may be useful.",
        "By touch you find passage north, east and west."]
    | name == "room_3" = [
        "Now, when the light provides better visibility, you can distinguish various objects littering the floor.",
        "One of them in particular draws your attention... a beige pile of something but you need to look closer to name it.",
        "Now the possible exits are more clearly visible: three different passages leading north, east and west."]    
    | name == "room_4" = [
        "room4"]
    | name == "room_4N" = [
        "room4N"]
    | name == "room_4S" = [
        "room4S"]
    | name == "room_5" = [
        "The room is filled with techno-magic machinery. It is not considered difficult magic, but you overslept that exam and failed it anyway.",
        "There is a door on the east wall."]
    | name == "room_6" = [
        "Corridor filled with goblin skeletons. Looks like some mage defeated them, you can still sense magic in the air.",
        "The corridor leads north. There is also an opening on the east side."]
    | name == "room_8" = [
        "The hidden room is filled with books and oracle orbs. It is illuminated by mistical blue light.",
        "In the centre of the room stands a skeleton wearing very old tattered hat with \"Maggus\" on it.",
        "Suddenly the skeleton moves and gestures you to come closer."]
    | name == "room_10" = [
        "There is a door on the north wall, however it is covered in many warning messages written using chalk, soot, ink and even blood.",
        "There is also a long corridor going east and another corridor going south."]
    | name == "room_11" = [
        "You are in a long corridor going east and west. In the middle it has two doors in front of each other.",
        "The corridor is stained with soot in some places."]
    | name == "room_12" && "obscured" `elem` additionsList = [
        "It's strange. You've just walked into this room and just by being in here you feel some pain.",
        "The room is very dark and smells of dirt and herbs. Even your lantern can't illuminate it.",
        "After even one step in you get scratched by thorns. Let's hope that wasn't anything poisonous.",
        "There is no way to safely explore this room without magical light."]
    | name == "room_12" = [
        "The room is of a medium size. You see many normal and magical herbs and flowers growing here."]
    | name == "room_13" = [
        "Inside there is a skeleton sitting in a corner. Next to it lays a broken jar with some dead insects inside.",
        "Apart from that, the room is mostly filled with empty crates.",
        "The door is on the north wall."]
    | name == "room_14" = [
        "room14"]
    | name == "room_14W" = [
        "room14W"]
    | name == "room_14S" = [
        "room14S"]
    | name == "room_15" = [
        "Rather big room covered with soot spots. It has exits on south and north wall.",
        "There is a soot covered skeleton here."]
    | name == "room_16" = [
        "You enter a vast, cluttered room. You have to maneuver between shelves, crates and tables to move around.",
        "Exits are on the west and north wall.",
        "The room is filled with jars, bottles and glass aparature."]
    | otherwise        = ["Sorry, you encountered an unknown room."]
    where 
        name = roomName room
        additionsList = additions room
roomDescription Nothing = ["Sorry this room does not exist."]

contains :: Eq a => a -> [a] -> Bool
contains = \elem -> \myList ->
  case myList of
    [] -> False -- if all elements checked, return False
    x:xs | x == elem -> True -- If head matches elem, return True
    _:xs -> contains elem xs -- Check for element membership in remaining list

possibleMoves :: String -> Direction -> [String] -> Maybe (String, Bool)
possibleMoves startRoom direction blocades
    | startRoom == "room_1" && direction == S = Just ("room_10", True)
    | startRoom == "room_2" && direction == E = Just ("room_3", True)
    | startRoom == "room_3" && direction == N && contains "room_4" blocades = Just ("room_4S", True)
    | startRoom == "room_3" && direction == N = Just ("room_4", True)
    | startRoom == "room_3" && direction == E = Just ("room_16", True)
    | startRoom == "room_3" && direction == W = Just ("room_2", True)
    | startRoom == "room_4" && direction == N = Just ("room_6", True)
    | startRoom == "room_4N" && direction == N = Just ("room_6", True)
    | startRoom == "room_4" && direction == S = Just ("room_3", True)
    | startRoom == "room_4S" && direction == S = Just ("room_3", True)
    | startRoom == "room_4S" && direction == N = Just ("room_3", False)
    | startRoom == "room_4" && direction == W && contains "room_5" blocades = Just ("room_5", False)
    | startRoom == "room_4" && direction == W = Just ("room_5", True)
    | startRoom == "room_4N" && direction == S = Just ("room_3", False)
    | startRoom == "room_4N" && direction == W && contains "room_5" blocades = Just ("room_5", False)
    | startRoom == "room_4N" && direction == W = Just ("room_5", True)
    | startRoom == "room_4N" && direction == N = Just ("room_6", True)
    | startRoom == "room_5" && direction == E && contains "room_4" blocades = Just ("room_4N", True)
    | startRoom == "room_5" && direction == E = Just ("room_4", True)
    | startRoom == "room_6" && direction == N = Just ("room_10", True)
    | startRoom == "room_6" && direction == E = Just ("room_8", True)
    | startRoom == "room_6" && direction == S && contains "room_4" blocades = Just ("room_4N", True)
    | startRoom == "room_6" && direction == S = Just ("room_4", True)
    | startRoom == "room_8" && direction == W = Just ("room_6", True)
    | startRoom == "room_10" && direction == N = Just ("room_1", True)
    | startRoom == "room_10" && direction == E = Just ("room_11", True)
    | startRoom == "room_10" && direction == S = Just ("room_6", True)
    | startRoom == "room_11" && direction == N && contains "room_12" blocades = Just ("room_12", False)
    | startRoom == "room_11" && direction == N = Just ("room_12", True)
    | startRoom == "room_11" && direction == E && contains "room_14" blocades = Just ("room_14W", True)
    | startRoom == "room_11" && direction == E = Just ("room_14", True)
    | startRoom == "room_11" && direction == S && contains "room_13" blocades = Just ("room_13", False)
    | startRoom == "room_11" && direction == S = Just ("room_13", True)
    | startRoom == "room_11" && direction == W = Just ("room_10", True)
    | startRoom == "room_12" && direction == S = Just ("room_11", True)
    | startRoom == "room_13" && direction == N = Just ("room_11", True)
    | startRoom == "room_14" && direction == S = Just ("room_15", True)
    | startRoom == "room_14" && direction == W = Just ("room_11", True)
    | startRoom == "room_14W" && direction == W = Just ("room_11", True)
    | startRoom == "room_15" && direction == N && contains "room_14" blocades = Just ("room_14S", True)
    | startRoom == "room_15" && direction == N = Just ("room_14", True)
    | startRoom == "room_15" && direction == S = Just ("room_16", True)
    | startRoom == "room_16" && direction == N = Just ("room_15", True)
    | startRoom == "room_16" && direction == W = Just ("room_3", True)
    | otherwise = Nothing

additionalDescription :: Maybe Room -> [String]
additionalDescription room =
    maybe [] (\r -> allObjectsRoomDescription r (objects r)) room

allObjectsRoomDescription :: Room -> Maybe [Object] -> [String]
allObjectsRoomDescription _ Nothing = [""]
allObjectsRoomDescription room (Just objs) = concatMap (roomObjectDescription room) objs

roomObjectDescription :: Room -> Object -> [String]
roomObjectDescription room object
    | rName == "room_2" && objName == "old_journal" = ["You see a journal near the skeleton in wizard robes."]
    | rName == "room_3" && objName == "rope" && "obscured" `elem` additionsList = ["It's too dark to see anything."]
    | rName == "room_3" && objName == "rope" = ["You were right! It''s a bunch of material, a rope."]
    | rName == "room_6" && objName == "magnet" = ["One of the goblins holds curious looking magnet."]
    | rName == "room_12" && objName == "wolfsbane" && not ("obscured" `elem` additionsList) = ["The wolfsbane catches your eye.", "And now you see the thorns are because roses grow... black roses but you remember from your herbology lectures that they are not harmful until you eat them. You have a lot of luck this time."]
    | rName == "room_13" && objName == "ripped_journal" = ["There is a ripped_journal here."]
    | rName == "room_15" && objName == "burned_journal" = ["Beside it, there is a partially burned journal."]
    | rName == "room_16" && objName == "potion" = ["Only one of the bottles appears to have something in it."]
    | rName == "room_16" && objName == "key" = ["As you look around the room you notice something shiny between floor tiles, but you cannot grab it with your fingers.", "Some sort of jewellery? Or maybe a key?"]
    | otherwise = [""]
    where
        rName = roomName room 
        objName = objectName object
        additionsList = additions room
