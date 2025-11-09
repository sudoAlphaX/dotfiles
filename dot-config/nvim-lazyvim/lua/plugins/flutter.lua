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
    config = function(_, opts)
      require("flutter-tools").setup(opts)

      pcall(vim.keymap.del, "n", "<leader>cf")
      pcall(vim.keymap.del, "n", "<leader>cF")

      local wk = require("which-key")
      wk.add({
        { "<leader>cF", "<cmd>LazyFormat<cr>", desc = "Format" },
        { "<leader>cf", group = "Flutter" },
        { "<leader>cfr", "<cmd>FlutterRun<cr>", desc = "Run App" },
        { "<leader>cfR", "<cmd>FlutterRestart<cr>", desc = "Restart App" },
        { "<leader>cfd", "<cmd>FlutterDevices<cr>", desc = "Select Device" },
        { "<leader>cfq", "<cmd>FlutterQuit<cr>", desc = "Quit App" },
        { "<leader>cfg", "<cmd>FlutterPubGet<cr>", desc = "Get Packages" },
        { "<leader>cfG", "<cmd>FlutterPubUpgrade<cr>", desc = "Upgrade Packages" },
        { "<leader>cfl", "<cmd>FlutterLogToggle<cr>", desc = "Toggle Logs" },
        { "<leader>cfL", "<cmd>FlutterLogClear<cr>", desc = "Clear Logs" },
        { "<leader>cfo", "<cmd>FlutterOutlineToggle<cr>", desc = "Toggle Outline" },
      })
    end,
  },
}
