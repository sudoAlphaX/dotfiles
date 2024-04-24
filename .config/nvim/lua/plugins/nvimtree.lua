return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({})

        local configs = require("nvim-tree.api")
        vim.keymap.set('n', "<C-n>", configs.tree.toggle)
    end
}

