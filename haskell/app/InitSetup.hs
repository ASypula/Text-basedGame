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
rusty_key = Object{objectName="rusty_key"}
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
room0 = Room {roomName = "room_0", objects =  [], hints = [], blocked = False, additions = []}
room1 = Room {roomName = "room_1", objects =  [badge], hints = [], blocked = False, additions = []}
room2 = Room {roomName = "room_2", objects = [old_journal], hints = [hint_room2], blocked = False, additions = ["trapdoor"]}
room3 = Room {roomName = "room_3", objects = [rope], hints = [hint_room3], blocked = False, additions = ["obscured"]}
room4 = Room {roomName = "room_4", objects = [nightcap, firefly], hints = [], blocked = False, additions = []}
room4N = Room {roomName = "room_4N", objects = [nightcap, firefly], hints = [], blocked = False, additions = []}
room4S = Room {roomName = "room_4S", objects = [firefly], hints = [], blocked = False, additions = []}
--TODO: write function to move objects from 4N and 4S to 4 upon unlocking
room5 = Room {roomName = "room_5", objects = [note], hints = [], blocked = False, additions = []}
room6 = Room {roomName = "room_6", objects = [magnet], hints = [], blocked = False, additions = []}
room8 = Room {roomName = "room_8", objects =  [], hints = [hint_room8], blocked = False, additions = []}
room10 = Room {roomName = "room_10", objects =  [], hints = [], blocked = False, additions = []}
room11 = Room {roomName = "room_11", objects = [ripped_page], hints = [], blocked = False, additions = []}
room12 = Room {roomName = "room_12", objects = [wolfsbane], hints = [hint_room12], blocked = False, additions = ["obscured"]}
room13 = Room {roomName = "room_13", objects = [ripped_journal], hints = [], blocked = False, additions = []}
room14 = Room {roomName = "room_14", objects = [cheat_sheet, beer, book_fragment], hints = [], blocked = False, additions = []}
room14W = Room {roomName = "room_14W", objects =  [], hints = [], blocked = False, additions = []}
room14S = Room {roomName = "room_14S", objects =  [], hints = [], blocked = False, additions = []}
room15 = Room {roomName = "room_15", objects = [burned_journal], hints = [], blocked = False, additions = []}
room16 = Room {roomName = "room_16", objects = [potion, key, jar], hints = [], blocked = False, additions = []}


gamer = Player {room="room_2", inventory = [lantern, rusty_key, magnet]}
roomsMap =  Map.fromList [("room_0", room0), ("room_1", room1), ("room_2", room2), ("room_3", room3), ("room_5", room5),
                        ("room_6", room6), ("room_8", room8), ("room_10", room10), ("room_11", room11),
                        ("room_12", room12), ("room_13", room13), ("room_15", room15), ("room_16", room16), 
                        ("room_4", room4),("room_4N", room4N),("room_4S", room4S),("room_14", room14),("room_14W", room14W),("room_14S", room14S)]
-- TODO: additional rooms to roomsMap
state = State{player = gamer, rooms=roomsMap, blockades=["room_0", "room_4", "room_14", "room_12", "room_13", "room_5"], spells=["light", "grab", "open", "sleep", "power_word_kill"], gameEnding="notReached"}