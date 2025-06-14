C ~ "git: github.com/alex-s168/cursed-ua"

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
| ⊂⇌↙^0°Conv :)

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
# ˙ F!! RefArr!!MyStruct~Len Ule__8 MyStruct~Data
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
# ˙ HeaderBin = M!!Z!Header( F!!Ube__32 Header~Abc )
M‼ ← ⌅(^1⊙^0|⊙◌°^1)

# modify value after parser
# Parser <- MapFn Parser
Map‼ ← ⌅(⊙^0^1|°^1⊙°^0)

# input amount of bytes has to be equal to how many bits consumed (to bytes)
#
# can also be un-ed
#
# example:
# ˙ SelectByteBits![3 3 2] [231]
# ˙ ## {[1 1 1] [0 0 1] [1 1]}
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

# defines a fake un- inverse for the given function
# this can be used to get the no inverse found error at runtime instead of compile time
NoInv! ←^ $"obv(_|assert\"NoInv! inverse was called\"0 _)" ◇⊢: ⍥(⊂"0 "): ⍥(⊂"pop"):"" :°[⊙⊙] ⊢:

FConv‼ ← NoInv!⊃(↘^0|FloatLe!^1↙^0)

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

# decode a prefixed variant
# parsers of variants can have any amount of outputs
#
# example:
# ˙ #if u8 is 0, decode LE u16, otherwise BE u16
# ˙ Var‼Ule₈C~InvTry!(
# ˙   VarEnt‼0 Ule₁₆
# ˙ | VarEnt‼1 Ube₁₆
# ˙ | VarFail)
#
# generated parser signature:
# ˙ RemBytes Variant Value <= Bytes
#
# you might want to put this into Multi!
#
# YOU PROBABLY WANT TO USE V!! INSTEAD
#
Var‼    ← ⌅(: ^1 : ^0|°^0:°^1)
VarEnt‼ ← ⌅(^0 ^1 °^0|^0°^1°^0:)

VarFailImpl ↚ ⍤"variant match failure"0
VarFail     ← ⌅VarFailImpl VarFailImpl

EmitV ↚ $"⌅(_|_)" ⊃($"(_):(_)"|$"°(_):°(_)":) C~EmitInvTry ⊂:≡⍚$"_ pop" C~ParseMatchArms!($"⌅(_|_)" ⊃($"(_)°(_)":)$"(_)°(_)")∘ ⊃(↘1|⊢)

# decode a prefixed variant
#
# example:
# ˙ V!(
# ˙   Ule₈
# ˙ | 0 => Ule₁₆
# ˙ | . => Ube₁₆
# ˙ )
#
# the value of this parser depends on which variant is chosen
#
# It uses https://github.com/alex-s168/cursed-ua for parsing the match arms
V! ←^ EmitV

# Run a parser which generates multiple outputs, and binds those to a struct
#
# Example:
# ˙ Multi!(
# ˙   Var‼Ule₈InvTry!(
# ˙     VarEnt‼0 Ule₁₆
# ˙   | VarEnt‼1 Ube₁₆
# ˙   | VarFail)
# ˙ | TestTy~Variant | TestTy~Data)
# ˙
Multi! ←^ (
  ⊃(↘1)⊢ # => TOP BindAddrs Parser BOT

  ⊃( # bind
    $"dippop(_)"°□/⍚⊂ ≡⍚$"⊙⟜(⍜(_)◌:°□⊡(_))":⇡⧻.
    # apply parser
    $"(_) °□⊃⊢(↘1){_}"
  | # code for inverse
    °□/⍚$"_|_"
    $"⊙⊸⊃(_)"
    $"un(_) (_)":
  )

  $"obv((_)|(_))"
)
