module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, placeholder, value)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Room.View
import Login.View


view : Model -> Html Msg
view model =
    if model.login.isValid then
        div [ class "content" ]
            [ renderHeader model
            , renderPage model
            ]
    else
        div [ class "content" ]
            [ renderHeader model
            , Html.map LoginMsg (Login.View.view model.login)
            ]


renderHeader : Model -> Html Msg
renderHeader model =
    nav [ class "nav" ]
        [ div [ class "nav-left" ]
            [ a [ class "nav-item is-brand", Html.Attributes.href "#" ]
                [ text "Pointing Poker" ]
            ]
        , div [ class "nav-right nav-menu" ]
            [ span [ class "nav-item" ]
                [ a [ class "button is-primary", Html.Attributes.href "https://github.com/liubko/elm-pointing-poker" ]
                    [ span [ class "icon" ]
                        [ i [ class "fa fa-github" ]
                            []
                        ]
                    , span []
                        [ text "Source" ]
                    ]
                ]
            ]
        ]



-- section [ class "hero is-info is-bold" ]
--     [ div [ class "hero-body" ]
--         [ div [ class "container" ]
--             [ h1 [ class "title" ]
--                 [ text "Pointing Poker" ]
--             , text ("Room: " ++ model.login.roomName)
--             , br [] []
--             , text ("User: " ++ model.login.userName)
--             ]
--         ]
--     ]


renderPage : Model -> Html Msg
renderPage model =
    div [ class "container" ]
        [ Html.map RoomMsg (Room.View.view model.room)
        ]
