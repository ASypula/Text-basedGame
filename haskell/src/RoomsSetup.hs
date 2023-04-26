module RoomsSetup where

import Types

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
    | name == "room_3" = [
        "TODO"]
    | name == "room_4" = [
        "TODO"]
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
    | name == "room_12" = [
        "TODO"]
    | name == "room_13" = [
        "Inside there is a skeleton sitting in a corner. Next to it lays a broken jar with some dead insects inside.",
        "Apart from that, the room is mostly filled with empty crates.",
        "The door is on the north wall."]
    | name == "room_14" = [
        "TODO"]
    | name == "room_15" = [
        "Rather big room covered with soot spots. It has exits on south and north wall.",
        "There is a soot covered skeleton here."]
    | name == "room_16" = [
        "You enter a vast, cluttered room. You have to maneuver between shelves, crates and tables to move around.",
        "Exits are on the west and north wall.",
        "The room is filled with jars, bottles and glass aparature."]
    | otherwise        = ["Sorry, you encountered an unknown room."]
    where name = roomName room
roomDescription Nothing = ["Sorry this room does not exist."]


possibleMoves :: String -> Direction -> Maybe (String, Bool)
possibleMoves startRoom direction
    | startRoom == "room_1" && direction == S = Just ("room_10", True)
    | startRoom == "room_1" = Nothing
    | startRoom == "room_2" && direction == E = Just ("room_3", True)
    | startRoom == "room_2" = Nothing
    | startRoom == "room_3" && direction == N = Just ("room_4", True)
    | startRoom == "room_3" && direction == N = Just ("room_4S", True)
    | startRoom == "room_3" && direction == E = Just ("room_16", True)
    | startRoom == "room_3" && direction == W = Just ("room_2", True)
    | startRoom == "room_3" = Nothing
    | startRoom == "room_4" && direction == N = Just ("room_6", True)
    | startRoom == "room_4N" && direction == N = Just ("room_6", True)
    | startRoom == "room_4" && direction == S = Just ("room_3", True)
    | startRoom == "room_4S" && direction == S = Just ("room_3", True)
    | startRoom == "room_4" && direction == W = Just ("room_5", True)
    | startRoom == "room_4N" && direction == N = Just ("room_5", True)
    | startRoom == "room_4" = Nothing
    | startRoom == "room_4N" = Nothing
    | startRoom == "room_4S" = Nothing
    | startRoom == "room_5" && direction == E = Just ("room_4", True)
    | startRoom == "room_5" && direction == E = Just ("room_4N", True)
    | startRoom == "room_5" = Nothing
    | startRoom == "room_6" && direction == N = Just ("room_10", True)
    | startRoom == "room_6" && direction == E = Just ("room_8", True)
    | startRoom == "room_6" && direction == S = Just ("room_4", True)
    | startRoom == "room_6" && direction == S = Just ("room_4N", True)
    | startRoom == "room_6" = Nothing
    | startRoom == "room_8" && direction == W = Just ("room_6", True)
    | startRoom == "room_8" = Nothing
    | startRoom == "room_10" && direction == N = Just ("room_1", True)
    | startRoom == "room_10" && direction == E = Just ("room_11", True)
    | startRoom == "room_10" && direction == S = Just ("room_6", True)
    | startRoom == "room_10" = Nothing
    | startRoom == "room_11" && direction == N = Just ("room_12", True)
    | startRoom == "room_11" && direction == E = Just ("room_14", True)
    | startRoom == "room_11" && direction == E = Just ("room_14W", True)
    | startRoom == "room_11" && direction == S = Just ("room_13", True)
    | startRoom == "room_11" && direction == W = Just ("room_10", True)
    | startRoom == "room_11" = Nothing
    | startRoom == "room_12" && direction == S = Just ("room_11", True)
    | startRoom == "room_12" = Nothing
    | startRoom == "room_13" && direction == N = Just ("room_11", True)
    | startRoom == "room_13" = Nothing
    | startRoom == "room_14" && direction == S = Just ("room_15", True)
    | startRoom == "room_14S" && direction == S = Just ("room_15", True)
    | startRoom == "room_14" && direction == W = Just ("room_11", True)
    | startRoom == "room_14W" && direction == W = Just ("room_11", True)
    | startRoom == "room_14" = Nothing
    | startRoom == "room_14W" = Nothing
    | startRoom == "room_14S" = Nothing
    | startRoom == "room_15" && direction == N = Just ("room_14", True)
    | startRoom == "room_15" && direction == N = Just ("room_14S", True)
    | startRoom == "room_15" && direction == S = Just ("room_16", True)
    | startRoom == "room_15" = Nothing
    | startRoom == "room_16" && direction == N = Just ("room_15", True)
    | startRoom == "room_16" && direction == W = Just ("room_3", True)
    | startRoom == "room_16" = Nothing
    | otherwise = Nothing

additionalDescription :: Maybe Room -> [String]
additionalDescription room =
    maybe [] (\r -> allObjectsRoomDescription (roomName r) (objects r)) room

allObjectsRoomDescription :: String -> Maybe [Object] -> [String]
allObjectsRoomDescription _ Nothing = [""]
allObjectsRoomDescription name (Just objs) = concatMap (roomObjectDescription name) objs

roomObjectDescription :: String -> Object -> [String]
roomObjectDescription roomName object
    | roomName == "room_2" && name == "old_journal" = ["You see a journal near the skeleton in wizard robes."]
    | otherwise = [""]
    where name = objectName object

-- TODO: add big_journal to room8