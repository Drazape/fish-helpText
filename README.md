# Purpose
Generate formatted console help reference texts. Primarily used by other Fish programs.

# Demonstration
## help-text (self)
```fish
help-text 'Generate help reference text' \
	--position='Description | The purpose of the command' \
	--flag={
		'positional:p | Individual positional arguments',
		'flag:f | Individual switches'
	}
```
<img width="1894" height="560" alt="help-text (self)" src="https://github.com/user-attachments/assets/49680185-8e6f-42b9-a363-aac773890734" />

## [fish-subAbbr](https://github.com/Drazape/fish-subAbbr "Simplify abbrevating subcommands")
```fish
begin
	set --local inherited \ (set_color white)'(inherited from '(set_color normal)(set_color --background=red)abbr(set_color normal)(set_color white)\)(set_color normal)
	help-text 'Abbreviate subcommands' \
		--positional={
			'+Initial Args | All arguments that come before the Sub-Command', 
			'Sub-Command | Comes after the Base Command; replaced by the Expansion',
			'Expansion | Replaces the Sub-Command'
		} \
		--switch={
			'help:h | Show this reference manual',
			'norun0:0 | Disable '(set_color --background=red)run0(set_color normal)' toleration for abbreviations',
			'regard-flags:s | Acknowledge flags in the Base Command',
			'set-cursor:c | Position the cursor at '(set_color --background=brblack)%(set_color normal)' post-expansion'{$inherited},
			'regex:r | Match Sub-Command with Regex. Essential for multiple Base Commands'{$inherited}
		}
end
```
<img width="1377" height="342" alt="sub-abbr" src="https://github.com/user-attachments/assets/b677e4ef-660b-40b8-a35e-81fd65d35d46" />

> [!TIP]
> [Discover programs that use this library](https://github.com/topics/fish-helptext)

> [!IMPORTANT]
> See the [wiki](https://github.com/Drazape/fish-helpText/wiki) for usage

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
