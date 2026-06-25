function _fish-helpText_uninstall --on-event=fish-helpText_uninstall --description='Remove all sub-functions'
    rm ~/.config/fish/functions/_help-text_*.fish
end

function _fish-helpText_install --on-event=fish-helpText_install --description='Correct sub-function file-names'
    fisher install Drazape/fish-format

    cd ~/.config/fish/functions/
    for file in help-text/**.fish
        mv {$file} _(string replace --all -- / _ {$file})
    end
    rm -r ./help-text/
    prevd
end

function _fish-helpText_update --on-event=fish-helpText_update --description='Update dependency: fish-helpText'
    _fish-helpText_uninstall
    _fish-helpText_install
end
