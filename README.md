# uiua-bin
Easy binary (de-) serialization in Uiua.

```
|User {Id Name Pass Rank Level}
UserBin ← (
  B~F‼ B~Ule₃₂ User~Id
  B~F‼ B~CStr₈ User~Name
  B~F‼ B~CStr₈ User~Pass
  B~F‼ B~Ule₁₆ User~Rank
  B~F‼ B~Ule₁₆ User~Level
)

# -- serialize --
User 123 "Max" "1234" 1 4
⊙◌°UserBin[]
# [0 0 0 123 77 97 120 0 49 50 51 52 0 0 1 0 4]

# -- deserialize --
◌UserBin⊙(User 0 0 0 0 0)
# User { Id: 123, Name: "Max", Pass: "123", Rank: 1, Level: 4 }
```
