module Types exposing (..)

import Lazy.List exposing (LazyList)
import Heart exposing (Heart)
import Window
import Time exposing (Time)
import Color exposing (Color)


type Msg
    = WindowSize Window.Size
    | NewTheme (List Color)
    | NewThemeTick Time
    | AnimationTick Time
    | NewHeartTick Time


type alias Model =
    { windowWidth : Int
    , windowHeight : Int
    , windowHyp : Float
    , hearts : List Heart
    , heartStream : LazyList Heart
    }
