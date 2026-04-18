# dotfiles

## Bootstrap on a fresh Mac

1. Install [Homebrew](https://brew.sh)
2. `git clone git@github.com:sonereker/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles`
3. `make` — installs everything in `Brewfile`, `gem install kamal`, then symlinks fish/gitconfig/ghostty/zed
4. Bootstrap fisher and install fish plugins:
   ```fish
   curl -sSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
   fisher install jorgebucaran/fisher
   fisher update
   ```
5. Fill in real secrets at `~/.config/fish/config-local.fish` (seeded from the `.example`)

See `AGENTS.md` for layout, conventions, and gotchas.
