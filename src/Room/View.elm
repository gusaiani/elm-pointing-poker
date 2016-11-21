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


renderButton : (Int, String) -> (String, Html Msg)
renderButton (vote, label) =
    ( label
    , p [ class "control" ]
        [ a
            [ class "button"
            , onClick (Vote vote)
            ]
            [ text label ]
        ]
    )


renderVoteSection : Html Msg
renderVoteSection =
    let
        items = [ (1, "1 point")
                , (2, "2 points")
                , (3, "3 points")
                , (4, "4 points")
                , (5, "5 points")
                ]
        buttons = List.map renderButton items
    in
        div []
            [ label [ class "label" ] [ text "Your Vote" ]
            , Keyed.node "div" [class "control is-grouped"] (buttons)
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
