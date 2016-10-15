module Main exposing (..)

import Html exposing (..)
import Html.App
import Svg exposing (ellipse)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onClick)
import Material.Grid exposing (grid, cell, size, Device(..))
import Material.Options exposing (Style, css)
import Material.Scheme
import Material.Badge


style : List (Style a)
style =
    [ css "text-sizing" "border-box"
    , css "padding-left" "8px"
    , css "padding-top" "4px"
    ]


type alias Model =
    { bets : List Bet }


model : Model
model =
    { bets = bets }


type alias Bet =
    { question : String
    , value : Int
    }


bets : List Bet
bets =
    [ { question = "will be the winner.", value = 2 }
    , { question = "will garner a #blindside after being voted out.", value = 1 }
    , { question = "will find a hidden immunity idol", value = 1 }
    , { question = "will receive ten or more votes (including votes negated by idols, not including winner votes).", value = 1 }
    , { question = "will be a member of the jury.", value = 1 }
    , { question = "will win an individual immunity challenge.", value = 1 }
    , { question = "will get the most confessionals in the premiere.", value = 2 }
    , { question = "will mention the name of a survivor castaway from a previous season", value = 1 }
    , { question = "will be blindfolded at some point during a challenge.", value = 1 }
    , { question = "will receive five or less votes (including votes negated by idols, not including winner votes).", value = 1 }
    , { question = "will give Jeff Probst a hug (not including live reading of votes or reunion show).", value = 2 }
    , { question = "will sit out three total challenges (for whatever reason)", value = 1 }
    , { question = "will have an episode with 10 or more confessionals.", value = 1 }
    , { question = "will be quoted in a hashtag", value = 1 }
    , { question = "will have an episode title come from his or her quote.", value = 1 }
    , { question = "will go straight to Jeff without saying any words after being voted out.", value = 1 }
    , { question = "will last in an endurance challenge for over an hour", value = 1 }
    , { question = "will attend 10 tribal councils as a player (as a jury member doesn’t count).", value = 1 }
    , { question = "will get a confessional in every episode they are still in the game (jury members don’t count as being “in the game”)", value = 1 }
    , { question = "will write a vote that is the last vote read to send someone home", value = 1 }
    ]


contentants : List String
contentants =
    [ "Adam"
    , "Bret"
    , "Chris"
    , "CeCe"
    , "David"
    , "Figgy"
    , "Hannah"
    , "Jessica"
    , "Jay"
    , "Ken"
    , "Lucy"
    , "Mari"
    , "Michaela"
    , "Michelle"
    , "Paul"
    , "Rachel"
    , "Sunday"
    , "Taylor"
    , "Will"
    ]


type Msg
    = CoinClick


init : ( Model, Cmd Msg )
init =
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Prop Bets" ]
        , Svg.svg
            [ width "130", height "130", viewBox "0 0 20 20" ]
            (List.concatMap
                (\stackNumber -> coinStack stackNumber)
                [1..3]
            )
        , grid [] (betQuestions model)
        ]
        |> Material.Scheme.top


betQuestions : Model -> List (Material.Grid.Cell Msg)
betQuestions model =
    List.concatMap
        (\bet ->
            [ cell [ size All 2 ] [ text "coins" ]
            , cell [ size All 2 ] [ text "name" ]
            , cell [ size All 8 ]
                [ text bet.question
                , if bet.value > 1 then
                    Material.Options.span
                        [ Material.Badge.add ("x" ++ (toString <| bet.value)) ]
                        []
                  else
                    Material.Options.span [] []
                ]
            ]
        )
        model.bets


coinStack : Int -> List (Svg.Svg Msg)
coinStack stackNumber =
    (List.map (\coinNumber -> coin coinNumber stackNumber) [1..10])


coin : Int -> Int -> Svg.Svg Msg
coin coinNumber stackNumber =
    let
        positionX =
            2 * (stackNumber * 2) |> toString

        positionY =
            17 - (0.5 * (toFloat <| coinNumber)) |> toString
    in
        (ellipse [ cx positionX, cy positionY, rx "2", ry "1.5", fill "none", fill "gold", stroke "white", strokeWidth ".2", onClick CoinClick ] [])


main : Program Never
main =
    Html.App.program
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
