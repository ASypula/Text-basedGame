module Utils where

import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map
import Data.Maybe (fromMaybe, fromJust)

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: State -> IO ()
describeRoom state = do
    let currentRoomName = room (player state)
    let currentRoom = (Map.lookup currentRoomName (rooms state))
    printLines (roomDescription currentRoom)
    printLines (additionalDescription currentRoom)


investigateObject :: Object -> IO ()
investigateObject object = printLines (objectDescription object)

ifObjectIsPresentInInventory :: String -> State -> Bool
ifObjectIsPresentInInventory lookForObjectName state = case inventory (player state) of
                                              Just objects -> elem lookForObjectName (map objectName objects)
                                              Nothing -> False


-- getInventoryItemsDescription :: State -> [String]
-- getInventoryItemsDescription state = do
--     case inventory state of
--         Nothing -> [""]
--         Just objects -> map objectName objects

describeState :: State -> IO()
describeState state = do
    describeRoom state


takeObjectFromRoom :: String -> String -> State -> (State, String)
takeObjectFromRoom objName roomName state =
  case Map.lookup roomName (rooms state) of
    Nothing -> (state, "Room not found.")
    Just oldRoom ->
      case objects oldRoom of
        Nothing -> (state, "Room has no objects.")
        Just objs ->
          if objName `elem` map objectName objs
            then let newObjs = filter (\obj -> objectName obj /= objName) objs
                     takenObj = filter (\obj -> objectName obj == objName) objs
                     newRoom = oldRoom { objects = Just newObjs }
                     newRoomsMap = Map.insert roomName newRoom (rooms state)
                     inv = maybe [] id (inventory (player state))
                     newInventory = takenObj ++ inv
                     oldPlayer = player state
                     newPlayer = oldPlayer {inventory = Just newInventory}
                     newState = state { rooms = newRoomsMap, player = newPlayer }
                 in (newState, "Object successfully added to your inventory.")
            else (state, "Such object does not exists. Please check the spelling.")

getStringInventory :: Player -> [String]
getStringInventory player =
  case inventory player of
    Nothing -> []
    Just objs -> map objectName objs