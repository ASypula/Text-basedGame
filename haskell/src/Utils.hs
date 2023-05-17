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
    case currentRoom of
      Just currRoom -> 
        printLines (additionalDescription currRoom state)

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
        [] -> (state, "Room has no objects.")
        objs ->
          if objName `elem` map objectName objs
            then let newRoomsMap = removeObjectFromAllRooms objName objs (rooms state)
                     takenObj = filter (\obj -> objectName obj == objName) objs
                     inv = maybe [] id (inventory (player state))
                     newInventory = takenObj ++ inv
                     oldPlayer = player state
                     newPlayer = oldPlayer {inventory = Just newInventory}
                     newState = state { rooms = newRoomsMap, player = newPlayer }
                  in (newState, "Object successfully added to your inventory.")
            else (state, "Such object does not exists or you can not reach it.")

removeObjectFromAllRooms :: String -> [Object] -> Map.Map String Room -> Map.Map String Room
removeObjectFromAllRooms objName objs oldRoomsMap =
  Map.map (\room -> removeSpecyficObjectFromRoom room objName objs) oldRoomsMap

removeSpecyficObjectFromRoom :: Room -> String -> [Object] -> Room
removeSpecyficObjectFromRoom oldRoom objName objs =
  let
    newObjs = filter (\obj -> objectName obj /= objName) (objects oldRoom)
    newRoom = oldRoom { objects = newObjs }
  in
    newRoom

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
unlock rName state = 
  case elem rName blockedRooms of
    True ->
      let newBlocked = List.delete rName blockedRooms
          newState = state {blockades = newBlocked}
      in (newState, True)
    False ->
      (state, False)
    where blockedRooms = blockades state

unlockOutcome :: Bool -> IO ()
unlockOutcome result
    | result = printLines ["Room succesfully unlocked."]
    | otherwise = printLines ["That room is already unlocked."]

cast :: State -> String -> String -> (State, String)
cast st spellName spellComponent =
  case spells st of
    [] -> (st, "Something has gone terribly wrong! You cannot cast any spell...")
    sp ->
      if spellName `elem` sp
        then case inventory (player st) of
          Nothing -> (st, "You don't have any obejct in your inventory")
          Just inv ->
            if spellComponent `elem` map objectName inv
              then case spellName of
                "light" -> (st, "light spell has not implemented yet")
                "grab" -> case spellComponent of
                  "rope" -> castGrab st (room (player st))
                  _ -> (st, "Grab spell does not seem to work with chosen spell component...")
                "open" -> (st, "open spell has not been implemented yet")
                "sleep" -> (st, "sleep spell has not been implemented yet")
                "power_word_kill" -> (st, "power_word_kill spell has not been implemented yet")
                _ -> (st, "Something went wrong - the word doesn't know how to react to your spell. You should reconsider your actions...")
              else (st, "You don't have such item")
        else (st, "Such spell does not exits... You should have studied harder before your exams...")

castGrab :: State -> String -> (State, String)
castGrab st roomName =
  case Map.lookup roomName (rooms st) of
    Nothing -> (st, "Room not found.")
    Just oldRoom ->
      case objects oldRoom of
        [] -> (st, "Room has no objects that can be grabbed.")
        objs ->
          case roomName of
            "room_16" -> do let (newState, pickUpMsg) = takeObjectFromRoom "key" (room (player st)) st
                            if areStatesIdentical st newState
                              then (st, "There is nothing you can grab here.")
                              else (newState, "With the help of the Grab Spell you pick up a key.")
            "room_4S" -> do let (newState, pickUpMsg) = takeObjectFromRoom "nightcap" "room_4N" st
                            if areStatesIdentical st newState
                              then (st, "There is nothing you can grab here.")
                              else (newState, "With the help of the Grab Spell you pick up a nightcap over the acid pool.")
            _ -> (st, "There is nothing you can grab here.")

areStatesIdentical :: State -> State -> Bool
areStatesIdentical state1 state2 =
  player state1 == player state2 &&
  rooms state1 == rooms state2 &&
  blockades state1 == blockades state2 &&
  spells state1 == spells state2