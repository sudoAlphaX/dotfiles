return {
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          -- { "<leader>c", group = "code" },
          -- { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>s", group = "search" },
          { "<leader>t", group = "terminal", icon = { icon = " ", color = "purple" } },
          { "<leader>z", icon = { icon = "", color = "blue" } },
          -- { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          -- better descriptions
          { "gx", desc = "Open with system app" },
        },
      },
    },

    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
