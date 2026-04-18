# dotfiles

## Bootstrap on a fresh Mac

1. Install [Homebrew](https://brew.sh)
2. `git clone git@github.com:sonereker/dotfiles.git ~/Code/dotfiles && cd ~/Code/dotfiles`
3. `make` — installs Brewfile + `gem install kamal`, symlinks fish/gitconfig/ghostty/zed, runs `fisher update` to fetch fish plugins
4. Fill in real secrets at `~/.config/fish/config-local.fish` (seeded from the `.example`)

See `AGENTS.md` for layout, conventions, and gotchas.
