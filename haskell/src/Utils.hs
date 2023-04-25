module Utils where

import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: Maybe Room -> IO ()

describeRoom room = do
    printLines (roomDescription room)
    printLines (additionalDescription room)

-- takeObjectIfExists :: String -> World -> State
-- takeObjectIfExists objectName world | ifObjectExists objectName gamer world == True && ifObjectIsPresentInInventory objectName state == False = takeObject newObject state
--                                     | otherwise                               = state
--                                     where newObject = Object{objectName=objectName}


-- getMsgForObjectPickUp :: String -> State -> [String]
-- getMsgForObjectPickUp objectName state | ifObjectExists objectName state && not (ifObjectIsPresentInInventory objectName state) = ["Object successfully added to your inventory.", ""]
--                                        | ifObjectExists objectName state && ifObjectIsPresentInInventory objectName state       = ["You already have that object.", ""]
--                                        | otherwise                                                                              = ["Such object does not exists. Please check the spelling.", ""]

-- ifObjectExists :: String -> Room -> Bool
-- ifObjectExists lookForObjectName room = case objects room of
--                                               Just objects -> elem lookForObjectName (map objectName objects)
--                                               Nothing -> False

-- ifObjectIsPresentInInventory :: String -> State -> Bool
-- ifObjectIsPresentInInventory lookForObjectName state = case inventory state of
--                                               Just objects -> elem lookForObjectName (map objectName objects)
--                                               Nothing -> False

-- takeObject :: Object -> State -> State
-- takeObject newObject state = state {inventory = newInventory}
--     where 
--         oldInventory = inventory state
--         newInventory = case oldInventory of
--             Nothing -> Just [newObject]
--             Just previouslyAddedObjects -> Just (previouslyAddedObjects ++ [newObject])

-- getInventoryItemsDescription :: State -> [String]
-- getInventoryItemsDescription state = do
--     case inventory state of
--         Nothing -> [""]
--         Just objects -> map objectName objects

-- investigateObject :: Object -> IO ()
-- investigateObject object = printLines (objectDescription object)

describeState :: State -> IO()
describeState state = do
    describeRoom ((Map.lookup (room (player state)) (rooms state)))
    --printLines (additionalDescription (room state))

removeObjectFromRoom :: String -> String -> State -> (State, String)
removeObjectFromRoom objName roomName state =
  case Map.lookup roomName (rooms state) of
    Nothing -> (state, "Room not found")
    Just oldRoom ->
      case objects oldRoom of
        Nothing -> (state, "Room has no objects")
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
                 in (newState, "Object removed from the room")
            else (state, "Object not found in the room")

describeInventory :: Player -> [String]
describeInventory player =
  case inventory player of
    Nothing -> []
    Just objs -> map objectName objs