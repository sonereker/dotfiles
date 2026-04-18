function code --description "cd to a repo under ~/Code (fzf picker if no arg)"
    if test (count $argv) -eq 0
        set -l choice (ls -1 ~/Code | fzf --height 40% --prompt "code> ")
        test -n "$choice"; and cd ~/Code/$choice
    else
        cd ~/Code/$argv
    end
end
