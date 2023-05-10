module Utils where

import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map
import qualified Data.List as List
import Data.Maybe (fromMaybe, fromJust)

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: State -> IO ()
describeRoom state = do
    let currentRoomName = room (player state)
    let currentRoom = (Map.lookup currentRoomName (rooms state))
    printLines (roomDescription currentRoom)
    printLines (additionalDescription currentRoom)

hintRoom :: State -> IO ()
hintRoom state
    | null hint = printLines ["Sorry, no hint available here."]
    | otherwise = printLines hint
    where
      hint = maybe [] hints (Map.lookup (room (player state)) (rooms state))


investigateObject :: String -> String -> State -> String
investigateObject objName roomName state =
  case Map.lookup roomName (rooms state) of
    Nothing -> "Room not found"
    Just room ->
      case inventory (player state) of
        Nothing -> "You don't hold any object"
        Just objs ->
          let filteredObjs = filter (\obj -> objectName obj == objName) objs
          in case filteredObjs of
            [] -> "You don't hold such object"
            _ -> unlines (objectDescription filteredObjs)

ifObjectIsPresentInInventory :: String -> State -> Bool
ifObjectIsPresentInInventory lookForObjectName state = case inventory (player state) of
                                              Just objects -> elem lookForObjectName (map objectName objects)
                                              Nothing -> False


getInventoryItemsDescription :: Player -> [String]
getInventoryItemsDescription player = do
    case inventory player of
        Nothing -> [""]
        Just objects -> map objectName objects

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

-- removeAdditionFromRoom :: Room -> String -> Room
-- removeAdditionFromRoom room stringToRemove =
--   room {additions = newAdditions}
--   where
--     currentAdditions = additions room
--     newAdditions = case currentAdditions of
--                        [] -> []
--                        Just additionsList -> Just (filter (/= stringToRemove) additionsList)

removeAdditionFromRoom :: Room -> String -> Room
removeAdditionFromRoom room stringToRemove =
  room {additions = newAdditions}
  where
    currentAdditions = additions room
    newAdditions = filter (/= stringToRemove) currentAdditions

-- TODO adjust to use for removing obscure
removeAddition :: String -> State -> State
removeAddition text state =
  case Map.lookup (room (player state)) (rooms state) of
    Nothing -> state
    Just oldRoom ->
      let rName = roomName oldRoom
          newRoom = removeAdditionFromRoom oldRoom text
          newRoomsMap = Map.insert rName newRoom (rooms state)
          newState = state { rooms = newRoomsMap }
      in newState



unlock :: String -> State -> (State, Bool)
unlock roomName state = 
  case elem roomName blockedRooms of
    True ->
      let newBlocked = List.delete roomName blockedRooms
          newState = state {blockades = newBlocked}
      in (newState, True)
    False ->
      (state, False)
    where blockedRooms = blockades state


unlockOutcome :: Bool -> IO ()
unlockOutcome result
    | result = printLines ["Room succesfully unlocked."]
    | otherwise = printLines ["That room is already unlocked."]