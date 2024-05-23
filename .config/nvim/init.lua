-- lazy.nvim configs
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-conf") -- Specify bare vim configs in vim-conf.lua file
require("mappings") -- Seperate file for mappings
require("lazy").setup("plugins", {
    change_detection = {
        notify = false, -- Turn off notification on config change
    }
}) -- lazy.nvim init
