module Room.View exposing (..)

import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Keyed as Keyed
import Room.Messages exposing (..)
import Room.Models exposing (Item, ItemId, Room)


view : Room -> Html Msg
view room =
    div [ class "columns column is-10 is-offset-1" ]
        [ div [ class "column" ]
            [ renderQuestionSection room.question
            , renderVoteSection
            ]
        , div [ class "column is-5" ]
            [ renderUsersSection (Dict.toList room.items)
            ]
        ]


renderQuestionSection : Maybe String -> Html Msg
renderQuestionSection question =
    let
        val =
            case question of
                Just q ->
                    q

                Nothing ->
                    ""
    in
        div [ class "control is-grouped" ]
            [ p [ class "control is-expanded" ]
                [ label [ class "label" ] [ text "Question" ]
                , input
                    [ class "input"
                    , placeholder "Enter task description"
                    , onInput EditQuestion
                    , value val
                    ]
                    []
                ]
            ]


renderVoteSection : Html Msg
renderVoteSection =
    div []
        [ label [ class "label" ] [ text "Your Vote" ]
        , div [ class "control is-grouped" ]
            [ p [ class "control" ]
                [ a
                    [ class "button"
                    , onClick (Vote 1)
                    ]
                    [ text "1 point" ]
                ]
            , p [ class "control" ]
                [ a
                    [ class "button"
                    , onClick (Vote 2)
                    ]
                    [ text "2 points" ]
                ]
            , p [ class "control" ]
                [ a
                    [ class "button"
                    , onClick (Vote 3)
                    ]
                    [ text "3 points" ]
                ]
            , p [ class "control" ]
                [ a
                    [ class "button"
                    , onClick (Vote 4)
                    ]
                    [ text "4 points" ]
                ]
            , p [ class "control" ]
                [ a
                    [ class "button"
                    , onClick (Vote 5)
                    ]
                    [ text "5 points" ]
                ]
            ]
        ]


renderUsersSection : List ( String, Int ) -> Html Msg
renderUsersSection items =
    let
        userList =
            items
                |> List.map renderUser
        totalVotes =
            items
                |> List.map (\(a, b) -> b)
                |> List.sum

        numOfVotes =
            items
                |> List.filter (\(a, b) -> b >= 0)
                |> List.length

        average = toFloat totalVotes / toFloat numOfVotes
    in
        div []
        [ label [ class "label" ] [ text ("Average Score: " ++ (toString average)) ]
        , table [ class "table" ]
              [ thead []
                  [ tr []
                      [ th []
                          [ text "Name" ]
                      , th []
                          [ text "Points" ]
                      ]
                  ]
              , Keyed.node "tbody" [] (userList)
              ]
        ]


renderUser : ( String, Int ) -> ( String, Html Msg )
renderUser ( name, vote ) =
    ( (toString name)
    , tr []
        [ td []
            [ text name ]
        , td []
            [ Html.b [] [ text (toString vote) ] ]
        ]
    )
