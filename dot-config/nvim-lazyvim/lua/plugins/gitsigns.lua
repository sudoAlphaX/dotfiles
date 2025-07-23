return {
  "lewis6991/gitsigns.nvim",
  keys = {
    {
      "<leader>go",
      function()
        require("gitsigns").toggle_word_diff()
      end,
      desc = "Toggle word diff",
    },
    {
      "<leader>gO",
      function()
        require("gitsigns").toggle_deleted()
      end,
      desc = "Toggle deleted line diff",
    },
  },
  opts = {
    current_line_blame = true,
  },
}
