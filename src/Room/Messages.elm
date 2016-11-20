module Room.Messages exposing (..)

import Room.Models exposing (Room, Item, ItemId)


type Msg
    = RoomUpdate Room
    | EditQuestion String
    | Vote Int
