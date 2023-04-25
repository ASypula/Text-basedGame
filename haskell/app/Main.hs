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



-- object1 = Object{objectName="old_journal"}
-- object2 = Object{objectName="old_journal1"}
-- room2 = Room{roomName="room_2", objects= Just [object1, object2], hints=Nothing, blocked=False}

-- main = do
--     describeRoom room2

-- note that the game loop may take the game state as
-- an argument, eg. gameLoop :: State -> IO ()
gameLoop :: State -> IO ()
gameLoop st = do
    cmd <- readCommand
    case cmd of
        ["instructions"] -> do printInstructions
                               gameLoop st
        ["look"] -> do describeState st
                       gameLoop st
        ["take", objectName'] -> do printLines(getMsgForObjectPickUp objectName' st)
                                    let newState = takeObjectIfExists objectName' st
                                    gameLoop newState
        ("take": _) -> do printLines ["Correct syntax is \"take OBJECT_NAME\"."]
                          gameLoop st
        ["inventory"] -> do printLines(getInventoryItemsDescription st)
                            gameLoop st
        ["investigate"] -> do investigateObject old_journal
                              gameLoop st
        ["quit"] -> return ()
        _ -> do printLines ["Unknown command.", ""]
                gameLoop st

main = do
    printIntroduction
    printInstructions
    describeState state
    gameLoop state
