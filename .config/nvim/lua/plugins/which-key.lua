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
                g = {
                    name = "+git",
                    s = { "<cmd>Telescope git_status<cr>", "Git Status" },
                    b = { "<cmd>Telescope git_branches<cr>", "Git Branches" },
                    c = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
                    f = { "<cmd>Telescope git_files<cr>", "Find Git Files" }
            },
                b = { "<cmd>Telescope buffers<cr>", "List Buffers" },
        }
    })
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
