return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    keys = {
      { "<leader>E", "<leader>fe", remap = true, desc = "Explorer NeoTree (Root Dir)" },
      { "<leader>e", "<CMD>Neotree focus<CR>", desc = "Focus Neotree" },
      { "<C-n>", "<CMD>Neotree toggle<CR>" },
    },
    opts = {
      window = {
        position = "right",
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      view = { side = "right" },
    },
    keys = {
      { "<C-n>", "<CMD>lua require('nvim-tree.api').tree.toggle()<CR>" },
      { "<leader>e", "<CMD>lua require('nvim-tree.api').tree.focus()<CR>", desc = "Focus File Tree" },
    },
  },
}
