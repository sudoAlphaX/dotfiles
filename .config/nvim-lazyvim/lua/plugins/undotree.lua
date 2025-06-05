return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
      { "<leader>sU", "<cmd>lua require('undotree').toggle()<cr>", "Undotree (plugin)" },
    },
    opts = {
      position = "right",
    },
  },
}
