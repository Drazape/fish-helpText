---
comments: true
icon: lucide/house
description: Home Page
---

# Home
Generate formatted console help reference texts. Primarily used by Fish programs.

## Features
- **Modern view**: The layout doesn't follow any of the legacy traditions
- **Colored text**: Each pixel is taken special care of
- **Minuscule details**: You will notice that the color of `:` and the underlines is slightly lighter than the main text. The pointers are dimmed to avoid unnecesary attention.
- **Section division**: Each section is a [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself "reducing repetition of information"){data-preview} division by categories
- **Adaptive spacing and column lengths**: Each of the columns are dynamically spaced and underlined depending on the lengths of the text input
- **Multiple sorts of positional arguments supported**: Programs that take fixed or variable number of arguments — or even a mix of both — are all supported
- **Automatically formatted description substrings**: The Positional Arguments mentioned are in descriptions are automatically italicized, while punchuation is slightly dimmed
- **Clean [syntax](Arguments/index.md){data-preview}**: It uses a very easy and readable syntax, and avoids it by using native data structures where possible
- **Native Fish data structures**: Use of syntax and manual parsing is minimized with the use of Fish native data-structures

## Discoverability
Make your program visible by allowing users to discover it with the [topic](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics#adding-topics-to-your-repository){data-preview}: [fish-helpText](https://github.com/topics/fish-helpText){data-preview}.

It might be used as a [demonstration in the Readme](https://github.com/Drazape/fish-subAbbr#uses){data-preview} if at least one of the 2 conditions are met:
- It showcases a feature / usage that is not already demonstrated
- It showcases a feature better / stands-out more than an existing demonstration
