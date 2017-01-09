module Theme exposing (..)

import Color exposing (Color)
import Random exposing (Generator)


allThemes : List (List Color)
allThemes =
    [ pastelRainbow
    , pastelRainbowPeach
    , pastelPurpleDawn
    , lightRainbow
    ]


randomTheme : Generator (List Color)
randomTheme =
    Random.int 0 (List.length allThemes - 1)
        |> Random.map
            (\i ->
                List.drop i allThemes
                    |> List.head
                    |> Maybe.withDefault []
            )


{-| http://www.color-hex.com/color-palette/2922, mirrored
-}
pastelRainbow : List Color
pastelRainbow =
    [ Color.rgb 168 230 207
    , Color.rgb 220 237 193
    , Color.rgb 255 211 182
    , Color.rgb 255 170 165
    , Color.rgb 255 139 148
    , Color.rgb 255 170 165
    , Color.rgb 255 211 182
    , Color.rgb 220 237 193
    ]


{-| http://www.color-hex.com/color-palette/2922 with 2 colors dropped.
-}
pastelRainbowPeach : List Color
pastelRainbowPeach =
    [ Color.rgb 255 211 182
    , Color.rgb 255 170 165
    , Color.rgb 255 139 148
    ]


{-| http://www.color-hex.com/color-palette/2922, mirrored
-}
pastelPurpleDawn : List Color
pastelPurpleDawn =
    [ Color.rgb 252 196 255
    , Color.rgb 239 181 255
    , Color.rgb 227 177 255
    , Color.rgb 217 164 255
    , Color.rgb 210 145 255
    , Color.rgb 217 164 255
    , Color.rgb 227 177 255
    , Color.rgb 239 181 255
    ]


{-| http://www.color-hex.com/color-palette/12435
-}
lightRainbow : List Color
lightRainbow =
    [ Color.rgb 255 243 170
    , Color.rgb 255 208 168
    , Color.rgb 255 177 177
    , Color.rgb 217 209 255
    , Color.rgb 183 239 255
    ]
