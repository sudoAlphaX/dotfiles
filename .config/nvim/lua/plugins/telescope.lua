return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local configs = require("telescope.builtin")
        vim.keymap.set("n", "<leader>o", configs.find_files, {})
        vim.keymap.set("n", "<leader>g", configs.live_grep, {})
        vim.keymap.set("n", "<leader>b", configs.buffers, {})
    end
}
