module View exposing (root)

import Html exposing (Html)
import Collage exposing (..)
import Element
import Types exposing (..)
import Heart


root : Model -> Html msg
root model =
    model.hearts
        |> List.reverse
        |> List.map Heart.toForm
        |> Collage.collage model.windowWidth model.windowHeight
        |> Element.toHtml
