module View exposing (root)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Color
import Types exposing (..)


heart : Float -> Form
heart width =
    let
        size =
            width * 0.585

        bump =
            circle (size / 2) |> filled Color.red

        leftBump =
            bump
                |> moveX (0 - (size / 2))

        rightBump =
            bump
                |> moveY (size / 2)

        body =
            rect size size
                |> filled Color.red
    in
        [ leftBump, rightBump, body ]
            |> group
            |> rotate (degrees -45)
            |> moveY (0 - size * 0.07)


root : Model -> Html msg
root model =
    [ heart 1000
    ]
        |> collage model.windowWidth model.windowHeight
        |> Element.toHtml
