module Utils where

import Types
import RoomsSetup


printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)

describeRoom :: Room -> IO ()
describeRoom room = printLines (roomDescription room)