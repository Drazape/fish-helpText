function _help-text_italicize-names --description='Return the last argument with all sub-strings that are the initial arguments capitalized'
    set --function italicized {$argv[-1]}
    for name in {$argv[1..-2]}
        set --function -- italicized (string replace -- {$name} (set_color --italics){$name}(set_color --reset) {$italicized})
    end
    echo {$italicized}
end
