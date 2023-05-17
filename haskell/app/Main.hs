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
    case gameEnding st of
      "notReached" -> do cmd <- readCommand
                         case cmd of
                            ["debug", roomName'] -> do let (newState, result) = unlock roomName' st
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
                            ["quit"] -> return()
                            _ -> do printLines ["Unknown command.", ""]
                                    gameLoop st
      "beastDefeated" -> printLines ["The beast looks at you in disbelief before collapsing to the ground. It doesn't move ever again. The exit is left unguarded.", "You did it. You made it out alive. The exams surely can't be worse than this. However there is something that might...", "The High University of Magic was not thrilled with an idea of student actually getting out of their deadly dungeon.", "The High Wizards were especially irritated about the loss of their favourite beast. You will have to settle this with the Dean of Magic himself.", "You escaped the deadly dungeon only to start much more frightening battle - writing an official letter.", ""]
      "crueltyWins" -> printLines ["Darth Sidious has been watching you from his reborn empire at Byss in the Deep Core of the Galaxy.\n Seeing your infinite cruelty (you have tried to kill a sleeping dragonling) he creates an intergalactic portal and takes you to Byss.\nNow he is going to make you hist dark side puppet...\nYou are never going to break out of these chains.. so it is better for you to consider yourself dead."]

main = do
    printIntroduction
    printInstructions
    describeState state
    -- removeObjectFromRoom "lantern" "room_2" state
    -- describeState state
    gameLoop state
