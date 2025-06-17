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
}
