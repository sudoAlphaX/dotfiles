return {
  "tris203/precognition.nvim",
  lazy = false,
  keys = {
    { "<leader>uP", "<cmd>lua require('precognition').toggle()<CR>", desc = "Toggle Precognition" },
  },
  opts = {
    showBlankVirtLine = false,
    disabled_fts = {
      "man",
      "gitcommit",
    },
  },
}
