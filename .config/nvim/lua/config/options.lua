-- Vim global configs

-- Set tabs to use 4 spaces and replace tab characters to spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set autoindent")
vim.cmd("set autowrite")

vim.cmd("set number")
vim.cmd("set mouse=a")

-- Search options
vim.cmd("set hlsearch")
vim.cmd("set ignorecase")
vim.cmd("set incsearch")
vim.cmd("set smartcase")

-- Text rendering options
vim.cmd("set cursorline")
vim.cmd("set nowrap")

-- Code folding
vim.cmd("set foldmethod=indent")
vim.cmd("set nofoldenable")
vim.cmd("set foldnestmax=3")
