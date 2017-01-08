module Types exposing (..)

import Window


type Msg
    = WindowSize Window.Size


type alias Model =
    { windowWidth : Int, windowHeight : Int }
