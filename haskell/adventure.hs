import Data.List (length)
import GHC.Base (when)
import System.IO


introductionText = [
    "You are a wizard apprentice who failed their final exams, ",
    "thus General University of magic put you in deadly dungeon.",
    "",
    "Were you to escape, Wizard Council would let you retake exams..."
    ]

instructionsText = [
    "Available commands are:",
    "",
    "instructions  -- to see these instructions.",
    "n  s  e  w    -- to go in that direction.",
    "take object   -- to pick up an object",
    "look          -- to look around you again.",
    "quit          -- to end the game and quit.",
    ""
    ]

-- print strings from list in separate lines
printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)
                  
printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

readCommand :: IO [String]
readCommand = do
    putStr "> "
    xs <- getLine
    return [xs]
    
-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: IO ()
gameLoop = do
    cmd <- readCommand
    case cmd of
        ["instructions"] -> do
                printInstructions
                gameLoop
        ["n"] -> do
                printLines ["You have moved to the north.", ""]
                gameLoop
        ["s"] -> do 
                printLines ["You have moved to the south.", ""]
                gameLoop
        ["e"] -> do
                printLines ["You have moved to the east.", ""]
                gameLoop
        ["w"] -> do
                printLines ["You have moved to the west.", ""]
                gameLoop
        ["take", object'] -> do
                printLines ["You have almost taken up object ", object', "Almost because it is not implemented yet", ""]
                gameLoop
        ("take": _) -> do
                printLines ["Correct usage: take OBJECT", "But it hasn't been implemented yet...", ""]
                gameLoop
        ["look"] -> do
                printLines ["You look around but see nothing as this has not been implemented yet...", ""]
                gameLoop
        ["quit"] -> return ()
        _ -> do printLines ["Unknown command.", ""]
                gameLoop

main = do
    printIntroduction
    printInstructions
    gameLoop

