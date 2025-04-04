UleEnc₆₄ ↚ comptime(⇌≡ⁿ×8⇡8 2)

# macro arg is **bit** size
Neg₂! ↚ ⧈°⋯¤¤8 ⬚0↙^0⋯+1°⋯¬ ⬚0↙^0⋯

ByteIsNeg ↚ ⬚0⊡7⋯
Conv ← ⌅(
  /+×⇌↙:⇌UleEnc₆₄⧻.
| ⧈°⋯¤¤8 ⬚0↙64⋯)
ConvNeg ← ⨬(
  Conv
| ¯+1/+×⇌↙:⇌UleEnc₆₄⧻.≡(°⋯¬⬚0↙8⋯)
)ByteIsNeg⊢.

Ule₈ ← ⌅(⊃(↘1)⊢|⊂:)
Ule₁₆ ← ⌅(
  ⊃(↘2|Conv↙2)
| ⊂⊂⊃(⌊÷256|◿256):
)
Ule₃₂ ← ⌅(
  ⊃(↘4|Conv↙4)
| ⊂⊂⊃(°Ule₁₆[]⌊÷65536|°Ule₁₆[]◿65536):
)
Ule₆₄ ← ⌅(
  ⊃(↘8|Conv↙8)
| ⊂⊂⊃(°Ule₃₂[]⌊÷4294967296|°Ule₃₂[]◿4294967296):
)

Ube₈  ← Ule₈
Ube₁₆ ← ⌅(Ule₁₆ ⍜(↙2)⇌|⊂:⊙(⇌°Ule₁₆[]))
Ube₃₂ ← ⌅(Ule₃₂ ⍜(↙4)⇌|⊂:⊙(⇌°Ule₃₂[]))
Ube₆₄ ← ⌅(Ule₆₄ ⍜(↙8)⇌|⊂:⊙(⇌°Ule₆₄[]))

NullTerm ← ⌅(
  ⊃(↘+1)↙ ⊢⊚=0.
| ⊂⊂:0:)

CStr₈ ← ⊙°utf₈ NullTerm

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
