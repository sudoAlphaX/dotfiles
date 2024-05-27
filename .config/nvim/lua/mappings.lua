local function open_nvim_tree(data)

    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
        return
    end

    -- create a new, empty buffer
    vim.cmd.enew()

    -- wipe the directory buffer
    vim.cmd.bw(data.buf)

    -- change to the directory
    vim.cmd.cd(data.file)

    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New Buffer" })
vim.keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close Buffer" })
vim.keymap.set("n", "<leader>bx", "<cmd>bd!<CR>", { desc = "Force Close Buffer" })
