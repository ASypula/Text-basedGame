import Utils
import Types


object1 = Object{objectName="old_journal"}
object2 = Object{objectName="old_journal1"}
room2 = Room{roomName="room_2", objects= Just [object1, object2], hints=Nothing, blocked=False}

main = do
    describeRoom room2