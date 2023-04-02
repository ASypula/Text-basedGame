-- The germ of a text adventure game
-- Marcin Szlenk 2022

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
    "quit          -- to end the game and quit.",
    ""
    ]

-- print strings from list in separate lines
printLines :: [String] -> IO ()
printLines xs = putStr (unlines xs)
                  
printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

readCommand :: IO String
readCommand = do
    putStr "> "
    xs <- getLine
    return xs
    
-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: IO ()
gameLoop = do
    cmd <- readCommand
    case cmd of
        "instructions" -> do printInstructions
                             gameLoop
        "quit" -> return ()
        _ -> do printLines ["Unknown command.", ""]
                gameLoop

main = do
    printIntroduction
    printInstructions
    gameLoop

