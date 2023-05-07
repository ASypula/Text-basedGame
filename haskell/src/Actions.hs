module Actions where

import RoomsSetup
import Types
import Utils
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

moveOutcome :: State -> Bool -> IO ()
moveOutcome state result
    | result = describeRoom state
    | otherwise = printLines ["You cannot go that way."]

move :: Direction -> State -> (State, Bool)
move direction state =
    let currentRoomName = room (player state)
        currentRoom = fromMaybe (error "Current room not found") (Map.lookup currentRoomName (rooms state))
        possibleMove = possibleMoves currentRoomName direction
        isBlocked = case possibleMove of
                    Just (_, True) -> False
                    Nothing -> True
        destinationRoomName = case possibleMove of
                                Just (roomName, _) -> roomName
                                Nothing -> currentRoomName
        destinationRoom = fromMaybe (error "Destination room not found") (Map.lookup destinationRoomName (rooms state))
        newPlayer = (player state) { room = destinationRoomName }
        newState = state { player = newPlayer }
    in if isBlocked
            then (state, False)
        else (newState, True)

