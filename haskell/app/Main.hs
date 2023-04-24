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
    "instructions       -- to see these instructions.",
    "look               -- look around again.",
    "take OBJECT_NAME   -- take object (into your inventory).",
    "investigate        -- investigate object's details.",
    "quit               -- to end the game and quit.",
    ""
    ]

old_journal = Object{objectName="old_journal"}
lantern = Object{objectName="lantern"}
room_2 = Room{roomName="room_2", objects= Just [old_journal], hints=Nothing}
state = State{room=room_2, inventory = Just [lantern], existingObjects = Just [lantern, old_journal]}
                  
printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

readCommand :: IO [String]
readCommand = do
    putStr "> "
    xs <- getLine
    return $ words xs


-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: IO ()
gameLoop = do
    cmd <- readCommand
    case cmd of
        ["instructions"] -> do printInstructions
                               gameLoop
        ["look"] -> do describeState state
                       gameLoop
        ["take", objectName'] -> do printLines(takeObjectIfExists objectName' state)
                                    gameLoop
        ("take": _) -> do printLines ["Correct syntax is \"take OBJECT_NAME\"."]
                          gameLoop
        ["investigate"] -> do investigateObject old_journal
                              gameLoop
        ["quit"] -> return ()
        _ -> do printLines ["Unknown command.", ""]
                gameLoop

main = do
    printIntroduction
    printInstructions
    describeState state
    gameLoop