module Login.View exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (..)
import Login.Messages exposing (..)
import Login.Models exposing (Login)


view : Login -> Html Msg
view login =
    div []
        [ p [ class "control has-icon" ]
            [ input [ class "input"
                    , placeholder "Room name"
                    , onInput EditRoomName
                    , value login.roomName]
                    []
            , i [ class "fa fa-home" ] []
            ]
        , p [ class "control has-icon" ]
            [ input [ class "input"
                    , placeholder "Name"
                    , onInput EditUserName
                    , value login.userName]
                    []
            , i [ class "fa fa-user" ] []
            ]
        , p [ class "control" ]
            [ button [ class "button is-success"
                     , onClick SubmitForm]
                     [ text "Join" ]
            ]
        ]
