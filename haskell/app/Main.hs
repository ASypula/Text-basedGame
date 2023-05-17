import Utils
import Actions
import Types
import RoomsSetup
import ObjectsSetup
import InitSetup
-- import Data.Maybe (fromMaybe)
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
    "instructions               -- to see these instructions.",
    "look                       -- look around again.",
    "take OBJECT_NAME           -- take object (into your inventory).",
    "investigate OBJECT_NAME    -- investigate object's details.",
    "cast SPELL SPELL_COMPONENT -- to cast a spell using correct component.",
    "quit                       -- to end the game and quit.",
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
        ["debug", roomName'] -> do  let (newState, result) = unlock roomName' st
                                    unlockOutcome result
                                    gameLoop newState
        ["instructions"] -> do printInstructions
                               gameLoop st
        ["look"] -> do describeState st
                       gameLoop st
        ["take", objectName'] -> do let (newState, pickUpMsg) = takeObjectFromRoom objectName' (room (player st)) st
                                    printLines[pickUpMsg, ""]
                                    gameLoop newState
        ("take": _) -> do printLines ["Correct syntax is \"take OBJECT_NAME\".", ""]
                          gameLoop st
        ["inventory"] -> do printLines(getInventoryItemsDescription (player st))
                            gameLoop st
        ["investigate", objectName'] -> do let investigationMsg = investigateObject objectName' (room (player st)) st
                                           printLines[investigationMsg, ""]
                                           gameLoop st
        ("investigate": _) -> do printLines ["Correct syntax is \"investigate OBJECT_NAME\".", ""]
                                 gameLoop st
        ["e"] -> do let (newState, moved) = move E st
                    moveOutcome newState moved
                    gameLoop newState
        ["w"] -> do let (newState, moved) = move W st
                    moveOutcome newState moved
                    gameLoop newState
        ["n"] -> do let (newState, moved) = move N st
                    moveOutcome newState moved
                    gameLoop newState
        ["s"] -> do let (newState, moved) = move S st
                    moveOutcome newState moved
                    gameLoop newState
        ["cast", spell, spellComponent] -> do let (newState, spellResultMsg) = cast st spell spellComponent
                                              printLines[spellResultMsg, ""]
                                              gameLoop newState
        ("cast": _) -> do printLines["Correct syntax is \"cast SPELL SPELL_COMPONENT\"", ""]
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
