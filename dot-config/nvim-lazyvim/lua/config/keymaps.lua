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
map("n", "<leader>bx", function()
  Snacks.bufdelete()
end, { desc = "Close Buffer" })
map("n", "<leader>bd", "<leader>bx", { remap = true, desc = "Close Buffer" })
map("n", "<leader>bX", function()
  Snacks.bufdelete({ force = true })
end, { desc = "Force Close Buffer" })
map("n", "<leader>bb", "<leader>fb", { remap = true, desc = "List Buffers" })

-- Find Files
map("n", "<leader> ", "<leader>ff", { remap = true, desc = "Find Files (Root Dir)" })
map("n", "<leader>o", "<leader>fF", { remap = true, desc = "Find Files (cwd)" })
map("n", "<leader>/", "<leader>sG", { remap = true, desc = "Grep (cwd)" })
map("n", "<leader>r", "<leader>fr", { remap = true, desc = "Recent files" })

-- Explorer
map("n", "<C-n>", function()
  Snacks.picker.explorer({
    cwd = LazyVim.root(),
    win = {
      list = {
        keys = { ["<C-n>"] = { "close", mode = { "n", "i" } } }, -- Close explorer with <C-n>
      },
    },
    jump = { close = false }, -- Close explorer after jumping to a file
  })
end, { remap = true, desc = "Explorer" })

-- Git
-- map("n", "<leader>gh", function()
--   Snacks.picker.git_stash()
-- end, { desc = "Git Stashes" })

map("n", "<leader>gc", function()
  Snacks.picker.git_branches()
end, { desc = "Git Checkout" })

-- Indentation shortcuts
map("x", "<Tab>", ">gv")
map("x", "<S-Tab>", "<gv")
map("n", "<leader>c=", "gg=G''", { desc = "Indent Buffer" })

-- Registers (Clipboard History)
map("n", "<leader>p", '<leader>s"', { remap = true, desc = "Registers" })

-- Commenting
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- Terminal
map("n", "<leader>T", "<leader>ft", { remap = true, desc = "Terminal" })
map("n", "<leader>t", "<leader>fT", { remap = true, desc = "Terminal (cwd)" })

-- Zoom
map("n", "<leader>z", "<leader>uZ", { remap = true, desc = "Maximize" })

-- Select all
map("n", "<leader>as", "ggVG", { remap = true, desc = "Select All" })
