#!/usr/bin/env fish
# Only allow execution as root
if ! fish_is_root_user
    echo (status basename)': Must be ran as root'
    return 1
end

# Setup Cleanup
function cleanup_temporary_repository --description='Nuke temporary repository on exit' --on-event=fish_exit
    rm -rf -- {$repository_dir}
end

begin
    set --local proj_name fish-subAbbr
    # Clone repository to temporary directory
    set --global -- repository_dir {$proj_name}-'XXXXXXXXX'
    begin
        set --local clone_repo clone --filter=blob:none https://github.com/Drazape/{$proj_name}.git "$repository_dir"
        git $clone_repo || nix run nixpkgs#git $clone_repo || return 2
    end
    cd {$repository_dir}
end

# Operate
function install-component --description='Install a component of the program' --argument-names={file,installDir}
    install -D --mode=644 -- {$file} {$installDir}/help-text.fish
end
install-component functions /usr/local/share/fish/vendor_functions.d # Functions
install-component completions /usr/local/share/fish/vendor_completions.d # Completions
