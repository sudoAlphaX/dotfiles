return {
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    keys = {
      {
        "<leader>sU",
        function()
          require("undotree").toggle()
        end,
        desc = "Undotree (plugin)",
      },
    },
    opts = {
      position = "right",
    },
  },
}
