# Purpose
Generate formatted console help reference texts. Primarily used by other Fish programs.

# Demonstration
## help-text (self)
```fish
help-text 'Generate help reference text' \
	--position='Description | The purpose of the command' \
	--switch={
		'varg:v | Use variable positional arguments',
		'positional:p | Individual positional arguments',
		'switch:s | Individual switches'
    }
```
<img width="1839" height="593" alt="help-text" src="https://github.com/user-attachments/assets/94911288-a135-4b79-8492-ad4aeab1f9e5" />

## [fish-subAbbr](https://github.com/Drazape/fish-subAbbr "Simplify abbrevating subcommands")
```fish
help-text 'Abbreviate subcommands' \
	--positional={
		'Base Command | Comes before the '(set_color --italics)Sub-Command(set_color normal)'; flags are ignored by default', 
		'Sub-Command | Comes after the '(set_color --italics)Base\ Command(set_color normal)'; replaced by the '(set_color --italics)Expansion(set_color normal),
		'Expansion | Replaces the '(set_color --italics)Sub-Command(set_color normal) } \
	--switch={
		'help:h | Show this reference manual',
		'norun0:0  | Disable '(set_color --background=red)run0(set_color normal)' toleration for abbreviations',
		'regard-flags:s | Acknowledge flags in the' (set_color --italics)'Base command'(set_color normal),
		'set-cursor:c | Position the cursor at '(set_color --background=brblack)%(set_color normal)' post-expansion '(set_color white)'(inherited from '(set_color normal)(set_color --background=red)abbr(set_color normal)(set_color white)\)(set_color normal) }
```
<img width="1839" height="541" alt="sub-abbr" src="https://github.com/user-attachments/assets/aa238255-a00f-4b2e-b647-12bb9ab6aacd" />

> [!TIP]
> Create an issue to get your project listed here. If it stands out, it can also be used as a demonstration here.

---

# Usage
Create personal Sub-Command abbreviations in the scope
## Arguments
### Positional (single)
**Description**: The purpose of the command
### Switches
- **Help**: Show a [reference manual](#help-text-self) — consisting of the [purpose](#Purpose "The purpose of the library") & [arguments](#Arguments "Descriptions on all the supported arguments")
	- **Long**: *help*
	- **Short**: *h*
- ***Var*iable *Ar*guments**: When the number of arguments that could be supplied is unknown
	- **Long**: *v*
	- **Short**: *varg*
- **Positional Argument**: Individual details of the positional arguments
	- **Long**: *positional*
	- **Short**: *p*
- **Switch**: Individual details of the switches
	- **Long**: *switch*
	- **Short**: *s*

---

# Installation
## User
[**Fisher**](https://github.com/jorgebucaran/fisher): `fisher install Drazape/fish-helpText`
## System
### Traditional Distributions
```fish
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```
It will update each time it is run
## NixOS
A flake with convenient configuration options is planned.
### Workaround
For now, the installation can be worked-around (with automatic updates). This way is not supported and may stop working after an update.
#### `flake.nix`:
```nix
{
	inputs = {
		fish-helpText = {
				type="github"; owner="Drazape"; repo="fish-helpText";
				flake = false;
		};
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
#### Module with the Fish configuration:
```nix
{ inputs, … }: {
	…
	programs.fish = {
		shellInit = ( # Fish subcommand abbreviation (workaround)
			builtins.concatStringsSep "\n" (
				builtins.map builtins.readFile 
						(builtins.map
							(subDir: inputs.fish-helpText + ("/"+subDir) + "/help-text.fish")
							[ "completions" "functions" ])
		) + ''
			…
		'';
		…
	};
};
```
