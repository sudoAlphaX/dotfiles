
HOME_DIR = $(HOME)
VERBOSITY ?= 0
STOW_IGNORE_DIRS := fastanime tmux trackma

all: stow

stow:
	@echo "--- Stowing dotfiles ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_IGNORE_DIRS); do \
		mkdir -p $$V_FLAG $(HOME_DIR)/$$dir; \
		touch $(HOME_DIR)/$$dir/.tmp; \
	done
	stow --target=$(HOME) --dir=. --dotfiles --verbose=$(VERBOSITY) .
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_IGNORE_DIRS); do \
		rm -f $$V_FLAG $(HOME_DIR)/$$dir/.tmp; \
	done

.PHONY: all stow
