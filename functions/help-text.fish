function help-text --description='Generate help reference text'
    set --function output_name (set_color --dim)(status current-function)(set_color normal)

    # parse arguments
    argparse 'h/help&' 'm/multi-pos&' 'p/positional=+&' -- {$argv}

    if set --query --local _flag_help
        echo 'print help reference using the function' # pending
        return
    end
    begin
        set --local num_positional_args 1
        set arg_count (count {$argv})
        if test {$arg_count} != {$num_positional_args}
            echo {$output_name}(set_color --dim white):(set_color normal) expected (set_color --bold){$num_positional_args}(set_color normal) 'positional arguments; got' (set_color --italics){$arg_count}(set_color normal)
            return 1
        end
    end
    set --local command_description {$argv}
    set --local --erase argv

    # common stuff
    function output-format --description='Slightly dim semi-colon'
        string trim {$argv} | string replace \; (set_color white)\;(set_color normal)
    end

    function bullet --description='Create colored bullet points'
        echo \ (set_color --dim yellow)"$argv"(set_color normal)
    end
    function heading --description='Create headings for headers'
        echo (set_color --bold --underline --underline-color=brblue blue)"$argv"(set_color normal)(set_color brblue):(set_color normal)
    end
    function header --description='Create headers for subheads'
        echo (set_color --bold green)"$argv"(set_color normal)
    end
    function subhead --description='Create an attribute set header'
        echo (set_color --italics green)"$argv"(set_color normal)
    end
    set --local sep \t(set_color --dim)│(set_color normal)

    function largest-length --description='Find the string with the largest length'
        set --function lengths (string length {$argv})
        set --function big {$lengths[1]}
        for length in {$lengths}
            test {$big} -lt {$length} && set --function big {$length}
        end
        echo {$big}
    end

    echo (set_color brmagenta){$command_description}(set_color normal)\n

    ## Arguments
    ### Positional
    if set --local --query _flag_positional
        heading Positional

        set --local names
        set --local descriptions
        for positional_argument in (string trim {$_flag_positional})
            set --local details (string split --max=2 ' | ' {$positional_argument})
            set --append names {$details[1]}
            set --append descriptions {$details[2]}
        end
        set --local largest_name_length (largest-length {$names})
        set --local largest_description_length (largest-length {$descriptions})

        for i in (seq 1 (count {$names}))
            set --local --query _flag_multi-pos && echo -n (bullet {$i}.)
            echo (header (string pad --right --width={$largest_name_length} {$names[$i]})) {$sep} (string pad --right --width={$largest_description_length} {$descriptions[$i]})
        end
    end
end
