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

-- Hints
hint_room2 = "[Have a look at the journal]"
hint_room3 = "[When you cast light you can find useful objects here]"
-- TODO: hints to room4
hint_room8 = "[Use interact to speak with the student]"
hint_room12 = "[Try using light spell here]"
-- TODO: hints to room14
hint_room16 = "[An appropriate spell or something magnetic would help with obtaining the key]"

-- Rooms
room1 = Room {roomName = "room_1", objects = Nothing, hints = [], blocked = False, additions = []}
room2 = Room {roomName = "room_2", objects = Just [old_journal], hints = [hint_room2], blocked = False, additions = []}
room3 = Room {roomName = "room_3", objects = Just [rope], hints = [hint_room3], blocked = False, additions = ["obscured"]}
--TODO: room4
room5 = Room {roomName = "room_5", objects = Just [note], hints = [], blocked = False, additions = []}
room6 = Room {roomName = "room_6", objects = Just [magnet], hints = [], blocked = False, additions = []}
room8 = Room {roomName = "room_8", objects = Nothing, hints = [hint_room8], blocked = False, additions = []}
room10 = Room {roomName = "room_10", objects = Nothing, hints = [], blocked = False, additions = []}
room11 = Room {roomName = "room_11", objects = Just[ripped_page], hints = [], blocked = False, additions = []}
room12 = Room {roomName = "room_12", objects = Just [wolfsbane], hints = [hint_room12], blocked = False, additions = ["obscured"]}
room13 = Room {roomName = "room_13", objects = Just [ripped_journal], hints = [], blocked = False, additions = []}
--TODO room14
room15 = Room {roomName = "room_15", objects = Just [burned_journal], hints = [], blocked = False, additions = []}
room16 = Room {roomName = "room_16", objects = Just [potion, key, jar], hints = [], blocked = False, additions = []}


gamer = Player {room="room_3", inventory = Just [lantern]}
roomsMap =  Map.fromList [("room_1", room1), ("room_2", room2), ("room_3", room3), ("room_5", room5),
                        ("room_6", room6), ("room_8", room8), ("room_10", room10), ("room_11", room11),
                        ("room_12", room12), ("room_13", room13), ("room_15", room15), ("room_16", room16)]
-- TODO: additional rooms to roomsMap
state = State{player = gamer, rooms=roomsMap}