---
comments: true
icon: lucide/link-2
description: Distribution ways
---
# Linkers
Linkers are commands that [link](../Arguments/Switches/Hyperlink.md){data-preview} the headers with URLs for users to follow to the external documentation.

They are simply passed with the details of the headers, and return a URL that is then hyperlinked to the respective header.

## Distribution Methods
### Comparison
|  ~  | [Official Repository](#official-repository){data-preview} | [3rd-party](#3rd-party){data-preview} |
| :-: | :-----------------------------------------: | ---------------------- |
| **Distribution** | Via base package | Yourself. Users will have to install the package before using it. |
| **Configuration** | ❌ | Optional |
| **Updates** | Delayed for review | Direct |


### Methods
#### Official Repository
Each linker is a single function in the repository that provides URLs for the specific documentation website/framework it corresponds to.  

!!! tip "Gaze at Pre-existing linkers"
    Have a look at other packages defined in the [repository](https://github.com/Drazape/fish-helpText/tree/main/functions/help-text/hyper/ "Official Hyper-linker Repository"){data-preview} before pushing your own here.

!!! warning "Anti-legacy"
    Legacy software with modern alternatives won't be included in the official repository.  
    Tradition, familiarity with the legacy, inertia towards innovation—these won't be reasons accepted for "contributions."  
    The ancients can build their own museum (legacy-stone repository).

#### 3rd-party
3rd-party packages/repositories can use the program however they want.

You might be able to get some creative inspiration by exploring existing packages/repositories, or you could also choose an unofficial repository if it suits your project better. 

!!! tip "Discovery"
    Make your 3rd-party project discoverable with the [topic](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics#adding-topics-to-your-repository){data-preview}: [`helptext-linker`](https://github.com/topics/helptext-linker){data-preview}
