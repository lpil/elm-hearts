module Main exposing (..)

import Html exposing (Html)
import Window
import Task
import Types exposing (..)
import View


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = View.root
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        WindowSize { width, height } ->
            { model | windowWidth = width, windowHeight = height } ! []


init : ( Model, Cmd Msg )
init =
    let
        cmd =
            Task.perform WindowSize Window.size

        model =
            { windowWidth = 0, windowHeight = 0 }
    in
        ( model, cmd )
