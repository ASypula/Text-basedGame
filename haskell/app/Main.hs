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
-- gameLoop :: State -> IO ()
-- gameLoop st = do
--     cmd <- readCommand
--     case cmd of
--         ["instructions"] -> do printInstructions
--                                gameLoop st
--         ["look"] -> do describeState st
--                        gameLoop st
--         ["take", objectName'] -> do printLines(getMsgForObjectPickUp objectName' st)
--                                     let newState = takeObjectIfExists objectName' st
--                                     gameLoop newState
--         ("take": _) -> do printLines ["Correct syntax is \"take OBJECT_NAME\"."]
--                           gameLoop st
--         ["inventory"] -> do printLines(getInventoryItemsDescription st)
--                             gameLoop st
--         ["investigate"] -> do investigateObject old_journal
--                               gameLoop st
--         ["quit"] -> return ()
--         _ -> do printLines ["Unknown command.", ""]
--                 gameLoop st

-- main = do
--     printIntroduction
--     printInstructions
--     describeState state
--     removeObjectFromRoom "lantern" "room_2" state
--     describeState state
    -- gameLoop state

-- TEST for 3rd room (obscured)
main = do
    describeState state
    let newState = removeAddition "obscured" state
    describeState newState

-- TEST moving a player
-- main = do
--     let (newState, moved) = move E state
--     print $ room $ player $ newState
--     moveOutcome newState moved

-- TEST: for testing object pick up
-- main = do
--     printIntroduction
--     printInstructions
--     describeState state
--     let inventoryObjectNames = getStringInventory (player state)
--     printLines inventoryObjectNames
--     let (newState, message) = takeObjectFromRoom "old_journal" "room_2" state
--     putStrLn message
--     describeState newState
--     let inventoryObjectNames = getStringInventory (player newState)
--     printLines inventoryObjectNames
