module Room.Update exposing (update)

import Room.Commands exposing (fbEditQuestion, fbVote)
import Room.Messages exposing (Msg(..))
import Room.Models exposing (Room, Item)

update : Msg -> Room -> String -> ( Room, Cmd Msg )
update msg room userId =
    case msg of
        RoomUpdate newRoom ->
            ( newRoom, Cmd.none )

        EditQuestion newQuestion ->
            ( { room | question = (Just newQuestion)}, fbEditQuestion newQuestion)

        Vote vote ->
            ( room, fbVote ({ id = userId
                            , vote = vote }))
