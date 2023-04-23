module Types where

data Object = Object { objectName :: String } deriving (Show)

data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String]}

data State = State { room :: Room, inventory :: Maybe [Object]}