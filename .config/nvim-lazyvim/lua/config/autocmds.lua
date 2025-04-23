-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autosave functionality
-- Specify the filetypes for which autosave and keybindings should be enabled
Autosave_filetypes = { "tex", "latex" }

vim.api.nvim_create_augroup("AutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = "AutoSave",
  callback = function()
    local ft = vim.bo.filetype
    if vim.tbl_contains(Autosave_filetypes, ft) then
      vim.cmd("silent! write")
    end
  end,
})

-- Load custom snippets
require("luasnip.loaders.from_vscode").lazy_load({
  paths = "./snippets",
})

-- Special keybindings for LaTeX editing
vim.api.nvim_create_augroup("Keybinds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "Keybinds",
  pattern = { "tex", "latex", "markdown" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", ";", "$", { noremap = true, silent = true })
  end,
})
