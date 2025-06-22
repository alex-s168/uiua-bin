C ≁ "git: github.com/alex-s168/cursed-ua"

┌─╴FloatType
  ~ {ExpNBits ExpBias MantNBits}

  F₁₆    ← FloatType 5 15 10
  F₃₂    ← FloatType 8 127 23
  F₆₄    ← FloatType 11 1023 52
  BF₁₆   ← FloatType 8 127 7
  AMDF₂₄ ← FloatType 7 63 16
└─╴

FloatLe! ← (
  {C~SelectBits!(1|FloatType~ExpNBits ^0|FloatType~MantNBits ^0)}
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

⧈(°⋯⇌)¤¤8 -@0"11000000100100111101011100001010"
FloatLe!FloatType~F₃₂
⍤""=∩(⁅×10000000000000) ¯4.619999885559082

FloatLe!FloatType~F₁₆[53 85]
⍤""=∩(⁅×1000000000000) 0.333251953125

FloatLe!FloatType~F₁₆[0 1]
⍤""=∩(⁅×1000000000000) 0.000000059604645

FloatLe!FloatType~F₁₆[3 255]
⍤""=∩(⁅×1000000000000) 0.000060975552

FloatLe!FloatType~F₁₆[4 0]
⍤""=∩(⁅×1000000000000) 0.00006103515625

FloatLe!FloatType~F₁₆[59 255]
⍤""=∩(⁅×10000000) 0.99951172

FloatLe!FloatType~F₁₆[60 0]
⍤""=1

FloatLe!FloatType~F₁₆[60 1]
⍤""=∩(⁅×10000000)1.00097656

FloatLe!FloatType~F₁₆[123 255]
⍤""=65504

FloatLe!FloatType~F₁₆[124 0]
⍤""=∞

FloatLe!FloatType~F₁₆[128 0]
⍤""=¯0

FloatLe!FloatType~F₁₆[252 0]
⍤""=¯∞
