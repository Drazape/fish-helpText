function _help-text_internal_title --description='Create a title for subheads'
    echo (format text bold (
        format text color cyan (
            format line under --bright cyan "$argv")))
end
