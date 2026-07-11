#!/usr/bin/env fish
if test (count {$argv}) -ge 1
    set --function -- root_dir {$argv[1]}/
else
    set --function -- remote usr/local/
end

# get from the remote GitHub repository
if set --query --local -- remote
    if ! fish_is_root_user
        echo (status basename): 'Must be ran as root'
        return 1
    end
    # Setup Cleanup
    function cleanup_temporary_repository --description='Nuke temporary repository on exit' --on-event=fish_exit
        rm -rf -- {$repository_dir}
    end

    begin
        set --local proj_name fish-helpText
        # Clone repository to temporary directory
        set --global -- repository_dir (mktemp -- {$proj_name}-XXXXXXXXX)
        git $clone_repo --filter=blob:none https://github.com/Drazape/ {$proj_name}.git "$repository_dir" || return 2
        cd {$repository_dir}
    end
end

# Populate
function install-components --description='Install a component of the program' --inherit-variable=root_dir
    set --local -- source_dir {$argv[1]}
    set --local -- vendor_dir {$argv[2]}
    for source in "$root_dir"{$source_dir}/**.fish
        set --local -- output_path {$source} # Same output path in case of no root directory
        set --query --local -- root_dir && set --local -- output_path (string split --fields=2 --max=1 -- "$root_dir" {$source}) # Remove root directory from the output path
        install -D --mode=644 -- {$source} "$out"/"$remote"share/fish/vendor_{$vendor_dir}.d/(string split --fields=2 --max=1 -- {$source_dir} {$output_path})
    end
end

install-components functions{,}
install-components completions{,}
