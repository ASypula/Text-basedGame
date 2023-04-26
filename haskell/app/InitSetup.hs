module InitSetup where

import Utils
import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map

lantern = Object{objectName="lantern"}
old_journal = Object{objectName="old_journal"}
room2 = Room {roomName = "room_2", objects = Just [lantern, old_journal], hints = Nothing, blocked = False}
room3 = Room {roomName = "room_3", objects = Nothing, hints = Nothing, blocked = False}
gamer = Player {room="room_2", inventory = Nothing}
roomsMap =  Map.fromList [("room_2", room2), ("room_3", room3)]
state = State{player = gamer, rooms=roomsMap}