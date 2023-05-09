module Actions where

import RoomsSetup
import Types
import Utils
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

moveOutcome :: State -> PathState -> IO ()
moveOutcome state result
    | result == OPEN = describeRoom state
    | result == BLOCKED = printLines ["That path is blocked."]
    | otherwise = printLines ["You cannot go that way."]

move :: Direction -> State -> (State, PathState)
move direction state =
    let currentRoomName = room (player state)
        currentRoom = fromMaybe (error "Current room not found") (Map.lookup currentRoomName (rooms state))
        possibleMove = possibleMoves currentRoomName direction (blocades state)
        destinationRoomName = case possibleMove of
                                Just (roomName, _) -> roomName
                                Nothing -> currentRoomName
        destinationRoom = fromMaybe (error "Destination room not found") (Map.lookup destinationRoomName (rooms state))
        newPlayer = (player state) { room = destinationRoomName }
        newState = state { player = newPlayer }
    in case possibleMove of
        Just (_, True) -> (newState, OPEN)
        Just (_, False) -> (state, BLOCKED)
        Nothing -> (state, NONE)

