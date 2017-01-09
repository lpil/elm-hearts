module Update exposing (..)

import Types exposing (..)
import Color exposing (Color)
import Heart exposing (Heart)
import Heart.Stream


newTheme : List Color -> Model -> Model
newTheme theme model =
    { model | heartStream = Heart.Stream.new theme }


animationFrame : Float -> Model -> Model
animationFrame time model =
    let
        limit =
            model.windowHyp * 3

        hearts =
            List.filterMap (Heart.limitedGrow limit) model.hearts
    in
        { model | hearts = hearts }


newHeartTick : Model -> Model
newHeartTick model =
    let
        ( heart, stream ) =
            Heart.Stream.safeNext model.heartStream
    in
        { model
            | hearts = (heart :: model.hearts)
            , heartStream = stream
        }


windowSize : { width : Int, height : Int } -> Model -> Model
windowSize { width, height } model =
    let
        hypotenuse =
            width ^ 2 + height ^ 2 |> toFloat |> sqrt
    in
        { model
            | windowWidth = width
            , windowHeight = height
            , windowHyp = hypotenuse
        }
            |> newHeartTick
