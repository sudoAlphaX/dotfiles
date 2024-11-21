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
          mason = false
        },
        clangd = {
          mason = false
        },
        texlab = {
          mason = false
        },
        pyright = {
          mason = false
        },
        bashls = {
          mason = false
        },
        jsonls = {
          mason = false
        }
      },
    },
  },
}
