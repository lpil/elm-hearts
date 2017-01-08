module View exposing (root)

import Html exposing (Html)
import Collage exposing (Form)
import Element
import Color exposing (Color)
import Types exposing (..)
import Heart
import Lazy.List exposing (LazyList)


colors : LazyList Color
colors =
    [ Color.red
    , Color.blue
    , Color.green
    ]
        |> Lazy.List.fromList
        |> Lazy.List.cycle


coloredHeart : ( Color, Float ) -> Form
coloredHeart =
    uncurry Heart.heart


root : Model -> Html msg
root model =
    model.heartSizes
        |> Lazy.List.fromList
        |> Lazy.List.zip colors
        |> Lazy.List.map coloredHeart
        |> Lazy.List.toList
        |> Collage.collage model.windowWidth model.windowHeight
        |> Element.toHtml
