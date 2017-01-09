module Main exposing (..)

import Html exposing (Html)
import AnimationFrame
import Time
import Random
import Window
import Task
import Types exposing (..)
import View
import Theme
import Update
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
    { windowWidth = 0
    , windowHeight = 0
    , windowHyp = 0
    , heartStream = Heart.Stream.new Theme.pastelPurpleDawn
    , hearts = []
    }
        ! [ newThemeCmd, getWindowSizeCmd ]


newThemeCmd : Cmd Msg
newThemeCmd =
    Random.generate NewTheme Theme.random


getWindowSizeCmd : Cmd Msg
getWindowSizeCmd =
    Task.perform WindowSize Window.size


subscriptions : Model -> Sub Msg
subscriptions model =
    [ AnimationFrame.times AnimationTick
    , Time.every (Time.second / 3) NewHeartTick
    , Time.every (Time.second * 7) NewThemeTick
    , Window.resizes WindowSize
    ]
        |> Sub.batch


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize sizes ->
            Update.windowSize sizes model ! []

        NewHeartTick _ ->
            Update.newHeartTick model ! []

        AnimationTick time ->
            Update.animationFrame time model ! []

        NewTheme theme ->
            Update.newTheme theme model ! []

        NewThemeTick _ ->
            model ! [ newThemeCmd ]
