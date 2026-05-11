function help-text --description='Generate help reference text'
    set --function output_name (set_color --dim)(status current-function)(set_color normal)

    # parse arguments
    argparse 'h/help&' 'v/varg&' 'p/positional=+&' 's/switch=+&' -- {$argv}

    if set --query --local _flag_help
        help-text 'Generate help reference text' \
            --position='Description | The purpose of the command' \
            --switch={
                'varg:v | Use variable positional arguments',
                'positional:p | Individual positional arguments',
                'switch:s | Individual switches'
            }
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
        echo (set_color --bold --underline{,-color=brblue} blue)"$argv"(set_color normal)(set_color brblue):(set_color normal)
    end
    function header --description='Create headers for subheads'
        echo (set_color --bold green)"$argv"(set_color normal)
    end
    function title --description='Create a title for subheads'
        echo (set_color --underline{,-color=brcyan} --bold cyan)"$argv"(set_color normal)
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

    # Output
    ## Description
    echo (set_color brmagenta){$command_description}(set_color normal)\n

    ## Arguments
    ### Positional
    if set --local --query _flag_positional
        heading Positional

        # data
        set --local names
        set --local descriptions
        for positional_argument in (output-format {$_flag_positional})
            set --local details (string split --max=2 ' | ' {$positional_argument})
            set --append names {$details[1]}
            set --append descriptions {$details[2]}
        end
        set --local largest_name_len (largest-length {$names})

        # print
        for i in (seq 1 (count {$_flag_positional}))
            set --local --query _flag_varg || echo -n (bullet {$i}.)
            echo \ (header (string pad --right --width={$largest_name_len} {$names[$i]})) {$sep} {$descriptions[$i]}
        end
    end

    ### Switches    
    if set --local --query _flag_switch
        heading Switches

        # data
        set --local short_flags
        set --local long_flags
        set --local descriptions
        for switch in (output-format {$_flag_switch})
            set --local details (string split --max=2 ' | ' {$switch})
            set --local flags (string split --max=2 : {$details[1]})
            set --append descriptions {$details[2]}
            set --local short_flag {$flags[2]}
            if test -z {$short_flag}
                set --append short_flags (set_color brred)\~
            else
                set --append short_flags {$short_flag}
            end
            set --append long_flags {$flags[1]}
        end
        set --local largest_longFlag_len (largest-length {$long_flags})

        echo (string repeat 3 \ )(title (string pad --center --width={$largest_longFlag_len} long)) (title short)
        # print
        for i in (seq 1 (count {$_flag_switch}))
            echo (bullet •) (subhead (string pad --center --width={$largest_longFlag_len} {$long_flags[$i]})\ (string pad --center --width=5 {$short_flags[$i]})) {$sep} {$descriptions[$i]}
        end
    end
end
