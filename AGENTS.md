# AGENTS.md

Notes for anyone (or any agent) changing this repo.

## Layout

- `Makefile` `sync` symlinks **fish/** (whole dir), **gitconfig**, **ghostty/config**, and **zed/{settings,keymap}.json** into place. Idempotent.
- `fish/config.fish` is heavily commented on purpose — keep it that way.
- `fish/config-local.fish` holds secrets, is auto-sourced, gitignored. Keep `config-local.fish.example` in sync when adding/removing vars.
- Fish plugin files (fisher, nvm.fish, fzf) are gitignored — `fisher update` re-installs them.

## Bootstrap order

1. `make` — runs `deps` (`brew bundle` + `gem install kamal`) then `sync` (symlinks)
2. Bootstrap fisher → `fisher update`
3. Fill in `~/.config/fish/config-local.fish`

## Gotchas

- **PATH:** use `fish_add_path -g` only, never `set -gx PATH ...` or `-U`.
- **Brewfile:** `kamal` is a gem (not brew). `ngrok` is a cask via `ngrok/ngrok` tap. `nvm` lives as the fish plugin — don't add brew nvm.
- **Ghostty** reads both `~/.config/ghostty/config` (the symlink) and `~/Library/Application Support/com.mitchellh.ghostty/config`. Delete the macOS-path one to avoid drift.
