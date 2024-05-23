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
            vim.keymap.set("n", "H", vim.lsp.buf.hover, { desc = "Hover info"})
            vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover info"})
            vim.keymap.set("n", "<C-h>", vim.lsp.buf.definition, { desc = "Signature help" })
            vim.keymap.set("n", "<leader>ls", vim.lsp.buf.definition, { desc = "Signature help" })
            vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, { desc = "Rename symbol" })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "View References" })
            vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "View Diagnostics" })
            vim.keymap.set("n", "<leader>wn", vim.diagnostic.goto_next, { desc = "Goto Next Diagnostic" })
            vim.keymap.set("n", "<leader>wb", vim.diagnostic.goto_prev, { desc = "Goto Prev Diagnostic" })
            vim.keymap.set("n", "<leader>ww", vim.diagnostic.setloclist, { desc = "List Diagnostics" })
            vim.keymap.set("n", "<C-space>", vim.lsp.buf.code_action, { desc = "Code Actions" })
            vim.keymap.set("n", "<leader>ll", vim.lsp.buf.code_action, { desc = "Code Actions" })
        end
    },
}
