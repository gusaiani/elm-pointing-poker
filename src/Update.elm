module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Room.Update
import Login.Update
import Room.Commands exposing (receive)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RoomMsg subMsg ->
            let
                ( newRoom, cmd ) =
                    Room.Update.update subMsg model.room model.login.userName
            in
                ( { model | room = newRoom }, Cmd.map RoomMsg cmd )

        LoginMsg subMsg ->
            let
                ( authData, cmd ) = Login.Update.update subMsg model.login
            in
                ( { model | login = authData }, Cmd.map LoginMsg cmd )

        ReceiveFBData json ->
            ( model, Cmd.map RoomMsg (receive json) )
