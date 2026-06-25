---
comments: true
icon: lucide/flag
description: Flags for switches. Optional arguments that modify the behavior.
---

# Flag
Flags for switches. Optional arguments that modify the behavior.

|  Long  | Short | Exclusive |
| :----: | :---: | :-------: |
| `flag` |  `f`  |    None   | 

## Syntax: header
### Basic
The headers convey the *flag*s (*long* and *short*): `<long>:<short>`
### Omitting *short*
The *short* flag can be omitted if it isn't supported. i.e., the `<short>` part would not be part of the string. (the `:` stays): `<long>:`

## Internal Formatting
### Short Omission
If a short flag is unspecified, a red `~` takes its place, indicating that it isn't supported.

!!! note "Effect on descriptions"
    [The *description*s may be affected by the *Positional* switch](./Positional.md#internal-description-formatting){data-preview}
