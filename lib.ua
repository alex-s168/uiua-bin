UleEnc₆₄ ↚ comptime(⇌≡ⁿ×8⇡8 2)

IncBin ↚ ⍥¬⊂1\↧⟜⊂⊙0

# macro arg is **bit** size
Neg₂! ← ⇌⧈°⋯¤¤8 ⬚0↙^0 IncBin ¬ ⬚0↙^0⋯

ByteIsNeg ↚ ⬚0⊡7⋯
Conv ↚ ⌅(
  /+×⇌↙:⇌UleEnc₆₄⧻.
| ⧈°⋯¤¤8 ⬚0↙64⋯)

# macro arg is **bit** size
ConvNeg! ↚ ⌅(
  ⨬(Conv
  | ¯+1/+×⇌↙:⇌UleEnc₆₄⧻.≡(°⋯¬⬚0↙8⋯)
  )ByteIsNeg⊢.
| ⨬(↙÷8^0°Conv)(B~Neg₂!^0⌵)<0.
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
| ⊂⇌°ConvNeg!(×8^0):)

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
PadEndB‼ ← ⌅(
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
