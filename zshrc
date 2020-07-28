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

# Jira
jrw() {
    curl -s http://private.central-eks.aureacentral.com/pca-qe/api/review/$1 | json_pp
}

slugify() {
    echo "$1" | iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | sed -E 's/^-+//g' | sed -E 's/-+$//g' | tr A-Z a-z
}

# Dirs
c() { cd ~/Code/$1; }
_c() { _files -W ~/Code -/; }

unsetopt correct_all

# Projects
alias mitui="cd ~/Code/jive/jive-cdm-mitui-cloud/packages/service-chrome"
alias run-mitui="cd ~/Code/jive/jive-cdm-mitui-cloud/packages/service-chrome && npm run start"

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

# Homebrew
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

# Tools
export PATH="$PATH:$HOME/Tools"
export PATH="$PATH:$HOME/Tools/phantomjs-2.1.1-macosx/bin"
export PATH="$PATH:$HOME/Tools/apache-ant-1.7.0/bin"
export PATH="$PATH:$HOME/Tools/jboss-3.2.5/bin"
export PATH="$PATH:/Applications/DevSpaces.app/Contents/MacOS"

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
export SDKMAN_DIR="/Users/aurea/.sdkman"
[[ -s "/Users/aurea/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/aurea/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
