module HeartSize exposing (list)


list : Int -> List Float
list max =
    heartSizesList 1.0 (toFloat max * 2) []


heartSizesList : Float -> Float -> List Float -> List Float
heartSizesList current max acc =
    if current < max then
        let
            next =
                5 + current * 1.4
        in
            heartSizesList next max (next :: acc)
    else
        acc
