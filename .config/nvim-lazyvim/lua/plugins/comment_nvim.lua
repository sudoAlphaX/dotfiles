return {
  "numToStr/Comment.nvim",
  keys = {
    { "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise.current()<CR>" },
  },
  config = true,
  vim.keymap.set("x", "<C-/>", "<ESC><CMD>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"),
}
