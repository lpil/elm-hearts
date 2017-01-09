module Heart.Stream exposing (new, safeNext)

import Heart exposing (Heart)
import Lazy.List exposing (LazyList)
import Color exposing (Color)
import Theme


new : List Color -> LazyList Heart
new colors =
    colors
        |> Lazy.List.fromList
        |> Lazy.List.cycle
        |> Lazy.List.map Heart.new


safeNext : LazyList Heart -> ( Heart, LazyList Heart )
safeNext stream =
    case Lazy.List.headAndTail stream of
        Just headAndTail ->
            headAndTail

        Nothing ->
            Theme.pastelPurpleDawn |> new |> safeNext
