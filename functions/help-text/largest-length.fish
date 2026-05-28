function _help-text_largest-length --description='Find the string with the largest length'
    set --function -- lengths (string length -- {$argv})
    set --function -- big {$lengths[1]}
    for length in {$lengths}
        test {$big} -lt {$length} && set --function -- big {$length}
    end
    echo {$big}
end
