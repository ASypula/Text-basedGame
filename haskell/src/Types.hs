module Types where

-- some placeholder for Object
data Object = Object { objectName :: String } deriving (Show)

data Room = Room { roomName :: String, objects :: Maybe [Object], hints :: Maybe [String]}
