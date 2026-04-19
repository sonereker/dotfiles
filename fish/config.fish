# ============================================================
# Shell behavior
# ============================================================
set -g fish_greeting ""                          # silence the welcome banner

# fish_features must be -U (universal) because fish reads it before parsing
# config.fish on the next shell. Skip the write if it's already set so we
# don't churn the universal store on every shell start.
set -q fish_features; or set -U fish_features completion_insensitive qmark-noglob

set -g HISTSIZE 1000000                          # in-memory history cap
set -g SAVEHIST 1000000                          # on-disk history cap

ulimit -n 200000                                 # raise open-file limit (Node/Go builds need it)
ulimit -u 2048                                   # raise per-user process limit

# ============================================================
# PATH
# Use fish_add_path exclusively. Do NOT also use `set -gx PATH ...`
# (it shadows fish_user_paths and creates duplicates).
# `-g` = global to this session (not persisted in fish_user_paths)
# so the repo is the single source of truth across machines.
# ============================================================
fish_add_path -g $HOME/bin
fish_add_path -g $HOME/.local/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g (go env GOPATH)/bin                          # Go-installed binaries
fish_add_path -g $HOME/.yarn/bin                              # Yarn global bin

# ============================================================
# Environment
# ============================================================
set -gx GOPATH           $HOME/go
set -gx TYPST_FONT_PATHS "$HOME/Library/Application Support/Adobe/CoreSync/plugins/livetype/.r"

# fzf: use fd for fast indexing, bat for file previews
set -gx FZF_FIND_FILE_COMMAND      "fd --type f --hidden --exclude .git"
set -gx FZF_CD_COMMAND             "fd --type d --exclude .git"
set -gx FZF_CD_WITH_HIDDEN_COMMAND "fd --type d --hidden --exclude .git"
set -gx FZF_OPEN_COMMAND           "fd --type f --hidden --exclude .git"
set -gx FZF_FIND_FILE_OPTS         "--preview 'bat --color=always --line-range=:200 {}'"
set -gx FZF_OPEN_OPTS              "--preview 'bat --color=always --line-range=:200 {}'"

# ============================================================
# Prompt / theme
# ============================================================
set -g theme_color_scheme         terminal-dark
set -g theme_display_user         no
set -g theme_hide_hostname        yes
set -g theme_hostname             never
set -g fish_prompt_pwd_dir_length 1                # collapse parent dirs to 1 char in prompt

# ============================================================
# Aliases
# ============================================================
alias g  git
alias ls "eza --color=always --long --hyperlink --git --git-repos --no-user --no-permissions"
alias la "ls -a"

# Abbreviations — expand inline on space/enter so the full command is visible
# before it runs (safer for destructive kamal ops; keeps history readable).
abbr -a kd   kamal deploy
abbr -a kl   kamal app logs
abbr -a klf  kamal app logs -f
abbr -a ke   kamal app exec -i --reuse
abbr -a ks   kamal app shell
abbr -a kab  kamal accessory boot
abbr -a kse  kamal server exec
abbr -a kc   kamal config
abbr -a ys   yarn serve
abbr -a yd   yarn dev
abbr -a mw   make watch
abbr -a ng   ngrok http 3000

# ============================================================
# Folder access  (functions defined in functions/code.fish)
#   code           -> fzf picker over ~/Code/*
#   code <name>    -> cd ~/Code/<name>
#   z <query>      -> jump to any previously-visited dir (zoxide)
# ============================================================

# ============================================================
# Tools
# ============================================================
zoxide init fish | source                          # `z <query>` smart cd
command -q mise && mise activate fish | source     # polyglot runtime mgr (Node/Go/Ruby/Python)

# ============================================================
# Local-only overrides (secrets, machine-specific env)
# This file is gitignored. See README.md.
# ============================================================
set -l LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
test -f $LOCAL_CONFIG && source $LOCAL_CONFIG
