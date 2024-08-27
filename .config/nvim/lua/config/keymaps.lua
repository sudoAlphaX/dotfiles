local map = vim.keymap.set
local unmap = vim.keymap.del

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
