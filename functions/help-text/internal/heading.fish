function _help-text_internal_heading --description='Create headings for headers'
    echo (set_color --bold --underline{,-color=brblue} blue)"$argv"(set_color --reset brblue):(set_color --reset)
end
