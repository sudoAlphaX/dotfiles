return {
    "lewis6991/gitsigns.nvim",
    config = function()
        configs = require("gitsigns")
        configs.setup({
            numhl = true,
        })
    end,
}
