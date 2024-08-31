local map = vim.keymap.set
local unmap = vim.keymap.del

-- Return to normal mode from terminal

map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Buffers
map("n", "<Tab>", "<CMD>bnext<CR>")
map("n", "<S-Tab>", "<CMD>bprevious<CR>")
map("n", "b0", "<CMD>bfirst<CR>", { desc = "Go to First Buffer" })
map("n", "b$", "<CMD>blast<CR>", { desc = "Go to Last Buffer" })

map("n", "<leader>bn", "<CMD>enew<CR>", { desc = "New Buffer" })
map("n", "<leader>bx", "<CMD>bd<CR>", { desc = "Close Buffer" })
map("n", "<leader>bX", "<CMD>bd!<CR>", { desc = "Force Close Buffer" })

-- Indentation shortcuts
map("x", "<Tab>", ">gv")
map("x", "<S-Tab>", "<gv")

-- Window Splits
map("n", "<leader>-", "<CMD>split<CR>", { desc = "Split Window Below" })
map("n", "<leader>|", "<CMD>vsplit<CR>", { desc = "Split Window Right" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines using <alt> arrow keys
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
map("n", "<C-/>", "gcc", { remap = true })
map("v", "<C-/>", "gc", { remap = true })

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { desc = "Hover Help" })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Definition" })
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Declatation" })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", { desc = "Implementation" })
map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", { desc = "Type Definition" })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", { desc = "References" })
map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", { desc = "Signature Help" })
map("n", "<leader>ss", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename Symbol" })
map({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format Code (Native)" })
map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code Actions" })
