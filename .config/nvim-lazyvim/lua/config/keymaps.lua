-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Easy enter commands
map("n", ";", ":")

-- Bufferline Tabs
map("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>")
map("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>")
unmap("n", "<leader>bd")

-- Buffers
map("n", "<leader>bn", "<CMD>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bx", "<CMD>bd<CR>", { desc = "Close Buffer" })
map("n", "<leader>bX", "<CMD>bd!<CR>", { desc = "Force Close Buffer" })
map("n", "<leader>bb", "<leader>fb", { remap = true, desc = "List Buffers" })

-- Find Files
map("n", "<leader> ", "<leader>ff", { remap = true, desc = "Find Files (Root Dir)" })
map("n", "<leader>o", "<leader>fF", { remap = true, desc = "Find Files (cwd)" })
map("n", "<leader>/", "<leader>sG", { remap = true, desc = "Grep (cwd)" })
map("n", "<leader>r", "<leader>fr", { remap = true, desc = "Recent files" })

-- Git
map("n", "<leader>gH", "<CMD>FzfLua git_stash<CR>", { desc = "Git Stashes" })

-- Indentation shortcuts
map("x", "<Tab>", ">gv")
map("x", "<S-Tab>", "<gv")

-- Registers (Clipboard History)
map("n", "<leader>p", '<leader>s"', { remap = true, desc = "Registers" })

map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- Copy +code from <leader>c to <leader>a
unmap("n", "<leader>l")
map({ "n", "v" }, "<leader>la", "<leader>ca", { remap = true, desc = "Code Action" })
map("n", "<leader>lR", "<leader>cR", { remap = true, desc = "Rename File" })
map("n", "<leader>lr", "<leader>cr", { remap = true, desc = "Rename Symbol" })
map("n", "<leader>lA", "<leader>cA", { remap = true, desc = "Source Action" })
map("n", "<leader>ll", "<leader>ca", { remap = true, desc = "Code Action" })
map("n", "<leader>lf", "<leader>cf", { remap = true, desc = "Format" })
map("n", "<leader>lF", "<leader>cF", { remap = true, desc = "Format Injected Langs" })
map("n", "<leader>ls", "<leader>cs", { remap = true, desc = "Symbols" })
map("n", "<leader>lS", "<leader>cS", { remap = true, desc = "LSP References/definitions/..." })

-- Terminal
map("n", "<leader>T", "<leader>ft", { remap = true, desc = "Terminal" })
map("n", "<leader>t", "<leader>fT", { remap = true, desc = "Terminal (cwd)" })

-- Zoom
map("n", "<leader>z", "<leader>uZ", { remap = true, desc = "Maximize" })

-- Select all
map("n", "<leader>as", "ggVG", { remap = true, desc = "Select All" })
