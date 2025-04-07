# uiua-bin
Easy binary (de-) serialization in Uiua.

All (de-)serializers have a signature of `RemainingBytes Value <- Bytes`, or for the inverse: `Bytes <- Bytes Value`

[Auto-generated docs](https://alex-s168.github.io/uiua-bin/)

Example:
```
B ~ "git: github.com/alex-s168/uiua-bin"

|QoiHeader {Width Height Channels Colorspace}

QoiHeaderBin ← B~M‼ B~Z!QoiHeader (
  B~Magic!(-@0"qoif")
  B~F‼B~Ube₃₂ QoiHeader~Width
  B~F‼B~Ube₃₂ QoiHeader~Height
  B~F‼B~Ube₈  QoiHeader~Channels
  B~F‼B~Ube₈  QoiHeader~Colorspace
)

QoiHeader 123 321 1 2
°QoiHeaderBin[]
# [65 63 57 54 123 0 0 0 65 1 0 0 1 2]

# pop is used to remove remaining bytes of parser
◌QoiHeaderBin
```
