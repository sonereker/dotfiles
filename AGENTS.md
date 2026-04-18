# AGENTS.md

Notes for anyone (or any agent) changing this repo.

## Layout

- `Makefile` `sync` symlinks **fish/** (whole dir), **gitconfig**, **ghostty/config**, and **zed/{settings,keymap}.json** into place. Idempotent. Run `make help` for all targets.
- `fish/config.fish` is heavily commented on purpose — keep it that way.
- `fish/config-local.fish` holds secrets, is auto-sourced, gitignored. The committed `.example` is a generic template (no real var names).
- Fish plugin files for nvm.fish + fzf are gitignored — `make plugins` (or full `make`) runs `fisher update` to fetch them. **fisher itself is committed** (`fish/functions/fisher.fish`, `fish/completions/fisher.fish`) so `make` doesn't need a curl bootstrap.

## Bootstrap order

1. `make` — runs `deps` (`brew bundle` + `gem install kamal` via brew Ruby), `sync` (symlinks), `plugins` (fisher update)
2. Fill in `~/.config/fish/config-local.fish`

To refresh later: `make update`.

## What's in fish/config.fish

- Aliases: `g` → git, `ls` → eza (with git/long flags), `la` → ls -a, `kd` → kamal deploy, `ys/yd` → yarn serve/dev, `mw` → make watch, `ng` → ngrok http 3000.
- `code` function: bare `code` opens fzf over `~/Code/*`; `code <name>` cds; `code <TAB>` completes.
- `z <fragment>` jumps to any previously-visited dir (zoxide).

## Gotchas

- **Apple Silicon only**: paths assume `/opt/homebrew` (not `/usr/local`). For Intel Mac, change the prefix in `Makefile` (`BREW_GEM`) and `fish/config.fish` (PATH).
- **PATH**: use `fish_add_path -g` only, never `set -gx PATH ...` or `-U`.
- **Brewfile**: `kamal` is a gem (not brew). `ngrok` is a cask via `ngrok/ngrok` tap. `nvm` lives as the fish plugin — don't add brew nvm.
- **Ghostty** reads both `~/.config/ghostty/config` (the symlink) and `~/Library/Application Support/com.mitchellh.ghostty/config`. Delete the macOS-path one to avoid drift.
