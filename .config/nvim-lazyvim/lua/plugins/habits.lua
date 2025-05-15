return {
  {
    "tris203/precognition.nvim",
    lazy = false,
    enabled = true,
    keys = {
      { "<leader>uP", "<cmd>lua require('precognition').toggle()<CR>", desc = "Toggle Precognition" },
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
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      max_count = 5,
      disabled_filetypes = {
        "copilot-chat",
      },
    },
  },
}
