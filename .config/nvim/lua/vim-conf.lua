-- Vim global configs

-- Set tabs to use 4 spaces and replace tab characters to spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set autoindent")
vim.cmd("set autowrite")

vim.g.mapleader = " "

vim.cmd("set number")
vim.cmd("set mouse=a")

-- Search options
vim.cmd("set hlsearch")
vim.cmd("set ignorecase")
vim.cmd("set incsearch")
vim.cmd("set smartcase")

-- Text rendering options
vim.cmd("set cursorline")

-- Code folding
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")
vim.cmd("set foldnestmax=3")

-- Indentation shortcuts
vim.keymap.set('x', "<Tab>", ">><ESC>")
vim.keymap.set('x', "<S-Tab>", "<<<ESC>")
