-- Base neovim configs

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "


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


-- Plugins go here
local plugins = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- Catppuccin theme
    { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } }, -- Telescope plugin
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "alexghergh/nvim-tmux-navigation" },
}

local opts = {}

require("lazy").setup(plugins, opts) -- lazy.nvim init


-- Plugins configs

-- Catppuccin themes setup
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    -- flavour = "auto" -- will respect terminal"
    --s background
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin" --Catppuccin theme init


-- Telescope config

local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>o", telescope.find_files, {})
vim.keymap.set("n", "<leader>g", telescope.live_grep, {})
vim.keymap.set("n", "<leader>b", telescope.buffers, {})


-- Treesitter config

local treesitter = require("nvim-treesitter.configs")
treesitter.setup({
    ensure_installed = {"bash", "gitignore", "json", "lua", "markdown", "python", "regex", "ini"},
    sync_install = true,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})


-- Neovim-Tmux navigation config

local nvim_tmux_nav = require("nvim-tmux-navigation")

nvim_tmux_nav.setup({
    disable_when_zoomed = true -- defaults to false
})

vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

