# uiua-bin
Easy binary (de-) serialization in Uiua.

All (de-)serializers have a signature of `RemainingBytes Value ? Bytes`, or for the inverse: `Bytes ? Bytes Value`

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

### Importing
You should depend on a fixed version of this module, instead of the latest, because of possible major API changes.

On GitHub, you can see the latest version. Put that into here:
```
B ~ "git: github.com/alex-s168/uiua-bin branch:v0.4.5"
```

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
  F!!V!(
    Ule₈
  | 0 => Map!!box TyUserBin
  | 1 => Map!!box TyGroupBin
  )Ty~Value
)
```

#### Storing the Tag
Sometimes it is useful to store the tag of the variant as output to the parser. You can apply `B~Map‼. P` to the tag parser (where `P` is the tag parser).
This makes your whole parser a multi-value parser (2 values). You can use [`Multi!`](#multi-value-parsers) to process the values

### `NoInv!`
When writing serializers for variants, and som variant cases only support de-serialization,
you might want to use `NoInv! F` to not get a compile-time "No inverse found" error when un- ing the parser, and instead get a runtime error if the variant case gets matched.

### modifying binary data
Uiua provides the "under" modifier, which can be used for this:
```
[113 111 105 102 123 0 0 0 65 1 0 0 1 2]
# reduce "Width" in "QoiHeader" by 10
⍜(QoiHeader~Width◌QoiHeaderBin)(-10)
## [113 111 105 102 113 0 0 0 65 1 0 0 1 2]
```


### multi value parsers
Parsers that return multiple values have a signature of for example `RemBytes A B ? Bytes`.

To bind mutliple values of a parser to a struct, you can use `Multi!`:
```
Mutli!(
  InsertMultiOutputParserHere
| MyStruct~FieldA | MyStruct~FieldB)
```

This can be used inside `M!!`
