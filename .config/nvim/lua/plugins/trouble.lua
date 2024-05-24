return {
    "folke/trouble.nvim",
    branch = "dev",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local configs = require("trouble")
        vim.keymap.set("n", "<leader>tt", configs.toggle, { desc = "Project Diagnostics" })
    end,
}
