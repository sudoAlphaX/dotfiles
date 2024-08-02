return {
  "numToStr/Comment.nvim",
  keys = {
    { "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise.current()<CR>", mode = { "n" } },
    { "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = { "v" } },
  },
  lazy = true,
}
