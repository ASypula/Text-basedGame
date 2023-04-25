module Utils where

import Types
import RoomsSetup


printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: Room -> IO ()
describeRoom room = do
    printLines (roomDescription room)
    printLines (additionalDescription room)