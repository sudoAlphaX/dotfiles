
HOME_DIR = $(HOME)
VERBOSITY ?= 0
STOW_IGNORE_DIRS := fastanime tmux trackma

<<<<<<< HEAD
all: stow
=======

# Targets

all: stow etc usr scripts

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
	@nvim --headless '+Lazy! update' +qa

.PHONY: all stow update update-submodules update-nvim help
