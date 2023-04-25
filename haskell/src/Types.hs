module Types where

data Object = Object { objectName :: String } deriving (Show)

data Gamer = Gamer { position :: Room, objects :: Maybe [Object] }

-- TODO: should blocked be as a String - room name or simply Room?
data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String], blocked :: Bool}

data World = World { gamer :: Gamer, rooms :: [Room]}


data State = State { room :: Room, inventory :: Maybe [Object], existingObjects :: Maybe [Object]}

