return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
      { "<C-y>", "<cmd>lua require('undotree').toggle()<cr>", "Toggle undotree" },
    },
    opts = {
      position = "right",
    },
  },
}
