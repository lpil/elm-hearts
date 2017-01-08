module Main exposing (..)

import Html exposing (Html)
import Window
import Task
import Types exposing (..)
import View
import List.Extra
import HeartSize


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.root
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


init : ( Model, Cmd Msg )
init =
    let
        cmd =
            Task.perform WindowSize Window.size

        model =
            { windowWidth = 0
            , windowHeight = 0
            , windowCenterToCorner = 0
            , heartSizes = []
            }
    in
        ( model, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize sizes ->
            windowSize sizes model ! []


windowSize : { width : Int, height : Int } -> Model -> Model
windowSize { width, height } model =
    let
        hyp =
            hypotenuse width height
    in
        { model
            | windowWidth = width
            , windowHeight = height
            , windowCenterToCorner = hyp
            , heartSizes = HeartSize.list hyp
        }


hypotenuse : Int -> Int -> Int
hypotenuse a b =
    a ^ 2 + a ^ 2 |> toFloat |> sqrt |> ceiling
