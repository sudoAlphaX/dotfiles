return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false,
        },
        clangd = {
          mason = false,
        },
        texlab = {
          mason = false,
        },
        pyright = {
          mason = false,
        },
        bashls = {
          mason = false,
        },
        jsonls = {
          mason = false,
        },
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      notifier = { enabled = false },
    },
  },
  {
    "saghen/blink.cmp",
    enabled = false,
  },
}
