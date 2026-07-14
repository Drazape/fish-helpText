---
comments: true
icon: lucide/download
desription: Installation procedure and methods
---

# Installation
## Dependencies
- [format](https://github.com/Drazape/fish-format "GitHub repository"){data-preview}: Intuitively generate ANSI sequences

## Procedure
The installation involves moving Fish files from the directories

- [`functions`](https://github.com/Drazape/fish-helpText/tree/main/functions){data-preview} (→ `$fish_function_path`)
- [`conf.d`](https://github.com/Drazape/fish-helpText/tree/main/conf.d){data-preview}

to the appropriate paths in the host system, depending on the installation type.

Each file in `functions/` must be renamed such that each sub-directory's name is prefixed to it such that the file name is `parentDir_childDir_file`
!!! tip "Function Name"
    See the function's name in the respective file to obtain the file-name of it (`.fish` suffixed)

## Scope
### User
#### Automatic: Package Manager
Auto-updates via the package manager  
[**Fisher**](https://github.com/jorgebucaran/fisher "Fish plugin manager"){data-preview}: `#!fish fisher install Drazape/fish-helpText`
#### Manual
Move the directories into your Fish configuration in the home directory (`~/.config/fish/`):

### System
#### Automatic
##### Script (local)
This locally installs the program and updates each time it is run
```fish {title="curl-to-fish script" .no-select}
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```
##### Package Manager
As of now, no distribution package manager is supported.

###### NixOS
!!! warning "Manual Dependency"
    You'll need to manually install the [dependencies](#dependencies){data-preview}.
		!!! info "Future Fish dependencies automation"
				For the package, a special wrapper for Fish dependencies (planned) needs to be made.

```nix {hl_lines="4" title="flake.nix"}
{
	inputs = {
		…
		fish-helpText = { type="github"; owner="Drazape"; repo="fish-helpText";	};
		…
	};
	outputs = inputs@{ self, nixpkgs, …, ... }: {
		nixosConfigurations."yourHost" = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			…
		};
		…
	};
}
```
```nix {hl_lines="5" title="Module with the Fish configuration"}
{ inputs, … }: {
	…
	environment.systemPackages = [
		…
		inputs.fish-helpText.packages."${stdenv.hostPlatform.system}".default
		…
	]
	…
};
```

#### Manual
The files must be moved to the vendor (`vendor_*.d`) system-wide path

- **Package Manager**: Normal system path managed by the package manager
- **Local**: Local directory for non-packaged programs
