module Actions where

import Types
import Utils

moveOutcome :: Maybe Room -> [String]
moveOutcome Nothing = ["You cannot go that way."]
moveOutcome room = describeRoom room
