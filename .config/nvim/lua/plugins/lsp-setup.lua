return {
    {
        "williamboman/mason.nvim",
        config = function()
            local configs = require("mason")
            configs.setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            local configs = require("mason-lspconfig")
            configs.setup()
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            local configs = require("mason-tool-installer")
            configs.setup({
                ensure_installed = {
                },
                auto_update = true,
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local configs = require("lspconfig")
    },
}
