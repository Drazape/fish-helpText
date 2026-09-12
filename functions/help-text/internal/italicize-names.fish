    set --function italicized {$argv[-1]}
function _help-text_internal_italicize-names --description='First take the Initial Arguments, then use them as the sub-strings to italicize in the full string (last argument)'
    for name in {$argv[1..-2]}
        set --function -- italicized (string replace -- {$name} (set_color --italics){$name}(set_color --reset) {$italicized})
    end
    echo {$italicized}
end
