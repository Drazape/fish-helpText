---
comments: true
icon: lucide/pin
description: Arguments recognised by their position
---

# Positional
Arguments recognised by their position

|     Long     | Short | Exclusive |
| :----------: | :---: | :-------: |
| `positional` |  `p`  | [Sub-Command](Sub-Command "Different operations from a single command") |

!!! note "Pairing with Sub-Command"
    The program doesn't stop you from using it with [Sub-Command](./Sub-Command.md "Different operations from a single command"){data-preview}, but there isn't really a use-case to do so

## Types
There are 4 Types of positional arguments, each having a different syntax used on the header:
### Static
When all the arguments appear a fixed number of time, then the *header* is simply a string, without any special syntax (prefix).


### Variable [^arg-dir]
If there are variable arguments, prepend the variable argument's position [^single-vararg] with a `+`. This will affect the index of all the positionals that follows. [^index]

!!! tip "Experiment the `+` prefix"
    Try fooling around by prefixing `+` on different positions to know how it would affect the index counts

### Optional
If arguments are optional, then you would use the earlier two types for the most part, but include a new row telling the user what happens when no argument is specified, with the header prefixed with a `-`.

!!! warning "Must support argument-less execution"
    Don't use this if the command throws an error when supplied no positional arguments

The header can be anything you like, e.g.:
- *None*
- *Null*
- *Empty*
- *Current* (in case of programs that take a path as argument{,s}; not a standard, just an example)

!!! note "Simultaneous Usage"
    The 3 positional arguments types above can by simultaneously used (Until multiple types aren't used on a single positional)

### None
Don't pass the *Positional* switch if positional arguments aren't accepted.

## Internal *Description* formatting
Each header matched in the *description*s is automatically italicized


[^single-vararg]: There can only be one variable positional argument since there is no way of determining if an argument is a fixed argument or a variable argument, and if a variable argument, then which one
[^index]: The index of the variable argument will simply be a `+`, while the followed positionals will be negatively indexed, and the rest of the positionals (before the variable positionals) will be positively indexed (like they do without any variable argument)
[^arg-dir]: The direction of the arguments can be both from the left and the right. This determines if the index value displayed to the user would be positive (left) or negative. Negative indices are the only choice for arguments followed by variable arguments
