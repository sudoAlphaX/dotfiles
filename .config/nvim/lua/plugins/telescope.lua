return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local configs = require("telescope.builtin")
        vim.keymap.set("n", "<leader>o", configs.find_files, { desc = "Open File"})
        vim.keymap.set("n", "<leader>fg", configs.live_grep, { desc = "Live Grep"})
        vim.keymap.set("n", "<leader>b", configs.buffers, { desc = "List Buffers"})
        vim.keymap.set("n", "<leader>fr", configs.oldfiles, { desc = "Recent Files"})
    end
}

