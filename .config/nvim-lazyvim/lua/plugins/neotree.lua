return {
  "nvim-neo-tree/neo-tree.nvim",
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
}
