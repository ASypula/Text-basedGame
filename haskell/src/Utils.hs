module Utils where

import Types
import RoomsSetup
import ObjectsSetup


printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: Room -> IO ()
describeRoom room = printLines (roomDescription room)

investigateObject :: Object -> IO ()
investigateObject object = printLines (objectDescription object)

describeState :: State -> IO()
describeState state = do
    describeRoom (room state)
    printLines (additionalDescription (room state))