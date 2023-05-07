import Utils
import Actions
import Types
import RoomsSetup
import ObjectsSetup
import InitSetup
import qualified Data.Map as Map

-- Rooms fully done: room6, room10, room13, room15, room16
-- "obscured" implemented partially

introductionText = [
    "You are a wizard apprentice who failed their final exams, ",
    "thus General University of magic put you in a deadly dungeon.",
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
               
printIntroduction = printLines introductionText
printInstructions = printLines instructionsText

readCommand :: IO [String]
readCommand = do
    putStr "> "
    xs <- getLine
    return $ words xs

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
        ["take", objectName'] -> do let (newState, pickUpMsg) = takeObjectFromRoom objectName' (room (player st)) st
                                    printLines[pickUpMsg, ""]
                                    gameLoop newState
        ("take": _) -> do printLines ["Correct syntax is \"take OBJECT_NAME\"."]
                          gameLoop st
        ["inventory"] -> do printLines(getInventoryItemsDescription (player st))
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
    -- removeObjectFromRoom "lantern" "room_2" state
    -- describeState state
    gameLoop state
