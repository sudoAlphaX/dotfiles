# Variables
HOME_DIR = $(HOME)
STOW_CONFIG_NO_DIRS := btop fastanime tmux
STOW_NO_DIRS := dot-local/bin dot-local/share/applications dot-local/share/spotdl
CONFIGS_DIR = ./assets/configs
SCRIPTS_DIR = ./assets/scripts

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
	echo "scripts: Install scripts"; \
	echo "etc: Install etc configs"; \
	echo "usr: Install usr configs"; \
	echo "home: Install home configs"; \
	echo "--- Install targets end ---"; \
	echo "setup: Run user-specific setup commands"; \
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

install: stow scripts etc usr home
	@echo "Run make setup after reloading environment"

get: get-etc get-usr

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

etc:
	@echo "--- Installing etc configs ---"
	@find $(CONFIGS_DIR)/$@ -type f ! -executable | while read -r file; do \
		sudo install $(V_FLAG) -D --owner root --group root -m 644 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
	done
	@find $(CONFIGS_DIR)/$@ -type f -executable | while read -r file; do \
		sudo install $(V_FLAG) -D --owner root --group root -m 755 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
	done

usr:
	@echo "--- Installing usr configs ---"
	@find $(CONFIGS_DIR)/$@ -type f ! -executable | while read -r file; do \
		sudo install $(V_FLAG) -D --owner root --group root -m 644 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
	done
	@find $(CONFIGS_DIR)/$@ -type f -executable | while read -r file; do \
		sudo install $(V_FLAG) -D --owner root --group root -m 755 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
	done

home:
	@echo "--- Installing home configs ---"
	@for user in $(shell ls /$@); do \
		find $(CONFIGS_DIR)/$@ -type f ! -executable | while read -r file; do \
			sudo install $(V_FLAG) -D --owner $$user --group $$user -m 644 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
		done; \
		find $(CONFIGS_DIR)/$@ -type f -executable | while read -r file; do \
			sudo install $(V_FLAG) -D --owner $$user --group $$user -m 755 $$file $$(echo $$file | sed 's/$(subst /,\/,$(CONFIGS_DIR))//g'); \
		done; \
	done

scripts:
	@echo "--- Installing scripts ---"
	@for script in $(shell ls $(SCRIPTS_DIR)); do \
		echo "--- Installing $$script ---"; \
		$(MAKE) -e -C $(SCRIPTS_DIR)/$$script install; \
	done

get-etc:
	@echo "--- Overwriting tracked $(subst get-,,$@) configs with system $(subst get-,,$@) configs ---"
	@find $(CONFIGS_DIR)/$(subst get-,,$@) -type f | while read -r line; do \
		cp $(V_FLAG) "$$(echo "$$line" | sed 's/^\.\/assets\/configs\/$(subst get-,,$@)\//\/$(subst get-,,$@)\//')" "$$line"; \
	done

get-usr:
	@echo "--- Overwriting tracked $(subst get-,,$@) configs with system $(subst get-,,$@) configs ---"
	@find $(CONFIGS_DIR)/$(subst get-,,$@) -type f | while read -r line; do \
		cp $(V_FLAG) "$$(echo "$$line" | sed 's/^\.\/assets\/configs\/$(subst get-,,$@)\//\/$(subst get-,,$@)\//')" "$$line"; \
	done

update-submodules:
	@echo "--- Updating git submodules ---"
	cd ~/.dotfiles && git submodule foreach 'git pull'

update-nvim:
	@echo "--- Updating neovim plugins ---"
	nvim --headless '+Lazy! sync' +qa
	@git commit ./dot-config/$${NVIM_APPNAME:-nvim}/lazy-lock.json -m "$$(echo $${NVIM_APPNAME:-nvim} | sed 's/^nvim-//'): update plugins" || echo "No changes to commit for nvim plugins"

update-tmux:
	@echo "--- Updating tmux plugins ---"
	$(HOME)/.config/tmux/tpm/bin/update_plugins all

.PHONY: all stow etc usr home scripts update update-submodules update-nvim update-tmux help setup
