DOTFILES := $(PWD)

all: deps sync

deps:
	brew bundle --file=$(DOTFILES)/Brewfile
	gem list -i kamal >/dev/null 2>&1 || gem install kamal

sync:
	mkdir -p ~/.config/ghostty ~/.config/zed

	[ -e ~/.config/fish ]              || ln -s $(DOTFILES)/fish              ~/.config/fish
	[ -e ~/.gitconfig ]                || ln -s $(DOTFILES)/gitconfig         ~/.gitconfig
	[ -e ~/.config/ghostty/config ]    || ln -s $(DOTFILES)/ghostty/config    ~/.config/ghostty/config
	[ -e ~/.config/zed/settings.json ] || ln -s $(DOTFILES)/zed/settings.json ~/.config/zed/settings.json
	[ -e ~/.config/zed/keymap.json ]   || ln -s $(DOTFILES)/zed/keymap.json   ~/.config/zed/keymap.json

	# Seed config-local.fish from the example if it doesn't exist yet.
	[ -e ~/.config/fish/config-local.fish ] || cp $(DOTFILES)/fish/config-local.fish.example ~/.config/fish/config-local.fish

	# Don't show "last login" message on shell startup.
	touch ~/.hushlogin

	@echo ""
	@echo "  Done. Next:"
	@echo "    1. fish -c 'fisher update'"
	@echo "    2. Fill in secrets at ~/.config/fish/config-local.fish"

clean:
	[ ! -L ~/.config/fish ]              || rm ~/.config/fish
	[ ! -L ~/.gitconfig ]                || rm ~/.gitconfig
	[ ! -L ~/.config/ghostty/config ]    || rm ~/.config/ghostty/config
	[ ! -L ~/.config/zed/settings.json ] || rm ~/.config/zed/settings.json
	[ ! -L ~/.config/zed/keymap.json ]   || rm ~/.config/zed/keymap.json

.PHONY: all deps sync clean
