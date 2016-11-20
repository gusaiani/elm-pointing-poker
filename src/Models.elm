module Models exposing (..)

import Dict
import Room.Models exposing (Room)
import Login.Models exposing (Login)


type alias Model =
    { room : Room
    , login: Login
    }


initModel : Model
initModel =
    Model (Room (Just "") Dict.empty) (Login "" "" False)
    -- Model (Room "" Dict.empty) "Demo" "-KWxMnF7pq-afV2uovDP"
