return {
  "akinsho/toggleterm.nvim",
  enabled = false,
  version = "*",
  keys = {
    { "<leader>tt", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Terminal split" },
    { "<leader>tf", "<CMD>ToggleTerm direction=float<CR>", desc = "Floating Terminal" },
    { "<leader>tb", "<CMD>ToggleTerm direction=tab<CR>", desc = "Terminal in a Tab" },
  },
  opts = {},
  lazy = true,
}
