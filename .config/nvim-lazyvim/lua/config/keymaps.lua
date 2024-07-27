-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

-- Bufferline Tabs
map("n", "<Tab>", "<CMD>BufferLineCycleNext<CR>")
map("n", "<S-Tab>", "<CMD>BufferLineCyclePrev<CR>")
unmap("n", "<leader>bd")

-- Buffers
map("n", "<leader>bn", "<CMD>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bx", "<CMD>bd<CR>", { desc = "Close Buffer" })
map("n", "<leader>bX", "<CMD>bd!<CR>", { desc = "Force Close Buffer" })

-- Find Files
map("n", "<leader>o", "<CMD>Telescope find_files<CR>", { desc = "Open File" })

-- Indentation shortcuts
map("x", "<Tab>", ">gv")
map("x", "<S-Tab>", "<gv")

-- Live Grep

map("n", "<leader>/", "<leader>sG", { remap = true, desc = "Live Grep (cwd)" })
