# uiua-bin
Easy binary (de-) serialization in Uiua.

All (de-)serializers have a signature of `RemainingBytes Value <- Bytes`, or for the inverse: `Bytes <- Bytes Value`

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

## Features
- (de-)serialization of (un-)signed little- / big- endian integers
- de-serialization of floats (F16, F32, F64, BF16) (encoding not yet supported)
- (de-)serialization of null-terminated strings
- (de-)serialization of optionally length-prefixed arrays, structs, and variants

## Usage
[Auto-generated docs](https://alex-s168.github.io/uiua-bin/)

### String Array
```
~ Ty {Name Members}

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

## `NoInv!`
When writing serializers for variants, and som variant cases only support de-serialization,
you might want to use `NoInv! F` to not get a compile-time "No inverse found" error when un- ing the parser, and instead get a runtime error if the variant case gets matched.

## modifying binary data
Uiua provides the "under" modifier, which can be used for this:
```
[113 111 105 102 123 0 0 0 65 1 0 0 1 2]
# reduce "Width" in "QoiHeader" by 10
⍜(QoiHeader~Width◌QoiHeaderBin)(-10)
## [113 111 105 102 113 0 0 0 65 1 0 0 1 2]
```
