return {
  "alexghergh/nvim-tmux-navigation",
  keys = {

    { "<C-h>", "<CMD>NvimTmuxNavigateLeft<CR>" },
    { "<C-j>", "<CMD>NvimTmuxNavigateDown<CR>" },
    { "<C-k>", "<CMD>NvimTmuxNavigateUp<CR>" },
    { "<C-l>", "<CMD>NvimTmuxNavigateRight<CR>" },
    { "<C-Tab>", "<CMD>NvimTmuxNavigateLastActive<CR>" },
  },

  config = function()
    local configs = require("nvim-tmux-navigation")

    vim.keymap.set("t", "<C-h>", configs.NvimTmuxNavigateLeft)
    vim.keymap.set("t", "<C-j>", configs.NvimTmuxNavigateDown)
    vim.keymap.set("t", "<C-k>", configs.NvimTmuxNavigateUp)
    vim.keymap.set("t", "<C-l>", configs.NvimTmuxNavigateRight)
    vim.keymap.set("t", "<C-Tab>", configs.NvimTmuxNavigateLastActive)

    configs.setup({
      disable_when_zoomed = true,
    })
  end,
}
