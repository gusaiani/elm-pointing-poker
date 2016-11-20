module Messages exposing (..)

import Room.Messages
import Login.Messages
import Json.Encode as Encode


type Msg
    = RoomMsg Room.Messages.Msg
    | LoginMsg Login.Messages.Msg
    | ReceiveFBData Encode.Value
