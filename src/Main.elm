module Main exposing (..)

import Html exposing (Html)
import AnimationFrame
import Time
import Window
import Task
import Types exposing (..)
import View
import Heart
import Heart.Stream


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.root
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        cmd =
            Task.perform WindowSize Window.size

        model =
            { windowWidth = 0
            , windowHeight = 0
            , windowHyp = 0
            , heartStream = Heart.Stream.new
            , hearts = []
            }
    in
        ( model, cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    [ AnimationFrame.times AnimationTick
    , Time.every (Time.second / 3) NewHeartTick
    ]
        |> Sub.batch


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize sizes ->
            windowSize sizes model ! []

        NewHeartTick _ ->
            newHeartTick model ! []

        AnimationTick time ->
            animationFrame time model ! []


animationFrame : Float -> Model -> Model
animationFrame time model =
    let
        limit =
            model.windowHyp * 3

        hearts =
            List.filterMap (Heart.limitedGrow limit) model.hearts
    in
        { model | hearts = hearts }


newHeartTick : Model -> Model
newHeartTick model =
    let
        ( heart, stream ) =
            Heart.Stream.safeNext model.heartStream
    in
        { model
            | hearts = (heart :: model.hearts)
            , heartStream = stream
        }


windowSize : { width : Int, height : Int } -> Model -> Model
windowSize { width, height } model =
    let
        hypotenuse =
            width ^ 2 + height ^ 2 |> toFloat |> sqrt
    in
        { model
            | windowWidth = width
            , windowHeight = height
            , windowHyp = hypotenuse
        }
            |> newHeartTick
