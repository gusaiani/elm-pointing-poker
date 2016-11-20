module Room.Models exposing (Room, Item, ItemId)

import Dict


type alias ItemId =
    String


type alias Item =
    { name : String
    , vote : Int
    }


type alias Room =
    { question : Maybe String
    , items : Dict.Dict String Int
    }
