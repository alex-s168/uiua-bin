B ~ "lib.ua" ~ Arr‼ CStr₈ F‼ Magic! Map‼ M‼ NArr‼ PadB‼ Ube₃₂ Ube₈ Ule₁₆ Ule₃₂ Z!

Test‼ ← ⍤""≍◌^0⍤""≍^1.°^0[].

|QoiHeader {Width Height Channels Colorspace}
QoiHeaderBin ← M‼Z!QoiHeader(
  Magic!(-@\0"qoif")
  F‼Ube₃₂ QoiHeader~Width
  F‼Ube₃₂ QoiHeader~Height
  F‼Ube₈ QoiHeader~Channels
  F‼Ube₈ QoiHeader~Colorspace
)
QoiHeader 123 321 1 2
Test‼QoiHeaderBin[113 111 105 102 123 0 0 0 65 1 0 0 1 2]

|Arr {Len Data}
ArrBin ← M‼Z!Arr(
  F‼Ule₁₆ Arr~Len
  F‼RefArr‼Arr~Len Ule₁₆ Arr~Data
)
Arr 3 [1 2 3]
Test‼ArrBin[0 3 0 1 0 2 0 3]

[1 2 3]
Test‼Arr‼Ule₃₂ Ule₁₆[0 0 0 3 0 1 0 2 0 3]

[1 2 3]
Test‼NArr‼3 Ule₁₆ [0 1 0 2 0 3]

[1 2 3]
Test‼PadB‼12 Arr‼Ule₃₂ Ule₁₆[0 0 0 3 0 1 0 2 0 3 0 0]

"Hello"
Test‼CStr₈ [72 101 108 108 111 0]

10
Test‼Map‼(-1)Ule₁₆ [0 11]

{"Hello" "World"}
Test‼Arr‼Ule₁₆ Map‼□ CStr₈ [0 2 72 101 108 108 111 0 87 111 114 108 100 0]

10
Test‼B~Ile₁₆ [0 10]

¯10
Test‼B~Ile₁₆ [255 246]

10
Test‼B~Ibe₁₆ [10 0]

¯10
Test‼B~Ibe₁₆ [246 255]

B~FloatLe!B~FTy₁₆[53 85]
⍤""=∩(⁅×1000000000000) 0.333251953125

B~FloatLe!B~FTy₁₆[0 1]
⍤""=∩(⁅×1000000000000) 0.000000059604645

B~FloatLe!B~FTy₁₆[3 255]
⍤""=∩(⁅×1000000000000) 0.000060975552

B~FloatLe!B~FTy₁₆[4 0]
⍤""=∩(⁅×1000000000000) 0.00006103515625

B~FloatLe!B~FTy₁₆[59 255]
⍤""=∩(⁅×10000000) 0.99951172

B~FloatLe!B~FTy₁₆[60 0]
⍤""=1

B~FloatLe!B~FTy₁₆[60 1]
⍤""=∩(⁅×10000000)1.00097656

B~FloatLe!B~FTy₁₆[123 255]
⍤""=65504

B~FloatLe!B~FTy₁₆[124 0]
⍤""=∞

B~FloatLe!B~FTy₁₆[128 0]
⍤""=¯0

B~FloatLe!B~FTy₁₆[252 0]
⍤""=¯∞

⧈(°⋯⇌)¤¤8 -@0"11000000100100111101011100001010"
B~FloatLe!B~FTy₃₂
⍤""=∩(⁅×10000000000000) ¯4.619999885559082

{B~Var‼B~Ule₈B~C~InvTry!(
    B~VarEnt‼0 Ule₁₆
  | B~VarEnt‼1 Ube₁₆
  | B~VarFail
  )[0 0 2]}
⍤""≍{[] 0 2}

{B~Var‼B~Ule₈B~C~InvTry!(
    B~VarEnt‼0 Ule₁₆
  | B~VarEnt‼1 Ube₁₆
  | B~VarFail
  )[1 0 2]}
⍤""≍{[] 1 512}

[] 1 512
°B~Var‼B~Ule₈C~InvTry!(
  B~VarEnt‼0 Ule₁₆
| B~VarEnt‼1 Ube₁₆
| B~VarFail
)
⍤""≍[1 0 2]

[1 0 2]
◌B~V!(
  Ule₈
| 0 => Ule₁₆
| . => Ube₁₆
)
⍤""≍512

512
°B~V!(
  Ule₈
| 0 => Ule₁₆
| . => Ube₁₆
)[]
⍤""≍[0 2 0]
