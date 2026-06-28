function _help-text_internal_linker --description='Linker for help-text itself' --argument-names={type,name}
    set --local -- baseURL https://drazape.github.io/fish-helpText
    if test (count {$argv}) -eq 0
        echo -- {$baseURL}/
        return
    end
    set --local -- baseURL {$baseURL}/Arguments

    switch {$type}
        case heading
            switch {$name}
                case Positionals
                    echo -- {$baseURL}/Positionals/Description/
                case Flags
                    echo -- {$baseURL}/Switches/Hyperlink/
            end
        case positional
            echo -- {$baseURL}/Positionals/{$name}/
        case flag
            switch {$name}
                case url
                    echo -- {$baseURL}/Switches/Hypertext/
                case flag positional
                    echo -- {$baseURL}/Switches/Arguments/(string upper -- (string sub --end=1 -- {$name}))(string sub --start=2 -- {$name})/
                case sub-command
                    echo -- {$baseURL}/Switches/Arguments/Sub-Command/
            end
    end
end
