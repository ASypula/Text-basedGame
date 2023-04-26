module Types where

import qualified Data.Map as Map

data Direction = N | S | W | E deriving (Eq, Show)

data Object = Object { objectName :: String } deriving (Show)

data Player = Player { room :: String, inventory :: Maybe [Object] }

-- TODO: should blocked be as a String - room name from which we are blocked or a Bool
data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String], blocked :: Bool}

data State = State { player :: Player, rooms :: Map.Map String Room}
