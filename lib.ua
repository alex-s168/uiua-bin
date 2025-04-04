Ule₈     ← ⌅(⊃(↘1)⊢|⊂:)
UleEnc₁₆ ↚ [256 1]
Ule₁₆ ← ⌅(
  ⊃(↘2|/+×UleEnc₁₆↙2)
| ⊂⊂⊃(⌊÷256|◿256):
)
UleEnc₃₂ ↚ [16777216 65536 256 1]
Ule₃₂ ← ⌅(
  ⊃(↘4|/+×UleEnc₃₂↙4)
| ⊂⊂⊃(°Ule₁₆[]⌊÷65536|°Ule₁₆[]◿65536):
)
UleEnc₆₄ ↚ comptime(⊂×4294967296 UleEnc₃₂UleEnc₃₂)
Ule₆₄ ← ⌅(
  ⊃(↘8|/+×UleEnc₆₄↙8)
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
