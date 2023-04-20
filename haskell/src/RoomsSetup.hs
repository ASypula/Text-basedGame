module RoomsSetup where

import Types

roomDescription :: Room -> [String]
roomDescription room
    | name == "room_1" = [
        "Exit - On the north side of a room you see big golden door with \"exit\" engraved on them. Unfortunately it is guarded by a beast.",
        "The room is filled with skeletons in wizard apprentice robes.",
        "You can still back off to the south.",
        "The head belongs to deceptively beautiful woman with blue eyes and cruel smile.",
        "The beast rises its double scorpion tail as if already prepared to attack."]
    | name == "room_2" = [
        "Beneath the trapdoor - First room. Walls are smooth. On the ceiling far above there is trapdoor, you were tossed here through.",
        "There is a slightly open door on the east wall.",
        "There is a skeleton in wizard robes."]
    | otherwise        = ["Sorry, you encountered an unknown room."]
    where name = roomName room

additionalDescription :: Room -> [String]
additionalDescription room =
    allObjectsRoomDescription (roomName room) (objects room)

allObjectsRoomDescription :: String -> Maybe [Object] -> [String]
allObjectsRoomDescription _ Nothing = [""]
allObjectsRoomDescription name (Just objs) = concatMap (roomObjectDescription name) objs

roomObjectDescription :: String -> Object -> [String]
roomObjectDescription roomName object
    | roomName == "room_2" && name == "old_journal" = ["You see a journal near the skeleton in wizard robes."]
    | otherwise = [""]
    where name = objectName object
