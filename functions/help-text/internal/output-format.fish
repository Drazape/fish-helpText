function _help-text_internal_output-format --description='Slightly dim punctuation'
    string trim -- {$argv} | string replace -- \; (_help-text_internal_output-format_slight-dim \;) | string replace -- , (_help-text_internal_output-format_slight-dim ,) | string replace -- . (_help-text_internal_output-format_slight-dim .)
end
