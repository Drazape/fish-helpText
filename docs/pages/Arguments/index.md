---
comments: true
icon: lucide/parentheses
description: A combination of 2 sorts of syntax is used for the parsing.
---

# Arguments
A combination of 2 sorts of syntax is used for the parsing.

## Fish Native
Native data-structures parsed by Fish, for *helpText*.

### Features
- Familiar
- Evaluated even before passed the actual program by the shell
- Multiple equifinal ways

### Usage: Arguments
Currently, there is only one positional argument, so the order of the arguments doesn't matter (regardless of type)
#### Positional
Simply pass the string after the Base Command.
#### Flags
##### Value-less
Flags that don't accept or require a value can simply be passed just like *Positional* arguments, with the limitation that each flag must be passed before `--` is.
##### Value
###### Single
If the flag accepts a single value, use the flag once. Multiple uses overwrite the previous value.
###### Multiple
Instead of passing the flag multiple times, you can simply use `{}` with the `,` delimeter to pass multiple *values*.
```fish {title="Syntax" .no-copy}
help-text --<long-flag>={
    …,
    …,
    …
  }
  -<s>{
    …,
    …,
  }
```
Those *values* (`…`) contain the [Self-parsed Syntax](#self-parsed).

## Self-parsed
Syntax for data-structures unavailable natively in Fish.
### Usage
#### Common
The *header* and the *description*s are separated by ` | `.
```fish {title="Format" .no-copy .no-select}
help-text --<flag>='<header> | <description>'
```

- [Sub-Command](Switches/Arguments/Sub-Command.md){data-preview}
- [Positionals](Switches/Arguments/Positional.md){data-preview}
- [Flags](Switches/Arguments/Flag.md){data-preview}

!!! info "Dimmed Puntuation"
    The punctuation (`;` `,` `.`) in the descriptions on each of the switches is automatically dimmed

### Features
- **Limited**: The syntax parsed by the program itself only includes division of certain sections in the text, since most of the parsing is handled by native Fish data-structures.  
- **Inescapable**: The only escaping ever possible in the self-parsed syntax would be ` | ` splitting and `+` prefixes (in case of fixed number of arguments) in headers; these are very unlikely to literally appear in those, and hence, escaping is not an option.
