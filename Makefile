DOTFILES := $(PWD)
BREW_GEM := /opt/homebrew/opt/ruby/bin/gem

all: deps sync plugins

deps: ## Install Brewfile packages and required gems
	brew bundle --file=$(DOTFILES)/Brewfile
	# Use brew Ruby explicitly so this works regardless of caller PATH.
	$(BREW_GEM) list -i kamal >/dev/null 2>&1 || $(BREW_GEM) install kamal

sync: ## Symlink configs into ~/.config and ~ (idempotent)
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

plugins: ## Install/refresh fish plugins declared in fish/fish_plugins
	fish -c 'fisher update'

update: ## Refresh brew packages + fish plugins
	brew bundle --file=$(DOTFILES)/Brewfile
	fish -c 'fisher update'

clean: ## Remove all symlinks created by sync
	[ ! -L ~/.config/fish ]              || rm ~/.config/fish
	[ ! -L ~/.gitconfig ]                || rm ~/.gitconfig
	[ ! -L ~/.config/ghostty/config ]    || rm ~/.config/ghostty/config
	[ ! -L ~/.config/zed/settings.json ] || rm ~/.config/zed/settings.json
	[ ! -L ~/.config/zed/keymap.json ]   || rm ~/.config/zed/keymap.json

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

.PHONY: all deps sync plugins update clean help
