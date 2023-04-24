module Utils where

import Types
import RoomsSetup
import ObjectsSetup


printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: Room -> IO ()
describeRoom room = printLines (roomDescription room)

takeObjectIfExists :: String -> State -> [String]
takeObjectIfExists objectName state | ifObjectExists objectName state = ["Object successfully added to your inventory.", ""]
                                    | otherwise                       = ["Such object does not exists. Please check the spelling.", ""]

ifObjectExists :: String -> State -> Bool
ifObjectExists lookForObjectName state = case existingObjects state of
                                              Just objects -> elem lookForObjectName (map objectName objects)
                                              Nothing -> False

takeObject :: Object -> State -> State
takeObject newObject state = state {inventory = newInventory}
    where 
        oldInventory = inventory state
        newInventory = case oldInventory of
            Nothing -> Just [newObject]
            Just previouslyAddedObjects -> Just (previouslyAddedObjects ++ [newObject])

investigateObject :: Object -> IO ()
investigateObject object = printLines (objectDescription object)

describeState :: State -> IO()
describeState state = do
    describeRoom (room state)
    printLines (additionalDescription (room state))