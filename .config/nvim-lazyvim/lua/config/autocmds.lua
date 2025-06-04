-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Autosave
local function save()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

vim.api.nvim_create_augroup("AutoSave", {
  clear = true,
})

-- Specify the filetypes for which autosave should be enabled
local filetypes = { "tex", "latex" }

-- Autosave for only specific file types
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    save()
  end,
  pattern = "*." .. table.concat(filetypes, ",*."),
  group = "AutoSave",
})

-- Snippets
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
    vim.api.nvim_buf_set_keymap(0, "i", "$", ";", { noremap = true, silent = true })
  end,
})
