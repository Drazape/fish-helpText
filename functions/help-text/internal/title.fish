function _help-text_internal_title --description='Create a title for subheads'
    echo (set_color --underline{,-color=brcyan} --bold cyan)"$argv"(set_color --reset)
end
