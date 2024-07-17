return {
  "alexghergh/nvim-tmux-navigation",
  keys = {

    { "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>", mode = { "n", "t" } },
    { "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>", mode = { "n", "t" } },
    { "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>", mode = { "n", "t" } },
    { "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>", mode = { "n", "t" } },
    { "<C-Tab>", "<CMD>NvimTmuxNavigateLastActive<CR>", mode = { "n", "t" } },
  },

  config = function()
    local configs = require("nvim-tmux-navigation")

    configs.setup({
      disable_when_zoomed = true,
    })
  end,
}
