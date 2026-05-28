function _help-text_output-format --description='Slightly dim punctuation'
    string trim -- {$argv} | string replace -- \; (_help-text_output-format_slight-dim \;) | string replace -- , (_help-text_output-format_slight-dim ,) | string replace -- . (_help-text_output-format_slight-dim .)
end
