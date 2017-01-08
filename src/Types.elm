module Types exposing (..)

import Window


type Msg
    = WindowSize Window.Size


type alias Model =
    { windowWidth : Int
    , windowHeight : Int
    , maxSize : Int
    , heartSizes : List Float
    }
