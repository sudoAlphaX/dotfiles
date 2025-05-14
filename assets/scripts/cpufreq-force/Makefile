EXEC=cpufreq-force
PREFIX=/usr/local/bin

default: build_release

clean:
	@echo "--- Cleaning build dir ---"
	@rm -rf target/*
	@echo "--- Cleaning using cargo ---"
	@cargo clean

check:
	@echo "--- Checking ---"
	@cargo check

build_release:
	@echo "--- Building release ---"
	@cargo build --release

build_debug:
	@echo "--- Building debug ---"
	@cargo build

run:
	@echo "--- Running debug ---"
	@cargo run

install: build_release
	@echo "--- Installing release ---"
	sudo install -o root -g root -s -m 4755 ./target/release/$(EXEC) $(PREFIX)/.
