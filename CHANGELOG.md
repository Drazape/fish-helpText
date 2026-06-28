# [v0.2.2] - feat: Hypertext linkers
<!-- New changes here  -->
A new switch—[Hyperlink](https://drazape.github.io/fish-helpText/Arguments/Switches/Hyperlink/ "New Documentation") accepts a [command](https://drazape.github.io/fish-helpText/Linkers/ "New Documentation") that returns URLs for different sorts of headers.
One for help-text itself is already made. To make the process easier, a new repository is created that would contain hyper-text linker frameworks. Though empty, contributions are welcome.


# [v0.2.1] - Sub-Commands support
## New Features
### Sub-Commands
You can now include sub-commands in the reference text.  
You can use this for a better interface structure by listing universal switches and supported sub-commands in the main command instead of listing them each time for every sub-command.

## Enhancements
Various internal refactoring and minuscule performance and logic improvements.

## For distributors
The structure was changed so that the helper functiosn have their own function file. This allows for avoiding evaluating of the functions each time the command is called. It is the best time to do so now that the command can be used for multiple sub-commands.


# [v0.2.0] - Variable positionals & rename switch: `switch` → `flag`
## Variable Positionals
You can now create variable flag arguments. This means that the positionals can be of any number, and even comprise of mixed sorts of positionals.
You can also add information about how what happens when no positionals are specified

## Rename Switch: `switch` → `flag`

# [v0.1.1] - vargs: indi & formatting
Support for variable Arguments—those that *could* be more than one


# [v0.1.0] - Complete Functionality
All the planned main functionality has been implemented
