---
comments: true
icon: lucide/flag
description: Flags for switches—optional arguments which modify the behavior.
---

# Flag
Flags for switches. Optional arguments which modify the behavior.

|  Long  | Short | Exclusive |
| :----: | :---: | :-------: |
| `flag` |  `f`  |    None   | 

## Syntax: header
The following are brief details about the syntax used to specify headers
### Basic
The headers convey the *flag* arguments (*long* and *short*): `<long>:<short>`
### Omitting *short*
The *short* flag can be omitted if it isn't supported; that is, the `<short>` part would not be part of the string. (the `:` stays): `<long>:`

## Internal Formatting: Short Omission
If a short flag is unspecified, a red `~` takes its place, indicating that it isn't supported.

!!! note "Effect on descriptions"
    [The *description* texts may be affected by the *Positional* switch](./Positional.md#internal-description-formatting){data-preview}
