return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        local wk = require("which-key")
            wk.register({
                ["<leader>"] = {
                    o = { "<cmd>Telescope find_files<cr>", "Open Files" },
                    f = {
                        name = "+file",
                        g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
                        r = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
                    },
                    b = { "<cmd>Telescope buffers<cr>", "List Buffers" },
                    p = { "<cmd>Telescope neoclip<cr>", "Register History" }
                    g = "+git",
              }
        })
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    }
}
