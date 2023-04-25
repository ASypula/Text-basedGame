module Types where

import qualified Data.Map as Map

data Object = Object { objectName :: String } deriving (Show)

data Player = Player { room :: String, inventory :: Maybe [Object] }

-- TODO: should blocked be as a String - room name or simply Room?
data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String], blocked :: Bool}

data State = State { player :: Player, rooms :: Map.Map String Room}
--myMap = Data.Map.fromList [(1,"hello"), (3,"goodbye")]

--data State = State { room :: Room, inventory :: Maybe [Object], existingObjects :: Maybe [Object]}

