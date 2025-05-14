EXEC=cpufreq-force
PREFIX=/usr/local/bin
VERBOSITY ?= 0

default: build_release

clean:
	@echo "--- Cleaning build dir ---"
	@rm -rf target/*
	@echo "--- Cleaning using cargo ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	cargo clean $$V_FLAG

check:
	@echo "--- Checking ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	cargo check $$V_FLAG

build_release:
	@echo "--- Building release ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	cargo build --release $$V_FLAG

build_debug:
	@echo "--- Building debug ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	cargo build $$V_FLAG

run:
	@echo "--- Running debug ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	cargo run $$V_FLAG

install: build_release
	@echo "--- Installing release ---"
	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
	sudo install $$V_FLAG -o root -g root -s -m 4755 ./target/release/$(EXEC) $(PREFIX)/.
