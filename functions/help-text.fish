function help-text --description='Generate help reference text'
    # parse arguments
    argparse 'h/help&' 'c/sub-command=+&' 'p/positional=+&' 'f/flag=+&' -- {$argv}

    if set --query --local -- _flag_help
        help-text 'Generate help reference text' https://github.com/Drazape/fish-helpText \
            --position='Description | The purpose of the command' \
            --flag={
                'positional:p | Individual positional arguments',
                'switch:s | Individual switches'
            }
        return
    end
    begin
        set -- arg_count (count {$argv})
        if test {$arg_count} -gt 2 || test {$arg_count} = 0
            echo (format text dim (status current-function) (format text color white ':')) expected (format text bold 1)(format text color white '/')(format text bold 2) 'positional arguments; got' (format text italics {$arg_count})
            return 1
        end
    end
    set --function -- command_description {$argv[1]}
    set --local --query argv[2] && set --function -- documentation_url {$argv[2]}
    set --local --erase -- argv

    # common stuff
    set --local -- sep \t(format text dim '│')

    # Output
    ## Description
    echo (format text color magenta --bright {$command_description})\n

    ## Arguments
    ### Sub-Command
    if set --query --local -- _flag_sub_command
        _help-text_heading Sub-Commands

        # data
        for subcommand in (_help-text_output-format {$_flag_sub_command})
            set --local -- details (string split --max=2 -- ' | ' {$subcommand})
            set --append --function -- arg_names {$details[1]}
            set --append --function -- descriptions {$details[2]}
        end
        set --local -- largest_name_len (_help-text_largest-length {$arg_names})

        for i in (seq 1 (count {$_flag_sub_command}))
            echo \ (_help-text_bullet •) (format text bold (format text color green (string pad --right --width={$largest_name_len} -- {$arg_names[$i]}))) {$sep} (_help-text_italicize-names {$arg_names} {$descriptions[$i]})
        end
    end
    ### Positional
    if set --query --local -- _flag_positional
        _help-text_heading Positionals

        # data
        set --function -- varpos_index 0
        set --function -- none_index -1
        for positional_argument in (_help-text_output-format {$_flag_positional})
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
            set --append --function -- arg_names {$pos_details}
        end
        set --local -- largest_name_len (_help-text_largest-length {$arg_names})

        # print
        set --local -- subtract_none 0
        set --local -- varpos_left
        for i in (seq 1 (count {$_flag_positional}))
            if test {$none_index} -eq {$i}
                echo -n \ (_help-text_bullet -)
                set -- subtract_none 1
            else if test {$varpos_index} -eq 0
                echo -n \ (_help-text_bullet (math {$i} - {$subtract_none}).)
            else if test {$i} -eq {$varpos_index}
                echo -n \ (_help-text_bullet +)
                set --local --erase varpos_left
            else if set --query --local -- varpos_left
                echo -n \ (_help-text_bullet (math {$i} - {$subtract_none}))
            else
                echo -n (_help-text_bullet (math {$i} - (count {$arg_names}) - 1))
            end
            echo \ (format text bold (format text color green (string pad --right --width={$largest_name_len} -- {$arg_names[$i]}))) {$sep} (_help-text_italicize-names {$arg_names} {$descriptions[$i]})
        end
    end

    ### Switches    
    if set --query --local -- _flag_flag
        _help-text_heading Flags

        # data
        set --local -- short_flags
        set --local -- long_flags
        set --local -- descriptions
        for switch in (_help-text_output-format {$_flag_flag})
            set --local -- details (string split --max=2 -- ' | ' {$switch})
            set --local -- flags (string split --max=2 -- : {$details[1]})
            set --append -- descriptions {$details[2]}
            set --local -- short_flag {$flags[2]}
            if test -z {$short_flag}
                set --append -- short_flags (format text color red --bright \~)
            else
                set --append -- short_flags {$short_flag}
            end
            set --append -- long_flags {$flags[1]}
        end
        set --local -- largest_longFlag_len (_help-text_largest-length {$long_flags})

        echo (string repeat 3 \ )(_help-text_title (string pad --center --width={$largest_longFlag_len} long)) (_help-text_title short)
        # print
        for i in (seq 1 (count {$_flag_flag}))
            echo \ (_help-text_bullet •) (format text italics (format text color green (string pad --center --width={$largest_longFlag_len} {$long_flags[$i]})\ (string pad --center --width=5 {$short_flags[$i]}))) {$sep} (_help-text_italicize-names {$arg_names} {$descriptions[$i]})
        end
    end

    ## Wiki
    set --query --function documentation_url && echo -e \n'\e]8;;'{$documentation_url}'\a'(format text color blue --bright 'wiki')'\e]8;;\a'
end
