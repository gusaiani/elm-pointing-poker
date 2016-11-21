module Room.Models exposing (Room)

import Dict


type alias Room =
    { question : Maybe String
    , items : Dict.Dict String Int
    }
