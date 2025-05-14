
HOME_DIR = $(HOME)
VERBOSITY ?= 0
CONFIGS_DIR = ./assets/configs
export VERBOSITY
STOW_IGNORE_DIRS := btop fastanime musikcube obs-studio tmux trackma vesktop

all: stow

stow:
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

etc:
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@ /$@;

usr:
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@ /$@;

home:
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(shell ls /$@); do \
		sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@/user /home/$$dir; \
	done

.PHONY: all stow etc usr home
