module Heart exposing (heart)

import Collage exposing (..)
import Color exposing (Color)


heart : Color -> Float -> Form
heart color width =
    let
        size =
            width * 0.585

        bump =
            circle (size / 2) |> filled color

        leftBump =
            bump
                |> moveX (0 - (size / 2))

        rightBump =
            bump
                |> moveY (size / 2)

        body =
            rect size size
                |> filled color
    in
        [ leftBump, rightBump, body ]
            |> group
            |> rotate (degrees -45)
            |> moveY (0 - size * 0.07)
