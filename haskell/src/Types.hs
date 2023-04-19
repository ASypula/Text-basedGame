-- module Types (Object, Room) where

-- some placeholder for Object
data Object = Object { objectName :: String } deriving (Show)

data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String]}


printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

-- describeRoom :: Room -> IO ()
-- describeRoom room = printLines (description room)

-- let object1 = Object{objectName="O1"}
-- let object2 = Object{objectName="O2"}
-- let room1 = Room{roomName="Room 1", objects= Just [object1, object2], hints=Nothing}

-- ****************************************************************************************
-- RoomsSetup

roomDescription :: Room -> [String]
roomDescription room
    | name == "Room 1" = [
        "Exit - On the north side of a room you see big golden door with \"exit\" engraved on them. Unfortunately it is guarded by a beast.",
        "The room is filled with skeletons in wizard apprentice robes.",
        "You can still back off to the south.",
        "The head belongs to deceptively beautiful woman with blue eyes and cruel smile.",
        "The beast rises its double scorpion tail as if already prepared to attack."]
    | name == "Room 2" = [
        "Beneath the trapdoor - First room. Walls are smooth. On the ceiling far above there is trapdoor, you were tossed here through.",
        "There is a slightly open door on the east wall.",
        "There is a skeleton in wizard robes."]
    | otherwise        = ["Sorry, you encountered an unknown room."]
    where name = roomName room

additionalDescription :: Room -> [String]
additionalDescription room =
    coos (roomName room) (objects room)

coos :: String -> Maybe [Object] -> [String]
coos _ Nothing = [""]
coos name (Just objs) = concatMap (roomObjectDescription name) objs

roomObjectDescription :: String -> Object -> [String]
roomObjectDescription roomName object
    | roomName == "Room 1" && name == "O1" = ["O rety"]
    | otherwise = ["No good item"]
    where name = objectName object
