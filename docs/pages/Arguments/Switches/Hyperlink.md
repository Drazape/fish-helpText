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

# Working
To hyperlink headers to an externla documentation, this switch is used to do that intuitively, and dynamically.

This flag mandatorily accepts a value. This value is a [command](#command) which ran multiple times throughout the display of the help-text.  
This command has a strict input and output format that it is required to comply with, and is passed with the necessary data to generate the URL for the specific header. The command is ran each time a header is displayed, and the output is used to hyperlink the header to the documentation.

# Syntax
The first argument is the Base Command, while the others are positional arguments passed to the specified base command. It is essentially the same format as used on the shell, but instead separated by a `,`.  
```fish {title="Format" .no-select .no-copy}
help-text --link={<base-command>,<arg1>,<arg2>,…}
```

# Command
The following describes the input and output of the command
## Permanent Arguments
- **Initial**: The command specified is always ran with the explicitly specified arguments as the initial ones.
- **Immutable**: After specified, these explicit arguments do not change, and are always provided each time it is ran, for any purpose.
??? info "Internal Implementation"
    The arguments and the base command are treated as a single entity, and aren't explicitly handled.  
    All the values passed—the base command, and it's arguments—are called as is on the shell; essentially, the passed values are treated as if it were a single command.
!!! tip "Use"
    These are mainly used for abstraction. There could be a multi-purpose command that works for more than one use cases when used with different permanent arguments
## Headers data
### Final
These are the last 2 arguments, conveying information about the current header.
*[current header]: The header in batch that the information is passed of

#### `-2` Type
This is the second last argument to the command, and it conveys the type of the current header.

One of the following values are passed for the type.
!!! tip "Same as flag"
    The values passed as the type are the same as the long flag names passed for rendering
- `heading`
- `sub-command`
- `positional`
- `flag`

#### `-1` Name
The last argument to the command which is the header you gave to the command (the description is not passed.)
!!! note "Flag Header"
    In case the header is a flag, then only the long flag is passed (short flag is omitted)
!!! info "Heading titles"
    In case the of a heading title, the title can be one of the accepted argument flags:

    - Sub-Commands
    - Positionals
    - Flags
    !!! tip "Value Derivation"
        The values are the same as the text that shows up on the rendering. This is because of the internal implementation.

!!! tip "Additional Data"
    Other than the type and name, other custom data can be passed as well.

    For example, you have 2 sub-commands that both accept a switch with the same name, and both of them have different pages for the documentation.
    In this case, you can export a custom variable that you call `help-text` with that—one that your linker recognises.
    ```fish {title="Format"}
    my_subcommand=<name> help-text --link=my-linker
    ```
    This value will be passed on to your linker, with which you can use standard conditional output to generate different URLs for each sub-command—even though the header would be the same.

### Variable 
The passed header data will be a different combination each time it is passed.  
The job of the command is to return the URL to the specific page requested.
