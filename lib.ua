UleEnc₆₄ ↚ comptime(⇌≡ⁿ×8⇡8 2)

IncBin ↚ ⍥¬⊂1\↧⟜⊂⊙0

# macro arg is **bit** size
Neg₂! ↚ ⧈°⋯¤¤8 ⬚0↙^0 IncBin ¬ ⬚0↙^0⋯

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

# insert ^0 bytes that can be any value / padding bytes
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

# assign the value of parser ^0 to struct field ^1
#
# you can use this in M!!
F‼ ← ⌅(
  ⊙(⍜^1(∘◌):)^0
| °^0⊙⊸^1)

# must match exactly bytes from ^0
# example:  B~Magic!(-@\0"png")
Magic! ← ⌅(
  ⍤"magic mismatch"≍^0 ⊃↙↘⧻^0
| ⊂^0)

# parse length prefixed array.
#
# first macro arg:  parser for array len prefix
# second macro arg: parser for array elem
#
# you might want to box the value of the inner parser using Map!!
Arr‼ ← ⌅(
  ⊙⇌⍥(⊙⊂^1):^0⊙[]
| ⊂⊙◌⊃(°^0[]⧻:)(⊂∧(⊂°^1[]):[]⇌:)
)

# parse array where length comes from somewhere else
#
# first macro arg:  field getter inside M!! to use as len
# second macro arg: parser for array elem
#
# can be used in F!! like this:
#   F!! RefArr!!MyStruct~Len Ule__8 MyStruct~Data
#
# you might want to box the value of the inner parser using Map!!
RefArr‼ ← ⌅(
  :⍥(:⊙⊂⊙:^1:)⊙[]:⊙⊸^0
| ⊂∧(⊂°^1[]):[]⇌:⊙(⊙(⍜^0◌:⧻).)
)

Args! ↚^ ⊂"⊢⊢"⋅repr

# zero-initialize struct
Z! ← °[°^0] ↯⊙0 Args!^0

# struct parser <- ZeroInit FieldSerial
# example:
#   HeaderBin = M!!Z!Header( F!!Ube__32 Header~Abc )
M‼ ← ⌅(^1⊙^0|⊙◌°^1)

# modify value after parser
# Parser <- MapFn Parser
Map‼ ← ⌅(⊙^0^1|°^1⊙°^0)

# input amount of bytes has to be equal to how many bits consumed (to bytes)
#
# can also be un-ed
#
# example:
#   SelectByteBits![3 3 2] [231]
#   ## {[1 1 1] [0 0 1] [1 1]}
SelectByteBits! ← ⌅(
  ⇌/⊂≡(⬚0↙8⋯)
  ⊕□▽°˜⊏^0
| ⧈°⋯¤¤8/◇⊂
)

|FloatType {ExpNBits ExpBias MantNBits}
FTy₁₆    ← FloatType 5 15 10
FTy₃₂    ← FloatType 8 127 23
FTy₆₄    ← FloatType 11 1023 52
BFTy₁₆   ← FloatType 8 127 7
AMDFTy₂₄ ← FloatType 7 63 16

FloatLe! ← (
  ⇌
  SelectByteBits![1 FloatType~ExpNBits^0 FloatType~MantNBits^0]
  ⊃(×⊸⊃(/×°□⊡1|/×≠0°□⊡2)
    ⨬(×⊸⊃(/×°□⊡1|/×=0°□⊡2)
      ⨬(⊃(=0. °⋯⇌°□⊡1
          ⨬(1 ⁿ:2-FloatType~ExpBias^0
          | 0 ⁿ:2 ¯-1 FloatType~ExpBias^0 ◌ # subnormal bulshit
          )
        | ÷ⁿ:2FloatType~MantNBits^0 °⋯⇌ °□⊡2
        )
        ⊙⨬∘(+1): # inc mant if not subnormal
        ×        # mant * factor
      | ∞◌
      )
    | NaN◌)
  | ⨬(1|¯1)⊢°□⊡0)
  × # sign
)

FConv‼ ← ⊃(↘^0|FloatLe!^1↙^0)

FLe₁₆ ← FConv‼2 FTy₁₆
FLe₃₂ ← FConv‼4 FTy₃₂
FLe₆₄ ← FConv‼8 FTy₆₄
# AMD's 24 bit float format
AMDFLe₂₄ ← FConv‼3 AMDFTy₂₄
# BrainFloat 16
BFLe₁₆ ← FConv‼2 BFTy₁₆

FBe₁₆ ← BeConv‼2 FLe₁₆
FBe₃₂ ← BeConv‼4 FLe₃₂
FBe₆₄ ← BeConv‼8 FLe₆₄
# AMD's 24 bit float format
AMDFBe₂₄ ← BeConv‼3 AMDFLe₂₄
# BrainFloat 16
BFBe₁₆ ← BeConv‼2 BFLe₁₆

┌─╴tests
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

  FloatLe!FTy₁₆ [53 85]
  ⍤""=∩(⁅×1000000000000) 0.333251953125

  FloatLe!FTy₁₆[0 1]
  ⍤""=∩(⁅×1000000000000) 0.000000059604645

  FloatLe!FTy₁₆[3 255]
  ⍤""=∩(⁅×1000000000000) 0.000060975552

  FloatLe!FTy₁₆[4 0]
  ⍤""=∩(⁅×1000000000000) 0.00006103515625

  FloatLe!FTy₁₆[59 255]
  ⍤""=∩(⁅×10000000) 0.99951172

  FloatLe!FTy₁₆[60 0]
  ⍤""=1

  FloatLe!FTy₁₆[60 1]
  ⍤""=∩(⁅×10000000)1.00097656

  FloatLe!FTy₁₆[123 255]
  ⍤""=65504

  FloatLe!FTy₁₆[124 0]
  ⍤""=∞

  FloatLe!FTy₁₆[128 0]
  ⍤""=¯0

  FloatLe!FTy₁₆[252 0]
  ⍤""=¯∞

  ⧈(°⋯⇌)¤¤8 -@0"11000000100100111101011100001010"
  FloatLe!FTy₃₂
  ⍤""=∩(⁅×10000000000000) ¯4.619999885559082
└─╴
