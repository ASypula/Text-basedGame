import Utils
import Types


object1 = Object{objectName="old_journal"}
object2 = Object{objectName="O2"}
room1 = Room{roomName="room_2", objects= Just [object1, object2], hints=Nothing}

main = do
    describeRoom room1