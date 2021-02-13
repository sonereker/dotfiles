# -----------------------------------------
# PLUGINS
# -----------------------------------------

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Override highlighter colors
ZSH_HIGHLIGHT_STYLES[main]=none

# -----------------------------------------
# AUTO COMPLETE
# -----------------------------------------

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Autocompletion with an arrow-key driven interface
zstyle ':completion:*:*:*:*:*' menu select

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

# -----------------------------------------
# ALIAS
# -----------------------------------------

alias ..='cd ..'

# Conf
alias hosts="sudo code /etc/hosts"
alias nginx-conf="sudo code /usr/local/etc/nginx/nginx.conf"

# Git
alias gl="git pull"
alias gc="git commit"
alias gce="git commit --allow-empty -m \"Trigger Build\""

# Docker
alias dil="docker image ls -a"
alias dip="docker image prune -a"
alias dcl="docker container ls -a"

# Dirs
c() { cd ~/Code/$1; }
_c() { _files -W ~/Code -/; }

unsetopt correct_all

# Quick Nav
setopt autocd autopushd

# -----------------------------------------
# PROMPT
# -----------------------------------------

set -g default-terminal "screen-256color"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '• (%b) '
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='/%1d ${vcs_info_msg_0_}#: '

ZSH_DISABLE_COMPFIX=true

# -----------------------------------------
# HISTORY
# -----------------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# History Search -/
# - Place the cursor at the end of the line once you have selected your desired command
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# -----------------------------------------
# EXPORT
# -----------------------------------------

# OpenSSL
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# SDKMAN - THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="~/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
