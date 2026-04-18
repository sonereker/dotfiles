# dotfiles

## Bootstrap on a fresh Mac

1. Install [Homebrew](https://brew.sh)
2. `git clone git@github.com:sonereker/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles`
3. `make` — installs everything in `Brewfile`, `gem install kamal`, then symlinks fish/gitconfig/ghostty/zed
4. Fill in real secrets at `~/.config/fish/config-local.fish` (seeded from the `.example`)

To bump plugin versions later: `fish -c 'fisher update'`, then commit the diff.

See `AGENTS.md` for layout, conventions, and gotchas.
