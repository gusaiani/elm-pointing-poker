module Models exposing (..)

import Dict
import Room.Models exposing (Room)
import Login.Models exposing (Login, initLogin)


type alias Model =
    { room : Room
    , login : Login
    }


initModel : Model
initModel =
    Model (Room (Just "") Dict.empty) initLogin
