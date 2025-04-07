UleEnc₆₄ ↚ comptime(⇌≡ⁿ×8⇡8 2)

IncBin ↚ ⍥¬⊂1\↧⟜⊂⊙0

# macro arg is **bit** size
Neg₂! ← ⧈°⋯¤¤8 ⬚0↙^0 IncBin ¬ ⬚0↙^0⋯

ByteIsNeg ↚ ⬚0⊡7⋯
Conv ↚ ⌅(
  /+×⇌↙:⇌UleEnc₆₄⧻.
| ⧈°⋯¤¤8 ⬚0↙64⋯)

# macro arg is **bit** size
ConvNeg! ↚ ⌅(
  ⨬(Conv
  | ¯+1/+×⇌↙:⇌UleEnc₆₄⧻.≡(°⋯¬⬚0↙8⋯)
  )ByteIsNeg⊢.
| ⇌⨬(↙÷8^0°Conv)(Neg₂!^0⌵)<0.
)

UleConv! ↚ ⌅(
  ⊃(↘^0|Conv↙^0)
| ⊂⇌↙^0°Conv:)

Ule₈  ← UleConv!1
Ule₁₆ ← UleConv!2
Ule₃₂ ← UleConv!4
Ule₆₄ ← UleConv!8

IleConv! ↚ ⌅(
  ⊃(↘^0|ConvNeg!(×8^0)↙^0)
| ⊂°ConvNeg!(×8^0):)

Ile₈  ← IleConv!1
Ile₁₆ ← IleConv!2
Ile₃₂ ← IleConv!4
Ile₆₄ ← IleConv!8

BeConv‼ ↚ ⌅(^1⍜(↙^0)⇌|⊂:⊙(⇌°^1[]))

Ube₈  ← BeConv‼1Ule₈
Ube₁₆ ← BeConv‼2Ule₁₆
Ube₃₂ ← BeConv‼4Ule₃₂
Ube₆₄ ← BeConv‼8Ule₆₄

Ibe₈  ← BeConv‼1Ile₈
Ibe₁₆ ← BeConv‼2Ile₁₆
Ibe₃₂ ← BeConv‼4Ile₃₂
Ibe₆₄ ← BeConv‼8Ile₆₄

# null terminated byte array
NullTerm ← ⌅(
  ⊃(↘+1)↙ ⊢⊚=0.
| ⊂⊂:0:)

# null terminated utf8 string
CStr₈ ← ⊙°utf₈ NullTerm

# n padding bytes
PaddingB! ← ⌅(↘^0|⊂↯^0 0)

# applies the converter,
# but pushes the amount of bytes
# it consumed / created onto the stack
# this can not be un-ed but you can use UnLen!
Len!   ← -:⊙⊸⧻⊙^0⧻.
UnLen! ← ¯Len!°^0

# pad output of parser ^1 to ^0 bytes with zeros
PadB‼ ← ⌅(
  ↘-:^0 Len!^1
| ⊂:⊂↯:0-:^0 :⊙(UnLen!^1[]))

F‼ ← ⌅(
  ⊙(⍜^1(∘◌):)^0
| °^0⊙⊸^1)

# fixed length bytes
Fixed! ← ⌅(
  ⊃(↘^0|↙^0)
| ⊂:)

# must match exactly bytes from ^0
# example:  B~Magic!(-@0"png")
Magic! ← ⌅(
  ⍤"magic mismatch"≍^0 ⊃↙↘⧻^0
| ⊂^0)

# first arg: parser for array len prefix
# second arg: parser for array elem
Arr‼ ← ⌅(
  ⊙⇌⍥(⊙⊂^1):^0⊙[]
| ⊂⊙◌⊃(°^0[]⧻:)(⊂∧(⊂°^1[]):[]⇌:)
)

Args! ↚^ ⊂"⊢⊢"⋅repr
Z!    ← °[°^0] ↯⊙0 Args!^0

# struct parser <- ZeroInit FieldSerial
# example:
#   HeaderBin = M!!Z!Header( F!!Ube__32 Header~Abc )
M‼ ← ⌅(^1⊙^0|⊙◌°^1)

# modify value
# Parser <- MapFn Parser
Map‼ ← ⌅(⊙^0^1|°^1⊙°^0)

┌─╴tests
  Test‼ ← ⍤""≍◌^0⍤""≍^1.°^0[].

  |QoiHeader {Width Height Channels Colorspace}

  QoiHeaderBin ← M‼Z!QoiHeader(
    Magic!(-@0"qoif")
    F‼Ube₃₂ QoiHeader~Width
    F‼Ube₃₂ QoiHeader~Height
    F‼Ube₈ QoiHeader~Channels
    F‼Ube₈ QoiHeader~Colorspace
  )

  QoiHeader 123 321 1 2
  Test‼QoiHeaderBin[65 63 57 54 123 0 0 0 65 1 0 0 1 2]

  [1 2 3]
  Test‼Arr‼Ule₃₂ Ule₁₆[0 0 0 3 0 1 0 2 0 3]

  [1 2 3]
  Test‼PadB‼12 Arr‼Ule₃₂ Ule₁₆[0 0 0 3 0 1 0 2 0 3 0 0]

  "Hello"
  Test‼CStr₈ [72 101 108 108 111 0]

  10
  Test‼Map‼(-1)Ule₁₆ [0 11]

  {"Hello" "World"}
  Test‼Arr‼Ule₁₆ Map‼□ CStr₈ [0 2 72 101 108 108 111 0 87 111 114 108 100 0]

  10
  Test‼Ile₁₆ [0 10]

  ¯10
  Test‼Ile₁₆ [255 246]

  10
  Test‼Ibe₁₆ [10 0]

  ¯10
  Test‼Ibe₁₆ [246 255]
└─╴
