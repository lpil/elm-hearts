module Types exposing (..)

import Lazy.List exposing (LazyList)
import Heart exposing (Heart)
import Window
import Time exposing (Time)


type Msg
    = WindowSize Window.Size
    | AnimationTick Time
    | NewHeartTick Time


type alias Model =
    { windowWidth : Int
    , windowHeight : Int
    , windowHyp : Float
    , hearts : List Heart
    , heartStream : LazyList Heart
    }
