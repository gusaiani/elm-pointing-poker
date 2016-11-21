module Login.Update exposing (update)

import Login.Commands exposing (fbJoinRoom, validateLogin)
import Login.Messages exposing (Msg(..))
import Login.Models exposing (Login)


update : Msg -> Login -> ( Login, Cmd Msg )
update msg login =
    case msg of
        LoginUpdate newLogin ->
            ( newLogin, Cmd.none )

        EditRoomName name ->
            ( { login | roomName = name }, Cmd.none )

        EditUserName name ->
            ( { login | userName = name }, Cmd.none )

        SubmitForm ->
            let
                newLogin =
                    validateLogin login

                cmd =
                    case newLogin.isValid of
                        True ->
                            fbJoinRoom login

                        False ->
                            Cmd.none
            in
                ( newLogin, cmd )
