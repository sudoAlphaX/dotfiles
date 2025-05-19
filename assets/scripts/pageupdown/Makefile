EXEC=pageupdown
PREFIX=/usr/local/bin
VERBOSITY ?= 0

CC=gcc
SRC=pageupdown.c
CFLAGS_COMMON=-Wall
CFLAGS_RELEASE=-O2 $(CFLAGS_COMMON)
CFLAGS_DEBUG=-g $(CFLAGS_COMMON)
LDFLAGS=

# Executable names
EXEC_RELEASE=$(EXEC)
EXEC_DEBUG=$(EXEC)_debug

.PHONY: default clean check build_release build_debug run install

default: build_release

clean:
	@echo "--- Cleaning build artifacts ---"
	@rm -f $(EXEC_RELEASE) $(EXEC_DEBUG) *.o
	@echo "--- Clean complete ---"

check:
	@echo "--- Checking source code (compile check) ---"
	@$(CC) $(CFLAGS_DEBUG) -c $(SRC) -o /dev/null $(LDFLAGS)
	@echo "--- Check complete ---"

build_release: $(SRC)
	@echo "--- Building release: $(EXEC_RELEASE) ---"
	@$(CC) $(CFLAGS_RELEASE) $(SRC) -o $(EXEC_RELEASE) $(LDFLAGS)
	@echo "--- Build release complete ---"

build_debug: $(SRC)
	@echo "--- Building debug: $(EXEC_DEBUG) ---"
	@$(CC) $(CFLAGS_DEBUG) $(SRC) -o $(EXEC_DEBUG) $(LDFLAGS)
	@echo "--- Build debug complete ---"

run: build_debug
	@echo "--- Running debug: ./$(EXEC_DEBUG) ---"
	@./$(EXEC_DEBUG)

# install: build_release
# 	@echo "--- Installing release: $(EXEC_RELEASE) to $(PREFIX)/$(EXEC) ---"
# 	@V_FLAG=$$([ $(VERBOSITY) -gt 0 ] && echo "-v" || echo ""); \
# 	sudo cp $$V_FLAG $(EXEC_RELEASE) $(PREFIX)/$(EXEC)
# 	@echo "--- Installation complete ---"
