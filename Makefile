# Variables
HOME_DIR = $(HOME)
STOW_IGNORE_DIRS := btop fastanime musikcube obs-studio tmux trackma vesktop
CONFIGS_DIR = ./assets/configs
SCRIPTS_DIR = ./assets/scripts

VERBOSITY ?= 0
export VERBOSITY


# Targets

all: stow etc usr home scripts

get: get-etc get-usr

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

etc:
	@echo "--- Installing etc configs ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@ /$@;

usr:
	@echo "--- Installing usr configs ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@ /$@;

home:
	@echo "--- Installing home configs ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(shell ls /$@); do \
		sudo cp -T --recursive $$V_FLAG $(CONFIGS_DIR)/$@/user /home/$$dir; \
	done

scripts:
	@echo "--- Installing scripts ---"
	@for script in $(shell ls $(SCRIPTS_DIR)); do \
		echo "--- Installing $$script ---"; \
		$(MAKE) -e -C $(SCRIPTS_DIR)/$$script install; \
	done

get-etc:
	@echo "--- Overwriting tracked $(subst get-,,$@) configs with system $(subst get-,,$@) configs ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	find $(CONFIGS_DIR)/$(subst get-,,$@) -type f | while read -r line; do \
		cp $$V_FLAG "$$(echo "$$line" | sed 's/^\.\/assets\/configs\/$(subst get-,,$@)\//\/$(subst get-,,$@)\//')" "$$line"; \
	done

get-usr:
	@echo "--- Overwriting tracked $(subst get-,,$@) configs with system $(subst get-,,$@) configs ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	find $(CONFIGS_DIR)/$(subst get-,,$@) -type f | while read -r line; do \
		cp $$V_FLAG "$$(echo "$$line" | sed 's/^\.\/assets\/configs\/$(subst get-,,$@)\//\/$(subst get-,,$@)\//')" "$$line"; \
	done

.PHONY: all stow etc usr home scripts
