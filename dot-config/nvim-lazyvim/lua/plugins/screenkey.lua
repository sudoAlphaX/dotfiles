return {
  "NStefan002/screenkey.nvim",
  keys = {
    {
      "<leader>uk",
      function()
        require("screenkey").toggle()
      end,
      desc = "Toggle screenkey",
    },
  },
  lazy = false,
  version = "*", -- or branch = "main", to use the latest commit
}
