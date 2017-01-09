module Heart.Stream exposing (new, safeNext)

import Heart exposing (Heart)
import Lazy.List exposing (LazyList)
import Color exposing (Color)
import Themes


colorStream : LazyList Color
colorStream =
    Themes.pastelPurpleDawn
        |> Lazy.List.fromList
        |> Lazy.List.cycle


new : LazyList Heart
new =
    Lazy.List.map Heart.new colorStream


safeNext : LazyList Heart -> ( Heart, LazyList Heart )
safeNext stream =
    case Lazy.List.headAndTail stream of
        Just headAndTail ->
            headAndTail

        Nothing ->
            safeNext new
