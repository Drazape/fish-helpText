# Description
Fish library to generate formatted console help reference texts using an intuitive syntax

# Demonstration
## help-text (self)
```fish
help-text 'Generate help reference text' https://github.com/Drazape/fish-helpText/wiki \
	--position='Description | The purpose of the command' \
	--flag={
		'positional:p | Individual positional arguments',
		'flag:f | Individual switches'
	}
```
<img width="1896" height="781" alt="help-text (self)" src="https://github.com/user-attachments/assets/75a2d35a-5027-4d8a-8531-7ea0fbb5dc52" />

## [fish-subAbbr](https://github.com/Drazape/fish-subAbbr "Simplify abbrevating subcommands")
```fish
begin
	set --local inherited \ (set_color white)'(inherited from '(set_color --reset --background=red)abbr(set_color --reset white)\)(set_color --reset)
	help-text 'Abbreviate subcommands' \
		--positional={
			'+Initial Args | All arguments that come before the Sub-Command', 
			'Sub-Command | Comes after the Base Command; replaced by the Expansion',
			'Expansion | Replaces the Sub-Command'
		} \
		--switch={
			'help:h | Show this reference manual',
			'norun0:0 | Disable '(set_color --background=red)run0(set_color --reset)' toleration for abbreviations',
			'regard-flags:s | Acknowledge flags in the Base Command',
			'set-cursor:c | Position the cursor at '(set_color --background=brblack)%(set_color --reset)' post-expansion'{$inherited},
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
```fish
curl -fsSL 'https://raw.githubusercontent.com/Drazape/fish-helpText/main/install.fish' | run0 fish -NP
```

> [!IMPORTANT]
> [More ways to install](https://github.com/Drazape/fish-helpText/wiki/Installation#Package-Manager "Distribution Package Managers")
