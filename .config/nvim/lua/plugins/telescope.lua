return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local configs = require("telescope.builtin")
        vim.keymap.set("n", "<leader>o", "<cmd>Telescope find_files<CR>", { desc = "Open File"})
        vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep"})
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent Files"})
        vim.keymap.set("n", "<leader>bf", "<cmd>Telescope buffers<CR>", { desc = "List Buffers"})
    end
}

