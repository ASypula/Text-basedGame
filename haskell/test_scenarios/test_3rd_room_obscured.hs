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

-- TEST: 3rd room (obscured)
main = do
    describeState state
    let newState = removeAddition "obscured" state
    describeState newState
