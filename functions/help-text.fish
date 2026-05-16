function help-text --description='Generate help reference text'
    set --function -- output_name (set_color --dim)(status current-function)(set_color normal)

    # parse arguments
    argparse 'h/help&' 'p/positional=+&' 'f/flag=+&' -- {$argv}

    if set --query --local -- _flag_help
        help-text 'Generate help reference text' \
            --position='Description | The purpose of the command' \
            --flag={
                'positional:p | Individual positional arguments',
                'switch:s | Individual switches'
            }
        return
    end
    begin
        set --local -- num_positional_args 1
        set -- arg_count (count {$argv})
        if test {$arg_count} != {$num_positional_args}
            echo {$output_name}(set_color --dim white):(set_color normal) expected (set_color --bold){$num_positional_args}(set_color normal) 'positional arguments; got' (set_color --italics){$arg_count}(set_color normal)
            return 1
        end
    end
    set --local -- command_description {$argv}
    set --local --erase -- argv

    # common stuff
    function output-format --description='Slightly dim punctuation'
        function slight-dim
            echo (set_color white)"$argv"(set_color normal)
        end
        string trim -- {$argv} | string replace -- \; (slight-dim \;) | string replace -- , (slight-dim ,) | string replace -- . (slight-dim .)
    end
    function italicize-names --description='Return the last argument with all sub-strings that are the initial arguments capitalized'
        set --function italicized {$argv[-1]}
        for name in {$argv[1..-2]}
            set --function -- italicized (string replace -- {$name} (set_color --italics){$name}(set_color normal) {$italicized})
        end
        echo {$italicized}
    end

    function bullet --description='Create colored bullet points'
        echo (set_color --dim yellow)"$argv"(set_color normal)
    end
    function heading --description='Create headings for headers'
        echo (set_color --bold --underline{,-color=brblue} blue)"$argv"(set_color normal)(set_color brblue):(set_color normal)
    end
    function title --description='Create a title for subheads'
        echo (set_color --underline{,-color=brcyan} --bold cyan)"$argv"(set_color normal)
    end
    set --local -- sep \t(set_color --dim)│(set_color normal)

    function largest-length --description='Find the string with the largest length'
        set --function -- lengths (string length -- {$argv})
        set --function -- big {$lengths[1]}
        for length in {$lengths}
            test {$big} -lt {$length} && set --function -- big {$length}
        end
        echo {$big}
    end

    # Output
    ## Description
    echo (set_color brmagenta){$command_description}(set_color normal)\n

    ## Arguments
    ### Positional
    if set --local --query -- _flag_positional
        heading Positional

        # data
        set --function -- varpos_index 0
        set --function -- none_index -1
        for positional_argument in (output-format {$_flag_positional})
            set --local -- details (string split --max=2 -- ' | ' {$positional_argument})
            set --append --function -- descriptions {$details[2]}
            set --local -- pos_details {$details[1]}
            if string match --regex --entire --quiet -- '^\+' {$pos_details}
                set --function -- varpos_index (count {$descriptions})
                set -- pos_details (string sub --start=2 -- {$pos_details})
            end
            if string match --regex --entire --quiet -- '^-' {$pos_details}
                set --function none_index (count {$descriptions})
                set -- pos_details (string sub --start=2 -- {$pos_details})
            end
            set --append --function -- pos_names {$pos_details}
        end
        set --local -- largest_name_len (largest-length {$pos_names})

        # print
        set --local -- subtract_none 0
        set --local -- varpos_left
        for i in (seq 1 (count {$_flag_positional}))
            if test {$none_index} -eq {$i}
                echo -n \ (bullet -)' '
                set -- subtract_none 1
            else if test {$varpos_index} -eq 0
                echo -n \ (bullet (math {$i} - {$subtract_none}).)
            else if test {$i} -eq {$varpos_index}
                echo -n \ (bullet +)' '
                set --local --erase varpos_left
            else if set --query --local -- varpos_left
                echo -n \ (bullet (math {$i} - {$subtract_none}))
            else
                echo -n (bullet (math {$i} - (count {$pos_names}) - 1))
            end
            echo \ (set_color --bold green)(string pad --right --width={$largest_name_len} -- {$pos_names[$i]})(set_color normal) {$sep} (italicize-names {$pos_names} {$descriptions[$i]})
        end
    end

    ### Switches    
    if set --local --query -- _flag_flag
        heading Switches

        # data
        set --local -- short_flags
        set --local -- long_flags
        set --local -- descriptions
        for switch in (output-format {$_flag_flag})
            set --local -- details (string split --max=2 -- ' | ' {$switch})
            set --local -- flags (string split --max=2 -- : {$details[1]})
            set --append -- descriptions {$details[2]}
            set --local -- short_flag {$flags[2]}
            if test -z {$short_flag}
                set --append -- short_flags (set_color brred)\~
            else
                set --append -- short_flags {$short_flag}
            end
            set --append -- long_flags {$flags[1]}
        end
        set --local -- largest_longFlag_len (largest-length {$long_flags})

        echo (string repeat 3 \ )(title (string pad --center --width={$largest_longFlag_len} long)) (title short)
        # print
        for i in (seq 1 (count {$_flag_flag}))
            echo \ (bullet •) (set_color --italics green)(string pad --center --width={$largest_longFlag_len} {$long_flags[$i]})\ (string pad --center --width=5 {$short_flags[$i]})(set_color normal) {$sep} (italicize-names {$pos_names} {$descriptions[$i]})
        end
    end
end
