# uiua-bin
Easy binary (de-) serialization in Uiua.

All (de-)serializers have a signature of `RemainingBytes Value <- Bytes`, or for the inverse: `Bytes <- Bytes Value`

[Auto-generated docs](https://alex-s168.github.io/uiua-bin/)

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

## Examples
### String Array
```
~Ty {Name Members}

TyGBin ← M‼Z!Ty(
  F!!CStr__8 Ty~Name
  F‼Arr!!Ule__16 CStr__8 Ty~Members
)
```

### Variants
```
~ Ty {Name Type Value}
~ TyUser {Password}
~ TyGroup {Members}

TyUserBin ← M‼Z!TyUser(
  F‼CStr__8 TyUser~Password
)

TyGroupBin ← M‼Z!TyGroup(
  F‼Arr!!Ule__16 CStr__8 TyGroup~Members
)

TyBin ← M‼Z!Ty(
  F‼UStr__8 Ty~Name
  Multi!(
    Var‼Ule₈ InvTry!(
      VarEnt‼0 Map!!box TyUserBin
    | VarEnt‼1 Map!!box TyGroupBin
    | VarFail)
  | Ty~Type | Ty~Value)
)
```
