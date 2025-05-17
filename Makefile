
HOME_DIR = $(HOME)
VERBOSITY ?= 0
STOW_IGNORE_DIRS := fastanime tmux trackma

# Targets

help:
	@echo "--- Available targets ---"; \
	echo "help: Show this help message"; \
	echo "install: Install configs"; \
	echo "--- Install targets ---"; \
	echo "stow: Stow dotfiles"; \
	echo "--- Get targets end ---"; \
	echo "update: Update git submodules and noevim plugins"; \
	echo "--- Update targets ---"; \
	echo "update-submodules: Update git submodules"; \
	echo "update-nvim: Update neovim plugins"; \
	echo "--- Update targets end ---"; \

install: stow
update: update-submodules update-nvim

stow:
	@echo "--- Stowing dotfiles ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_IGNORE_DIRS); do \
		mkdir -p $$V_FLAG $(HOME_DIR)/.config/$$dir; \
		touch $(HOME_DIR)/.config/$$dir/.tmp; \
	done
	stow --target=$(HOME) --dir=. --dotfiles --verbose=$(VERBOSITY) .
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_IGNORE_DIRS); do \
		rm -f $$V_FLAG $(HOME_DIR)/.config/$$dir/.tmp; \
	done

update-submodules:
	@echo "--- Updating git submodules ---"
	@cd ~/.dotfiles && git submodule foreach '(git checkout main || git checkout master) && git pull'

update-nvim:
	@echo "--- Updating neovim plugins ---"
	@nvim --headless '+Lazy! sync' +qa
	@git commit ./.config/$${NVIM_APPNAME:-nvim}/lazy-lock.json -m "$$(echo $${NVIM_APPNAME:-nvim} | sed 's/^nvim-//'): update plugins"

.PHONY: all stow update update-submodules update-nvim help
