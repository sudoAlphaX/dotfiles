# Variables
HOME_DIR = $(HOME)
STOW_CONFIG_NO_DIRS := btop fastanime musikcube obs-studio tmux trackma vesktop
STOW_NO_DIRS := .local/bin .local/share/applications .local/share/spotdl
CONFIGS_DIR = ./assets/configs
SCRIPTS_DIR = ./assets/scripts

VERBOSITY ?= 0
export VERBOSITY


# Targets

help:
	@echo "--- Available targets ---"; \
	echo "help: Show this help message"; \
	echo "install: Install configs"; \
	echo "--- Install targets ---"; \
	echo "stow: Stow dotfiles"; \
	echo "etc: Install etc configs"; \
	echo "usr: Install usr configs"; \
	echo "scripts: Install scripts"; \
	echo "--- Install targets end ---"; \
	echo "get: Get system configs"; \
	echo "--- Get targets ---"; \
	echo "get-etc: Get system etc configs"; \
	echo "get-usr: Get system usr configs"; \
	echo "--- Get targets end ---"; \
	echo "update: Update git submodules and noevim plugins"; \
	echo "--- Update targets ---"; \
	echo "update-submodules: Update git submodules"; \
	echo "update-nvim: Update neovim plugins"; \
	echo "--- Update targets end ---"; \
	echo "home: Install home configs"

install: stow etc usr scripts

get: get-etc get-usr

update: update-submodules update-nvim

stow:
	@echo "--- Stowing dotfiles ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_CONFIG_NO_DIRS); do \
		mkdir -p $$V_FLAG $(HOME_DIR)/.config/$$dir; \
		touch $(HOME_DIR)/.config/$$dir/.tmp; \
	done; \
	for dir in $(STOW_NO_DIRS); do \
		mkdir -p $$V_FLAG $(HOME_DIR)/$$dir; \
		touch $(HOME_DIR)/$$dir/.tmp; \
	done ; \
	stow --target=$(HOME) --dir=. --dotfiles --verbose=$(VERBOSITY) .
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	for dir in $(STOW_CONFIG_NO_DIRS); do \
		rm -f $$V_FLAG $(HOME_DIR)/.config/$$dir/.tmp; \
	done; \
	for dir in $(STOW_NO_DIRS); do \
		rm -f $$V_FLAG $(HOME_DIR)/$$dir/.tmp; \
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

update-submodules:
	@echo "--- Updating git submodules ---"
	@cd ~/.dotfiles && git submodule foreach '(git checkout main || git checkout master) && git pull'

update-nvim:
	@echo "--- Updating neovim plugins ---"
	@nvim --headless '+Lazy! sync' +qa
	@git commit ./.config/$${NVIM_APPNAME:-nvim}/lazy-lock.json -m "$$(echo $${NVIM_APPNAME:-nvim} | sed 's/^nvim-//'): update plugins"

.PHONY: all stow etc usr home scripts update update-submodules update-nvim help
