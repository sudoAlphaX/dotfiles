return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    },
  },
  {
    "https://github.com/mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = true,
    },
  },
  {
    "johmsalas/text-case.nvim",
    lazy = true,
    keys = {
      { "<leader>ct", desc = "+text-case" },
    },
    opts = {
      prefix = "<leader>ct",
    },
  },
  {
    "Wansmer/symbol-usage.nvim",
    keys = {
      {
        "<leader>cu",
        function()
          require("symbol-usage").toggle_globally()
        end,
        desc = "Toggle symbol usage",
      },
    },
    event = "LspAttach",
    lazy = true,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    optional = true,
    opts = {
      max_lines = 5,
      mode = "topline",
    },
  },
  {
    {
      "rachartier/tiny-inline-diagnostic.nvim",
      event = "VeryLazy",
      priority = 1000,
      opts = {
        preset = "classic",

        transparent_bg = true,

        disabled_ft = {},

        options = {

          use_icons_from_diagnostic = false,
          set_arrow_to_diag_color = true,

          multilines = {
            enabled = true,
            always_show = false,
            trim_whitespaces = true,
            severity = { vim.diagnostic.severity.ERROR },
          },

          show_all_diags_on_cursorline = false,

          -- Experimental options, subject to misbehave in future NeoVim releases
          experimental = {
            -- Make diagnostics not mirror across windows containing the same buffer
            -- See: https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/127
            use_window_local_extmarks = false,
          },
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = { diagnostics = { virtual_text = false } },
    },
  },
}
