return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
      { "<C-t>", "<cmd>lua require('undotree').toggle()<cr>", "Toggle undotree" },
    },
    opts = {
      position = "right",
    },
  },
}
