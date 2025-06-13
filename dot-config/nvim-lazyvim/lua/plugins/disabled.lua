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
        stylua = {
          mason = false,
        },
        codelldb = {
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
    keys = {
      { "<leader>n", false },
    },
  },
}
