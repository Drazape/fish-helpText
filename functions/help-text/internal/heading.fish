function _help-text_internal_heading --description='Create headings for headers'
    echo \n(
        format text color blue (
            format line under --bright blue "$argv"
        ))(format text color --bright blue ':')
end
