B ~ "lib.ua" ~ Arr‼ CStr₈ F‼ Just! M! Map‼ NArr‼ PadR‼ Ube₃₂ Ule₁₆ Ule₃₂ U₈

C ~ "git: github.com/alex-s168/cursed-ua"

AssertMatch! ← ⍤$"Error: _\nExpected: _\nGot: _"^0 ⊃(∩pretty|≍)

# ? Parser Bytes Value
Test‼ ← ⊃(
  AssertMatch!"encode" ⊂^1[1 1 0 1] °^0 [1 1 0 1]
| ^0 ⊂^1[1 1 0 1]
  AssertMatch!"decode: remaining bytes" [1 1 0 1]
  AssertMatch!"decode: value"
)

# ? Parser Bytes Value
TestRem‼ ← ⊃(
  AssertMatch!"encode" ^1 °^0 []
| ^0 ^1
  AssertMatch!"decode: remaining bytes" []
  AssertMatch!"decode: value"
)

[113 111 105 102]
Test‼Just!(-@\0"qoif") [113 111 105 102]

°[] B~Compose!(Just![5]) [5]
°[5] °B~Compose!(Just![5]) []

10
Test‼U₈ [10]

10
Test‼B~Ile₁₆ [10 0]

10
Test‼B~Ile₃₂ [10 0 0 0]

10
Test‼B~Ule₃₂ [10 0 0 0]

10
Test‼B~Ibe₁₆ [0 10]

10
Test‼B~Ibe₃₂ [0 0 0 10]

10
Test‼B~Ube₃₂ [0 0 0 10]

¯10
Test‼B~Ile₁₆ [246 255]

¯10
Test‼B~Ibe₁₆ [255 246]

|QoiHeader {Width Height Channels Colorspace}
QoiHeaderBin ← M!(
  C~Z!QoiHeader
| Just!(-@\0"qoif")
| F‼Ube₃₂ QoiHeader~Width
| F‼Ube₃₂ QoiHeader~Height
| F‼U₈ QoiHeader~Channels
| F‼U₈ QoiHeader~Colorspace
)
QoiHeader 123 321 1 2
Test‼QoiHeaderBin[113 111 105 102 0 0 0 123 0 0 1 65 1 2]

QoiHeaderBin ← M!(
  C~Z!QoiHeader
| Just!(-@\0"qoif")
| QoiHeader~Width = Ube₃₂
| QoiHeader~Height = Ube₃₂
| QoiHeader~Channels = U₈
| QoiHeader~Colorspace = U₈
)
QoiHeader 123 321 1 2
Test‼QoiHeaderBin[113 111 105 102 0 0 0 123 0 0 1 65 1 2]

QoiHeaderBin ← B~MS!(
  QoiHeader
| Just!(-@\0"qoif")
| Width ← Ube₃₂
| Height ← Ube₃₂
| Channels ← U₈
| Colorspace ← U₈
)
QoiHeader 123 321 1 2
Test‼QoiHeaderBin[113 111 105 102 0 0 0 123 0 0 1 65 1 2]

|Arr {Len Data}
ArrBin ← M!(
  C~Z!Arr
| F‼Ube₁₆ Arr~Len
| F‼Arr‼B~Ref!Arr~Len Ube₁₆ Arr~Data
)
Arr 3 [1 2 3]
Test‼ArrBin[0 3 0 1 0 2 0 3]

[1 2 3]
Test‼Arr‼Ube₃₂ Ube₁₆[0 0 0 3 0 1 0 2 0 3]

[1 2 3]
Test‼NArr‼3 Ube₁₆ [0 1 0 2 0 3]

[1 2 3]
Test‼PadR‼12 Arr‼Ube₃₂ Ube₁₆[0 0 0 3 0 1 0 2 0 3 0 0]

"Hello"
Test‼CStr₈ [72 101 108 108 111 0]

10
Test‼Map‼(-1)Ube₁₆ [0 11]

{"Hello" "World"}
Test‼Arr‼Ube₁₆ Map‼□ CStr₈ [0 2 72 101 108 108 111 0 87 111 114 108 100 0]

{B~Var‼U₈B~C~InvTry!(
    B~VarEnt‼0 Ube₁₆
  | B~VarEnt‼1 Ule₁₆
  | B~VarFail
  )[0 0 2]}
⍤""≍{[] 0 2}

{B~Var‼U₈B~C~InvTry!(
    B~VarEnt‼0 Ube₁₆
  | B~VarEnt‼1 Ule₁₆
  | B~VarFail
  )[1 0 2]}
⍤""≍{[] 1 512}

[] 1 512
°B~Var‼U₈C~InvTry!(
  B~VarEnt‼0 Ube₁₆
| B~VarEnt‼1 Ule₁₆
| B~VarFail
)
⍤""≍[1 0 2]

[1 0 2]
◌B~V!(
  U₈
| 0 => Ube₁₆
| . => Ule₁₆
)
⍤""≍512

512
°B~V!(
  U₈
| 0 => Ube₁₆
| . => Ule₁₆
)[]
⍤""≍[0 2 0]

[69 0]
[1 0]
B~V!(
  B~Ref!⊡₁
| 0 => Ube₁₆
| . => Ule₁₆
)
°256 °[]
°[69 0]

[69 0]
256
[]
°B~V!(
  B~Ref!⊡₁
| 1 => Ube₁₆
| 2 => Ule₁₆
)
°[1 0]
°[69 1]

[1 5]
Test‼(
  B~M!(
    [0 0]
  | B~F‼B~Ule₁₆ ⊡₀
  | Just![69]
  | B~F‼B~V!(
      B~Ref!⊡₀
    | 1 => Ube₁₆
    | 2 => Ule₁₆
    ) ⊡₁
  )
| [1 0 69 0 5])

[5]
Test‼B~SimpleN‼1∘ [5]

[5]
TestRem‼B~SimpleAll!∘ [5]

[1 2 3]
TestRem‼B~UntilEnd!Ube₁₆ [0 1 0 2 0 3]

[1 2 3]
Test‼B~Sub‼6 B~UntilEnd!Ube₁₆ [0 1 0 2 0 3]

5
Test‼B~Bit~Ube!4 [0 1 0 1]

5819
Test‼B~Bit~Ube!14 [0 1 0 1 1 0 1 0 1 1 1 0 1 1]

5799
Test‼B~Bits!B~Bit~Ube!16 [22 167]
