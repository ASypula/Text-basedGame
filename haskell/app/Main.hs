import Utils
import Types
import RoomsSetup
import ObjectsSetup

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
    "look          -- look around again.",
    "quit          -- to end the game and quit.",
    ""
    ]

object1 = Object{objectName="old_journal"}
room1 = Room{roomName="room_2", objects= Just [object1], hints=Nothing}
                  
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
        "look" -> do describeRoom room1
                     printLines (additionalDescription room1)
                     gameLoop
        "investigate" -> do printLines (objectDescription object1)
                            gameLoop
        "quit" -> return ()
        _ -> do printLines ["Unknown command.", ""]
                gameLoop

main = do
    printIntroduction
    printInstructions
    describeRoom room1
    printLines (additionalDescription room1)
    gameLoop