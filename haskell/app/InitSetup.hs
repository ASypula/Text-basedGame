module InitSetup where

import Utils
import Types
import RoomsSetup
import ObjectsSetup
import qualified Data.Map as Map

-- Objects
lantern = Object{objectName="lantern"}
old_journal = Object{objectName="old_journal"}
firefly = Object{objectName="firefly"}
burned_journal = Object{objectName="burned_journal"}
jar = Object{objectName="jar"}
key = Object{objectName="key"}
cheat_sheet = Object{objectName="cheat_sheet"}
magnet = Object{objectName="magnet"}
rope = Object{objectName="rope"}
potion = Object{objectName="potion"}
nightcap = Object{objectName="nightcap"}
note = Object{objectName="note"}
book_fragment = Object{objectName="book_fragment"}
ripped_page = Object{objectName="ripped_page"}
ripped_journal = Object{objectName="ripped_journal"}
beer = Object{objectName="beer"}
wolfsbane = Object{objectName="wolfsbane"}
badge = Object{objectName="badge"}

-- Rooms
room1 = Room {roomName = "room_1", objects = Nothing, hints = Nothing, blocked = False}
room2 = Room {roomName = "room_2", objects = Just [old_journal], hints = Nothing, blocked = False}
room3 = Room {roomName = "room_3", objects = Just [rope], hints = Nothing, blocked = False}
--TODO: room4
room5 = Room {roomName = "room_5", objects = Just [note], hints = Nothing, blocked = False}
room6 = Room {roomName = "room_6", objects = Just [magnet], hints = Nothing, blocked = False}
room8 = Room {roomName = "room_8", objects = Nothing, hints = Nothing, blocked = False}
room10 = Room {roomName = "room_10", objects = Nothing, hints = Nothing, blocked = False}
room11 = Room {roomName = "room_11", objects = Just[ripped_page], hints = Nothing, blocked = False}
room12 = Room {roomName = "room_12", objects = Just [wolfsbane], hints = Nothing, blocked = False}
room13 = Room {roomName = "room_13", objects = Just [ripped_journal], hints = Nothing, blocked = False}
--TODO room14
room15 = Room {roomName = "room_15", objects = Just [burned_journal], hints = Nothing, blocked = False}
room16 = Room {roomName = "room_16", objects = Just [potion, key, jar], hints = Nothing, blocked = False}


gamer = Player {room="room_2", inventory = Nothing}
roomsMap =  Map.fromList [("room_1", room1), ("room_2", room2), ("room_3", room3), ("room_5", room5),
                        ("room_6", room6), ("room_8", room8), ("room_10", room10), ("room_11", room11),
                        ("room_12", room12), ("room_13", room13), ("room_15", room15), ("room_16", room16)]
state = State{player = gamer, rooms=roomsMap}