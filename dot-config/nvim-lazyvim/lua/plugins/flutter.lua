return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = true,
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {
      fvm = true,
      widget_guides = {
        enabled = true,
      },
      debugger = {
        enabled = false,
      },
      lsp = {
        color = {
          enabled = true,
          background = true, -- highlight the background
          foreground = false, -- highlight the foreground
          virtual_text = false, -- show the highlight using virtual text
        },
      },
    },
  },
}
