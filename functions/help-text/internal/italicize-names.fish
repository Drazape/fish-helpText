function _help-text_internal_italicize-names --description='First take the Initial Arguments, then use them as the sub-strings to italicize in the full string (last argument)'
    set --function -- italicized {$argv[-1]}
    for name in {$argv[1..-2]}
        set --function -- italicized (string replace -- {$name} (format text italics {$name}) {$italicized})
    end
    echo {$italicized}
end
