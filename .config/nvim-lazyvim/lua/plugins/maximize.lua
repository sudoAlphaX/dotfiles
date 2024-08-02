return {
  "declancm/maximize.nvim",
  -- config = true,
  keys = {
    { "<leader>z", "<CMD>lua require('maximize').toggle()<CR>", desc = "Maximize/Minimize Split" },
  },
  lazy = true,
}
