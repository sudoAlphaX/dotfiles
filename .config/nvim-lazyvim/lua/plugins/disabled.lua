return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      notifier = { enabled = false },
    },
    keys = {
      { "<leader>n", false },
    },
  },
}
