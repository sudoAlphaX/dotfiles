return {
  {
    "tris203/precognition.nvim",
    lazy = false,
    enabled = false,
    keys = {
      {
        "<leader>uP",
        function()
          require("precognition").toggle()
        end,
        desc = "Toggle Precognition",
      },
    },
    opts = {
      showBlankVirtLine = false,
      disabled_fts = {
        "man",
        "gitcommit",
      },
    },
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>uH", "<cmd>:Hardtime toggle<CR>", desc = "Toggle Hardtime" },
      { "j", 'v:count == 0 ? "gj" : "j"', desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
      { "<Down>", 'v:count == 0 ? "gj" : "j"', desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
      { "k", 'v:count == 0 ? "gk" : "k"', desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
      { "<Up>", 'v:count == 0 ? "gk" : "k"', desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
    },
    opts = {
      disable_mouse = false,
      max_count = 5,
      disabled_filetypes = {
        "copilot-chat",
      },
    },
  },
}
