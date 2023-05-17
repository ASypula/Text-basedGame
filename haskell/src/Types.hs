module Types where

import qualified Data.Map as Map

data Direction = N | S | W | E deriving (Eq, Show)

data PathState = OPEN | BLOCKED | NONE deriving (Eq)

data Object = Object { objectName :: String } deriving (Eq, Show)

data Player = Player { room :: String, inventory :: Maybe [Object] } deriving (Eq)

-- TODO: should blocked be as a String - room name from which we are blocked or a Bool
-- TODO: change additions to tags
data Room = Room { roomName :: String, objects :: [Object], hints :: [String], blocked :: Bool, additions :: [String]} deriving (Eq)

data State = State { player :: Player, rooms :: Map.Map String Room, blockades :: [String], spells :: [String]}
