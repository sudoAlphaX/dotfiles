return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { "<leader>go", "<ESC><CMD>Gitsigns toggle_word_diff<CR>", desc = "Toggle word diff" },
    { "<leader>gO", "<ESC><CMD>Gitsigns toggle_deleted<CR>", desc = "Toggle deleted line diff" },
  },
  opts = {
    current_line_blame = true,
  },
}
