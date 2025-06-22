# !doc
# Extensive binary (de-) serialization framework
#
# ## Overview
# Normal parsers have a signature of:
# `RemainingBytes Value ? Bytes`
#
# There are also "stateful" parsers, that have a signatue of:
# `RemainingBytes Value State ? Bytes State`
#
# All parsers should have a un-inverse.
#
# All parsers that contain inner parsers should accept stateful parsers.
#
# ## Getting started:
# ```uiua
# B ~ "git: github.com/alex-s168/uiua-bin"
#
# ~QoiHeader[Width Height Channels Colorspace]
#
# QoiHeaderBin ← B~MS‼(
#   QoiHeader
# | B~Just!(-@0"qoif")
# | Width = B~Ube₃₂
# | Height = B~Ube₃₂
# | Channels = B~Ube₈
# | Colorspace = B~Ube₈
# )
#
# QoiHeader 123 321 1 2
# °QoiHeaderBin[]
# # [113 111 105 102 0 0 0 123 0 0 1 65 1 2]
#
# # pop is used to remove remaining bytes of parser
# ◌QoiHeaderBin
# ```
#
# ## `NoInv!`
# When writing serializers for variants, and som variant cases only support de-serialization,
# you might want to use `NoInv! F` to get a runtime error when the inverse is called, instead of a compile time error.
#
# ## modifying binary data
# Uiua provides the "under" modifier, which can be used for this:
# ```uiua
# [113 111 105 102 123 0 0 0 65 1 0 0 1 2]
# # reduce "Width" in "QoiHeader" by 10
# ⍜(QoiHeader~Width◌QoiHeaderBin)(-10)
# ## [113 111 105 102 113 0 0 0 65 1 0 0 1 2]
# ```

C ≁ "git: github.com/alex-s168/cursed-ua"

UleEnc₆₄ ↚ comptime(⇌≡ⁿ×8⇡8 2)

IncBin ↚ ⍥¬⊂1\↧⟜⊂⊙0

# macro arg is **bit** size
Neg₂! ↚ ⧈°⋯¤¤8 ⬚0↙^0 IncBin ¬ ⬚0↙^0⋯

ByteIsNeg ↚ ⬚0⊡7⋯
ConvLe ↚ ⌅(
  /+×⇌↙:⇌UleEnc₆₄⧻. ⇌
| ⧈°⋯¤¤8 ⬚0↙64⋯)

⍤"" ≍[10 0 0 0 0 0 0 0] °ConvLe 10
⍤"" ≍10 ConvLe[10 0 0 0 0 0 0 0]

# macro arg is **bit** size
ConvNegLe! ↚ ⌅(
  ⨬(ConvLe
  | ¯+1/+×⇌↙:⇌UleEnc₆₄⧻.≡(°⋯¬⬚0↙8⋯) ⇌
  )ByteIsNeg⊢.
| ⨬(↙÷8^0°ConvLe)(Neg₂!^0⌵)<0.
)

⍤"" ≍[10 0 0 0 0 0 0 0] °ConvNegLe!(64) 10
⍤"" ≍10 ConvNegLe!(64)[10 0 0 0 0 0 0 0]

UleConv! ↚ ⌅(
  ⊃(↘^0|ConvLe ↙^0)
| ⊂↙^0 °ConvLe :)

# Deprecated!
#
# This function is deprecated and will be removed in the future.
#
# **Use** `U,8` **instead!**
Ule₈  ← UleConv!1
Ule₁₆ ← UleConv!2
Ule₂₄ ← UleConv!3
Ule₃₂ ← UleConv!4
Ule₄₀ ← UleConv!5
Ule₄₈ ← UleConv!6
Ule₅₆ ← UleConv!7
Ule₆₄ ← UleConv!8

IleConv! ↚ ⌅(
  ⊃(↘^0|ConvNegLe!(×8^0)↙^0)
| ⊂°ConvNegLe!(×8^0):)

# Deprecated!
#
# This function is deprecated and will be removed in the future.
#
# **Use** `I,8` **instead!**
Ile₈  ← IleConv!1
Ile₁₆ ← IleConv!2
Ile₂₄ ← IleConv!3
Ile₃₂ ← IleConv!4
Ile₄₀ ← IleConv!5
Ile₄₈ ← IleConv!6
Ile₅₆ ← IleConv!7
Ile₆₄ ← IleConv!8

BeConv‼ ↚ ⌅(^1⍜(↙^0)⇌|⊂:⊙(⇌°^1[]))

# Deprecated!
#
# This function is deprecated and will be removed in the future.
#
# **Use** `U,8` **instead!**
Ube₈  ← UleConv!1
Ube₁₆ ← BeConv‼2Ule₁₆
Ube₂₄ ← BeConv‼3Ule₂₄
Ube₃₂ ← BeConv‼4Ule₃₂
Ube₄₀ ← BeConv‼5Ule₄₀
Ube₄₈ ← BeConv‼6Ule₄₈
Ube₅₆ ← BeConv‼7Ule₅₆
Ube₆₄ ← BeConv‼8Ule₆₄

# Deprecated!
#
# This function is deprecated and will be removed in the future.
#
# **Use** `I,8` **instead!**
Ibe₈  ← IleConv!1
Ibe₁₆ ← BeConv‼2Ile₁₆
Ibe₂₄ ← BeConv‼3Ile₂₄
Ibe₃₂ ← BeConv‼4Ile₃₂
Ibe₄₀ ← BeConv‼5Ile₄₀
Ibe₄₈ ← BeConv‼6Ile₄₈
Ibe₅₆ ← BeConv‼7Ile₅₆
Ibe₆₄ ← BeConv‼8Ile₆₄

U₈ ← °˜⊂
I₈ ← IleConv!1

# null terminated byte array
NullTerm ← ⌅(
  ⊃(↘+1)↙ ⊢⊚=0.
| ⊂⊂:0:)

# null terminated utf8 string
CStr₈ ← ⊙°utf₈ NullTerm

# insert `^0` bytes that can be any value / padding bytes
PaddingB! ← ⌅(↘^0|⊂↯^0 0)

# applies the parser,
# but pushes the amount of bytes
# it consumed / created onto the stack.
#
# this can not be un-ed, but you can use `UnLen!`
Len!   ← -:⊙⊸⧻⊙^0⧻.
UnLen! ← ¯Len!°^0

# pad output of parser `^1` to `^0` bytes with trailing zeros
PadB‼ ← ⌅(
  ↘-:^0 Len!^1
| ⊂:⊂↯:0-:^0 :⊙(UnLen!^1[]))

# assign the value of parser `^0` to struct field `^1`
#
# you can use this in `M!!`
F‼ ← ⌅(
  ⊙(⍜^1(∘◌):)^0
| °^0⊙⊸^1)

# a parser that encodes / matches and returns ^0
#
# example:
# ```uiua
# Just!(-@\0"png")
# ```
Just! ← ⌅(
  ⊙^0⍤"magic mismatch"≍^0 ⊃↙↘⧻^0
| ⊂^0 ⊙◌)

# parse length-prefixed array.
#
# macro arguments:
# 1. parser for array len prefix
# 2. parser for array elem
#
# if the array length is not a prefix, consider using this in combination with `Ref!`
#
# you might want to box the value of the inner parser using `Map!!`
Arr‼ ← ⌅(
  ⊙[]:^0
  # Len Arr RemBytes ...

  ⍥(
    # Arr RemBytes ...
    ⊙: ⊙^1
    # Arr Elt RemBytes ...
    ⊂
  )
  :
| :
  # Arr Bytes ...
  ⟜∧(°^1:)⇌
  # Arr Bytes ...
  °^0:⧻
)

# parses an array of a fixed length
#
# macro arguments:
# 1. array length (constant)
# 2. parser for array elem
#
# example:
# ```uiua
# F!! NArr!!4 Ule,8
# ```
NArr‼ ← ⌅(
  ⍥(⊙˜⊂^1)^0 ⊙[]
| ⊙◌ ⍥(°^1 ⊙⊃(⊣|↘¯ 1))^0
)

# applies the given parser (to generate an array) until no more bytes are left
UntilEnd! ← ⌅(
  []
  # Arr Bytes ...
  ⍢(⊙^0
    # Arr RemBytes Val ...
    ⊂⊙:
  | >0⋅⧻
  )
  :
| :
  # Arr Bytes ...
  ∧(°^0:)⇌
)

Args! ↚^ ⊂"⊢⊢"⋅repr

# zero-initialize struct `^0`
Z! ← °[°^0] ↯⊙0 Args!^0

# Helper to create a compound data parser.
#
# YOU PROBABLY DON'T WANT TO USE THIS DIRECTLY.
# USE `M!` INSTEAD
#
# Example:
# ```uiua
# HeaderBin = MCtx!!Z!Header(
#   F!!Ube,32 Header~Abc
# )
# ```
#
# This can also be used to parse tuples:
# ```uiua
# Test = MCtx!![0 0](
#   F!!Ube,32 pick,0
#   F!!Ube,32 pick,1
# )
# ```
#
# StructParser ? ZeroInit FieldSerial
MCtx‼ ← ⌅(^1⊙^0|⊙◌°^1)

ComposeGen ↚ |2 (
  /⍚$"_\n_"≡(□⨬(∘|$"obv(dippop (_)|un(_)dip[])".) =+1°⊟:°□)
)

# you probably don't need to use this directly
Compose! ←^ ComposeGen

# TODO: move to cursed.ua
SplitWithIndentNew‼! ↚ (
  ⊜□¬×⊃(=0C~Indent‼^0^1|≡(/+=^2)|∘)
)

# boxCode NewSignature ? ctx boxCode Signature
GenF ↚ (
  ⊙(°□
    SplitWithIndentNew‼!@(@)"=←")
  □⨬(
    ⊙∘⊢ ◌
  | $"F!!((_)|(_(_)))":⊙(:°[⊙⊙] ⊙(+1⍜⊡₁(-1)))
  )-1◡⋅⧻
)

# Helper to create a compound data parser.
#
# Please read to the end.
#
# Example:
# ```uiua
# HeaderBin = M!(Z!Header
# | F!!Ube,32 Header~Abc
# )
# ```
#
# This can also be used to parse tuples:
# ```uiua
# Test = M!([0 0]
# | F!!Ube,32 pick,0
# | F!!Ube,32 pick,1
# )
# ```
#
# There is also comptime syntax so you don't have to type `F!!`:
# ```uiua
# |QoiHeader {Width Height Channels Colorspace}
#
# QoiHeaderBin ← M!(
#   Z!QoiHeader
# | Just!(-@\0"qoif")
# | QoiHeader~Width = Ube₃₂
# | QoiHeader~Height = Ube₃₂
# | QoiHeader~Channels = Ube₈
# | QoiHeader~Colorspace = Ube₈
# )
# ```
#
# Also consider using `MS!`, for even cleaner code.
M! ←^ $"MCtx!!((_)|(_))" ⊃(
  ⊢⊙◌
| ComposeGen≡(GenF"") ∩(↘1)
)

# Read the documentation for `M!` first.
#
# Example:
# ```uiua
# |QoiHeader {Width Height Channels Colorspace}
#
# QoiHeaderBin ← B~MS!(
#   QoiHeader
# | Just!(-@\0"qoif")
# | Width ← Ube₃₂
# | Height ← Ube₃₂
# | Channels ← Ube₈
# | Colorspace ← Ube₈
# )
# ```
MS! ←^ $"MCtx!!(Z!(_)|(_))" ⊃(
  ⊢⊙◌
| ComposeGen≡(GenF) ¤$"_!" ⊃(⊢⊙◌|∩(↘1))
)

# modify value after it is parsed.
# also works with un by modifying the value before it is encoded.
#
# Example:
# ```uiua
# Map!!box Arr!!Ule,16 U,8
# ```
#
# Parser ? MapFn Parser
Map‼ ← ⌅(⊙^0^1|°^1⊙°^0)

# input amount of bytes has to be equal to how many bits consumed (to bytes)
#
# can also be un-ed
#
# example:
# ```uiua
# SelectByteBits![3 3 2] [231]
# ## {[1 1 1] [0 0 1] [1 1]}
# ```
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
          | 0 ⁿ:2 ¯-1 FloatType~ExpBias^0 ◌ # subnormal bullshit
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

# defines a fake un- inverse (that errors when it is called) for the given function
#
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

# decode a prefixed variant type
#
# parsers of variants can have any amount of outputs
#
# example:
# ```uiua
# #if u8 is 0, decode LE u16, otherwise BE u16
# Var‼Ule₈C~InvTry!(
#   VarEnt‼0 Ule₁₆
# | VarEnt‼1 Ube₁₆
# | VarFail)
# ```
#
# generated parser signature:
# `RemBytes Variant Value ? Bytes`
#
# you might want to put this into `Multi!`
#
# YOU PROBABLY WANT TO USE``V!!` INSTEAD
Var‼    ← ⌅(: ^1 : ^0|°^0:°^1)
VarEnt‼ ← ⌅(^0 ^1 °^0|^0°^1°^0:)

VarFailImpl ↚ ⍤"variant match failure"0
VarFail     ← ⌅(VarFailImpl|VarFailImpl)

EmitV ↚ $"⌅(_|_)" ⊃($"(_):(_)"|$"°(_):°(_)":) C~EmitInvTry ⊂:≡⍚$"_ pop" C~ParseMatchArms!($"⌅(_|_)" ⊃($"(_)°(_)":)$"(_)°(_)")∘ ⊃(↘1|⊢)

# decode a prefixed variant
#
# example:
# ```uiua
# V!(
#   Ule₈
# | 0 => Ule₁₆
# | . => Ube₁₆
# )
# ```
#
# if the variant ID is not a prefix,
# consider using this in combination with `Ref!`
#
# the value of this parser depends on which variant is chosen
#
# It uses [cursed.ua](https://github.com/alex-s168/cursed-ua) for parsing the match arms
V! ←^ EmitV

# A parser that returns the value from the struct field,
# (or sets the value from the struct field in encode)
#
# Works only inside a `M!!` context
#
# this can be used together with other parsers, such as `Arr!!`, when the length is not a prefix:
# ```uiua
# ~Struct { CoolArr CoolArrLen }
#
# M!!Z!Struct(
#   F!! Ule,32 Struct~CoolArrLen
#   ...
#   F!! Arr!! Ref! Struct~CoolArrLen U,8 Struct~CoolArr
# )
# ```
Ref! ← ⌅(⊙⊸^0|⊙°⊸^0)

# parses nothing
None ← Just![]

# takes in a parser of signature `Value ? Bytes`,
# and parses the first N bytes with it
#
# Parser ? Num SimpleParser
SimpleN‼ ← ⌅(
  ⊃(↘^0|^1 ↙^0)
| ⊂:⊙(°^0⧻. ^1))

# takes in a parser of signature `Value ? Bytes`,
# and parsers all remaining bytes with it
SimpleAll! ← ⌅([]^0|⊂:⊙°^0)
