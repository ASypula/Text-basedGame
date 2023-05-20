module Utils where

import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map
import qualified Data.List as List
import Data.Maybe (fromMaybe, fromJust, maybeToList)

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
        let filteredObjs = filter (\obj -> objectName obj == objName) objs
        in case filteredObjs of
          [] -> "You don't hold such object"
          _ -> unlines (objectDescription filteredObjs)
        where objs = inventory (player state)


getInventoryItemsDescription :: Player -> [String]
getInventoryItemsDescription player = 
        map objectName objects
        where objects = inventory player

describeState :: State -> IO()
describeState state = do
    describeRoom state

takeObjectFromRoomIfPossible :: String -> String -> State -> (State, String)
takeObjectFromRoomIfPossible objName roomName state =
  case objName of
    "key" -> (state, "You can not reach it.")
    "nightcap" -> 
      case roomName of
        "room_4S" -> (state, "You can not reach it.")
        _ -> takeObjectFromRoom objName roomName state
    "firefly" -> 
      case Map.lookup roomName (rooms state) of
        Nothing -> (state, "Room not found.")
        Just oldRoom ->
          case objects oldRoom of
            [] -> (state, "Room has no objects.")
            objs ->
              if "firefly" `elem` map objectName objs
                then (state, "Fireflies tend to be hard to catch with bare hands. Try to find something to catch it in.") 
                else (state, "You can not reach it.") 
    _ -> takeObjectFromRoom objName roomName state

takeObjectFromRoom :: String -> String -> State -> (State, String)
takeObjectFromRoom objName roomName state =
  case Map.lookup roomName (rooms state) of
    Nothing -> (state, "Room not found.")
    Just oldRoom ->
      case objects oldRoom of
        [] -> (state, "Room has no objects.")
        objs ->
          if "obscured" `elem` additions oldRoom
            then (state, "You can't pick up an object you do not see. Consider finding a way to bring some light in here.")
            else
              if objName `elem` map objectName objs
                then let newRoomsMap = removeObjectFromAllRooms objName objs (rooms state)
                         takenObj = filter (\obj -> objectName obj == objName) objs
                         inv = inventory (player state)
                         newInventory = takenObj ++ inv
                         oldPlayer = player state
                         newPlayer = oldPlayer {inventory = newInventory}
                         newState = state { rooms = newRoomsMap, player = newPlayer }
                      in (newState, "Object successfully added to your inventory.")
                else (state, "Such object does not exists.")

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
        map objectName objects
        where objects = inventory player

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


removeAdditionAlt :: String -> String -> State -> State
removeAdditionAlt roomName' text state =
  case Map.lookup roomName' (rooms state) of
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
        then
          if spellComponent `elem` map objectName inv
            then case spellName of
              "light" -> castLight spellComponent st (room (player st))
              "grab" -> case spellComponent of
                "rope" -> castGrab st (room (player st))
                _ -> (st, "The \"grab\" spell does not seem to work with chosen spell component...")
              "open" -> castOpen spellComponent st (room (player st))
              "sleep" -> castSleep spellComponent st (room (player st))
              "power_word_kill" -> castPowerWordKill spellComponent st (room (player st))
              _ -> (st, "Something went wrong - the world doesn't know how to react to your spell. You should reconsider your actions...")
            else (st, "You don't have such item")
        else (st, "Such spell does not exits... You should have studied harder before your exams...")
        where inv = inventory (player st)

castLight :: String -> State -> String -> (State, String)
castLight spellComponent st roomName =
  case spellComponent of
    "firefly" ->
      case Map.lookup roomName (rooms st) of
        Nothing -> (st, "Room not found.")
        Just oldRoom ->
          if "obscured" `elem` additions oldRoom
            then let newAdditions = filter (/= "obscured") (additions oldRoom)
                     newRoom = oldRoom { additions = newAdditions }
                     newRoomsMap = Map.delete roomName (rooms st)
                     updatedRoomsMap = Map.insert roomName newRoom newRoomsMap
                     newState = st { rooms = updatedRoomsMap }
                 in (newState, "The room has been instantaneously illuminated!")
            else (st, "The room has illuminated instantaneously to the point that you can't see anything! You decide to turn off your magical light and proceed on your journey.")
    _ -> (st, "It does not seem to work here at all...")

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

castOpen :: String -> State -> String -> (State, String)
castOpen spellComponent st roomName =
  case spellComponent of
    "key" ->
      case roomName of
        "room_4" -> do
            let newBlockades = filter (/= "room_5") (blockades st)
            let evenNewerBlockades = filter (/= "room_4") newBlockades
            let newState = st { blockades = evenNewerBlockades }
            if areStatesIdentical st newState
              then (st, "There is nothing to be opened here")
              else (newState, "You hear a click sound and the doors are beginning to open slowly.")
        "room_4N" -> do
            let newBlockades = filter (/= "room_5") (blockades st)
            let evenNewerBlockades = filter (/= "room_4") newBlockades
            let newState = st { blockades = evenNewerBlockades }
            if areStatesIdentical st newState
              then (st, "There is nothing to be opened here")
              else (newState, "You hear a click sound and the doors are beginning to open slowly.")
        "room_2" -> (st, "This won't do. The basic \"open\" spell can barely open doors. No way it would open a trapdoor.")
        _ -> (st, "It does not seem to work here at all...")
    "rusty_key" ->
      case roomName of
        "room_2" -> do
            let newState = removeAdditionAlt "room_2" "trapdoor" st
            if areStatesIdentical st newState
              then (st, "There is nothing to be opened here")
              else (newState, "You hear a click sound and the doors are beginning to open slowly.")
        _ -> (st, "It does not seem to work here at all...")
    _ -> (st, "The \"open\" spell does not seem to work with chosen spell component...")

castSleep :: String -> State -> String -> (State, String)
castSleep spellComponent st roomName =
  case spellComponent of
    "nightcap" ->
      case roomName of
        "room_14S" -> do
            let newBlockades = filter (/= "room_14") (blockades st)
            let newPlayer = (player st) { room = "room_14" }
            let newState = st { blockades = newBlockades, player = newPlayer }
            if areStatesIdentical st newState
              then (st, "There is noone else that you could put to sleep")
              else (newState, "You put the dragonling to magical sleep. Now it looks more cute than threatening.")
        "room_14W" -> do
            let newBlockades = filter (/= "room_14") (blockades st)
            let newState = st { blockades = newBlockades }
            let newPlayer = (player st) { room = "room_14" }
            let newState = st { blockades = newBlockades, player = newPlayer }
            if areStatesIdentical st newState
              then (st, "There is noone else that you could put to sleep")
              else (newState, "You put the dragonling to magical sleep. Now it looks more cute than threatening.")
        "room_14" -> (st, "The dragonling is already asleep. You had better staty quiet...")
        _ -> (st, "It does not seem to work here at all...")
    _ -> (st, "The \"sleep\" spell does not seem to work with chosen spell component...")

castPowerWordKill :: String -> State -> String -> (State, String)
castPowerWordKill spellComponent st roomName =
  case spellComponent of
    "wolfsbane" ->
      case roomName of
        "room_10" -> do
            let newState = st { gameEnding = "beastDefeated" }
            (newState, "")
        "room_14S" -> (st, "The dragonling may be dangerous but it looks so helpless in a face of such spell.\nYou don't really want to kill it.\n Besides, if you really wanted to kill it right now, it would be better for the world if you stay in this dungeon forever...")
        "room_14W" -> (st, "The dragonling may be dangerous but it looks so helpless in a face of such spell.\nYou don't really want to kill it.\n Besides, if you really wanted to kill it right now, it would be better for the world if you stay in this dungeon forever...")
        "room_14" -> do
            let newState = st { gameEnding = "crueltyWins" }
            (newState, "")
        _ -> (st, "It does not seem to work here at all... Besides you had better be careful with this spell.")
    _ -> (st, "The \"power_word_kill\" spell does not seem to work with chosen spell component...")

areStatesIdentical :: State -> State -> Bool
areStatesIdentical state1 state2 =
  player state1 == player state2 &&
  rooms state1 == rooms state2 &&
  blockades state1 == blockades state2 &&
  spells state1 == spells state2


useObject :: State -> String -> String -> (State, String)
useObject st objName useCaseName =
  if objName `elem` map objectName inv then
      case objName of
        "magnet" -> useMagnet st useCaseName
        "potion" -> usePotion st useCaseName
        "key" -> useKey st useCaseName
        "jar" -> useJar st useCaseName
        _ -> (st, "This won't help you.")
    else
      (st, "You don't have such object in your inventory")
  where inv = inventory (player st)


useMagnet :: State -> String -> (State, String)
useMagnet st useCaseName =
  case room (player st) of 
    "room_16" ->
        if elem useCaseName useCases then
            let (newState, m) = takeObjectFromRoom "key" "room_16" st
            in
              case m of 
                "Object successfully added to your inventory." ->
                  (newState, "You managed to pick up a key")
                _-> (st, "There is nothing more here to use magnet on.")
          else
            (st, "This won't work.")
        where useCases = ["floor", "key", "metal"]
    "room_1" ->
        if elem useCaseName useCases then 
            let 
              (newState, m) = takeObjectFromRoom "badge" "room_1" st
            in (newState, "Badge springs to your hand across the room. The beast gives you a puzzled look.")
          else
            (st, "This won't work.")
        where useCases = ["badge", "monster", "beast", "manticore"]
    _ -> (st, "Not helpful here.")



usePotion :: State -> String -> (State, String)
usePotion st useCaseName =
  case room (player st) of 
    "room_4S" ->
        if elem useCaseName useCases then 
            let 
              oldPlayer = player st
              newPlayer = oldPlayer {room ="room_4N"}
              newState = st {player = newPlayer}
            in (newState, "You take a swig from a bottle and without a problem you manage to jump over the acid pool.")
          else
            (st, "This won't work.")
        where useCases = ["self", "myself", "me", "acid_pool"]
    "room_4N" ->
        if elem useCaseName useCases then 
            let 
              oldPlayer = player st
              newPlayer = oldPlayer {room ="room_4S"}
              newState = st {player = newPlayer}
            in (newState, "You take a swig from a bottle and without a problem you manage to jump over the acid pool.")
          else
            (st, "This won't work.")
        where useCases = ["self", "myself", "me", "acid_pool"]
    "room_2" ->
        if elem useCaseName useCases then 
            if elem "trapdoor" (additions room') 
              then (st, "Jumping here would surely hurt your head now.")
            else 
              let newState = st {gameEnding="escaped"}
              in (newState, "")
        else (st, "This won't work.")
        where 
          useCases = ["self", "myself", "me", "trapdoor"]
          [room'] = maybeToList ( Map.lookup "room_2" (rooms st))
    _ -> (st, "Not helpful here.")

useKey :: State -> String -> (State, String) 
useKey st useCaseName = 
  if elem (room (player st)) ["room_4", "room_4S", "room_4N"]
    then
      if elem useCaseName useCases then
        let 
          player' = player st
          inv = inventory player'
          inv2 = filter (\obj -> objectName obj /= "key") inv
          inv3 = inv2 ++ [Object {objectName="rusty_key"}]
          newPlayer = player' {inventory = inv3}
          newState = st {player = newPlayer}
        in (newState, "The key rusts in contact with acid.")
      else (st, "This won't work.")
    else (st, "Not helpful here.")
    where useCases = ["acid", "acid_pool", "pool", "acid pool"]


useJar :: State -> String -> (State, String)
useJar st useCaseName =
  if elem (room (player st)) ["room_4", "room_4S", "room_4N"]
    then
      if elem useCaseName useCases then
          let (newState, m) = takeObjectFromRoom "firefly" "room_4" st
          in
              case m of 
                "Object successfully added to your inventory." ->
                  (newState, "You managed to trap firefly in a jar")
                _ -> (st, "There are no more fireflies within your reach.")
        else (st, "This won't work.")
    else (st, "Not helpful here.")
    where useCases = ["firefly", "bug", "bugs", "fireflies"]

