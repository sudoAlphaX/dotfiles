HOME_DIR = $(HOME)
STOW_CONFIG_NO_DIRS := btop fastanime musikcube obs-studio tmux trackma vesktop viu
STOW_NO_DIRS := dot-local/bin dot-local/share/spotdl
COPY_NO_STOW := dot-shortcuts

VERBOSITY ?= 0
export VERBOSITY

V_FLAG := $(shell [ $(VERBOSITY) -gt 0 ] && echo "-v" || echo "")

# Targets

help:
	@echo "--- Available targets ---"; \
	echo "help: Show this help message"; \
	echo "install: Install configs"; \
	echo "--- Install targets ---"; \
	echo "stow: Stow dotfiles"; \
	echo "copy-stow: Copy directories that cannot be stowed"; \
	echo "scripts: Install scripts"; \
	echo "setup: Run various setup related commands"; \
	echo "--- Get targets end ---"; \
	echo "update: Update git submodules and neovim plugins"; \
	echo "--- Update targets ---"; \
	echo "update-submodules: Update git submodules"; \
	echo "update-nvim: Update neovim plugins"; \
	echo "update-tmux: Update tmux plugins"; \
	echo "--- Update targets end ---"; \

install: stow copy-stow
	@echo "Run make setup after reloading environment"

update: update-submodules update-nvim update-tmux

setup:
	@echo "--- Running user setup commands ---"
	git config --local core.hooksPath .githooks/
	bat cache --build
	tldr --update
	nvim --headless '+Lazy! restore' +qa
	$(HOME)/.config/tmux/tpm/bin/install_plugins

stow:
	@echo "--- Stowing dotfiles ---"
	@for dir in $(STOW_CONFIG_NO_DIRS); do \
		dir=$$(echo $$dir | sed 's/dot-/\./'); \
		mkdir -p $(V_FLAG) $(HOME_DIR)/.config/$$dir; \
		touch $(HOME_DIR)/.config/$$dir/.tmp; \
	done
	@for dir in $(STOW_NO_DIRS); do \
		dir=$$(echo $$dir | sed 's/dot-/\./'); \
		mkdir -p $(V_FLAG) $(HOME_DIR)/$$dir; \
		touch $(HOME_DIR)/$$dir/.tmp; \
	done
	stow --target=$(HOME) --dir=. --dotfiles --verbose=$(VERBOSITY) .
	@for dir in $(STOW_CONFIG_NO_DIRS); do \
		dir=$$(echo $$dir | sed 's/dot-/\./'); \
		rm -f $(V_FLAG) $(HOME_DIR)/.config/$$dir/.tmp; \
	done
	@for dir in $(STOW_NO_DIRS); do \
		dir=$$(echo $$dir | sed 's/dot-/\./'); \
		rm -f $(V_FLAG) $(HOME_DIR)/$$dir/.tmp; \
	done

stow-copy:
	@echo "--- Copying stow directories ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(COPY_NO_STOW); do \
		mkdir -p $$V_FLAG $(HOME_DIR)/$$(echo $$dir | sed 's/dot-/\./'); \
		cp -T --recursive $$V_FLAG $$dir $(HOME_DIR)/$$(echo $$dir | sed 's/dot-/\./')/; \
	done

update-submodules:
	@echo "--- Updating git submodules ---"
	cd ~/.dotfiles && git submodule foreach '(git checkout main || git checkout master) && git pull'

update-nvim:
	@echo "--- Updating neovim plugins ---"
	nvim --headless '+Lazy! sync' +qa
	@git commit ./dot-config/$${NVIM_APPNAME:-nvim}/lazy-lock.json -m "$$(echo $${NVIM_APPNAME:-nvim} | sed 's/^nvim-//'): update plugins" || echo "No changes to commit for nvim plugins"

update-tmux:
	@echo "--- Updating tmux plugins ---"
	$(HOME)/.config/tmux/tpm/bin/update_plugins all

.PHONY: all stow copy-stow update update-submodules update-nvim update-tmux setup help
