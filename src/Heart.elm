module Heart
    exposing
        ( Heart
        , new
        , limitedGrow
        , grow
        , toForm
        , fromObject
        )

import Color exposing (Color)
import Collage exposing (Form)


type Heart
    = Heart
        { color : Color
        , width : Float
        }


{-| TODO: Remove
-}
fromObject : { width : Float, color : Color } -> Heart
fromObject obj =
    Heart obj


new : Color -> Heart
new c =
    Heart { width = 1, color = c }


grow : Heart -> Heart
grow (Heart h) =
    Heart { h | width = 1 + h.width * 1.02 }


limitedGrow : Float -> Heart -> Maybe Heart
limitedGrow limit heart =
    let
        grown =
            grow heart

        (Heart h) =
            grown
    in
        if h.width > limit then
            Nothing
        else
            Just grown


toForm : Heart -> Form
toForm (Heart { color, width }) =
    let
        size =
            width * 0.585

        bump =
            Collage.circle (size / 2) |> Collage.filled color

        leftBump =
            bump
                |> Collage.moveX (0 - (size / 2))

        rightBump =
            bump
                |> Collage.moveY (size / 2)

        body =
            Collage.rect size size
                |> Collage.filled color
    in
        [ leftBump, rightBump, body ]
            |> Collage.group
            |> Collage.rotate (degrees -45)
            |> Collage.moveY (0 - size * 0.07)
