port module Room.Commands exposing (..)

import Dict
import Json.Decode as Decode exposing (field)
import Json.Encode as Encode
import Task
import Room.Models exposing (Item, ItemId, Room)
import Room.Messages exposing (..)


port fbVote : {id: String, vote: Int} -> Cmd msg
port fbEditQuestion : String -> Cmd msg


receive : Encode.Value -> Cmd Msg
receive json =
    let
        decodedItemsResult =
            Decode.decodeValue roomDecoder json


        room =
            case decodedItemsResult of
                Ok decodedItems ->
                    decodedItems

                Err err ->
                    let
                        _ =  Debug.log "error" err
                    in
                        Room (Just "ERROR") Dict.empty
    in
        Task.perform RoomUpdate (Task.succeed room)


roomDecoder : Decode.Decoder Room
roomDecoder =
    Decode.map2 Room
        (Decode.maybe (field "question" Decode.string))
        (field "users" (Decode.dict Decode.int))


itemEncoded : Item -> Encode.Value
itemEncoded item =
        [ ( "name", Encode.string item.name )
        , ( "vote", Encode.int item.vote )
        ]
            |> Encode.object
