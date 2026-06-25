---
comments: true
icon: lucide/link
description: Hyperlink headers
---

# Hypertext
Dynamically hyperlink help-text headers to documentation

|  Long  | Short | Exclusive |
| :----: | :---: | :-------: |
| `link` |  `l`  |    None   |

# Syntax
The first argument is the Base Command, while the others are positional arguments passed to the specified base command. It is essentially the same format as used on the shell, but instead seperated by a `,`.  
```fish {title="Format" .no-select .no-copy}
help-text --link={<base-command>,<arg1>,<arg2>,<…>}
```

# Command
## Permanent Arguments
- **Initial**: The command specified is always executed with the explicitly specified arguments as the initial ones.
- **Immutable**: Once specified, these explicit arguments do not change, and are always provided each time it is ran, for any purpose.
??? info "Internal Implementation"
    The arguments and the base command are treated as a single entity, and aren't explicitly handled.  
    All the values passed—the base command, and it's arguments—are called as is on the shell; essentially, the passed values are treated as if it were a single command.
!!! tip "Use"
    These are mainly used for abstraction. There could be a multi-purpose command that works for more than one use cases when used with different permanent arguments
## Headers data
### Final
These are the last 2 arguments, conveying information about the current header.
*[current header]: The header in batch that the information is passed of
#### Type `-2`
One of the following values are passed for the type.
!!! tip "Same as flag"
    The values passed as the type are the same as the long flag names passed for rendering
- `heading`
- `sub-command`
- `positional`
- `flag`

#### Name `-1`
The header you gave to the command (the description is not passed.)
!!! note "Flag Header"
    In case the header is a flag, then only the long flag is passed (short flag is omitted)
!!! info "Heading titles"
    In case the of a heading title, the title can be one of the argument flags accepted:

    - Sub-Commands
    - Positionals
    - Flags
    !!! tip "Value Derivation"
        The values are the same as the text that shows up on the rendering. This is because of the internal implementation.

### Variable 
The passed header data will be a different combination each time it is passed.  
The job of the command is to return the URL to the specific page requested.
