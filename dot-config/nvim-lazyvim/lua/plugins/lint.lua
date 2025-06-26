local XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config"
return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--config", XDG_CONFIG_HOME .. "/markdownlint/.markdownlint-cli2.yaml", "--" },
        },
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    lazy = true,
    tag = "v2.1.0",
    keys = {
      { "<leader>gmo", "<CMD>GitConflictChooseOurs<CR>", desc = "Git Conflict Choose Ours" },
      { "<leader>gmt", "<CMD>GitConflictChooseTheirs<CR>", desc = "Git Conflict: Choose Theirs" },
      { "<leader>gmb", "<CMD>GitConflictChooseBoth<CR>", desc = "Git Conflict: Choose Both" },
      { "<leader>gmx", "<CMD>GitConflictChooseNone<CR>", desc = "Git Conflict: Choose None" },
      { "]x", "<CMD>GitConflictNextConflict<CR>", desc = "Git Conflict: Next Conflict" },
      { "[x", "<CMD>GitConflictPrevConflict<CR>", desc = "Git Conflict: Previous Conflict" },
      { "<leader>gmm", "<CMD>GitConflictRefresh<CR>", desc = "Git Conflict: Refresh" },
      { "<leader>gml", "<CMD>GitConflictListQf<CR>", desc = "Git Conflict: List QF" },
    },
    opts = {
      default_mappings = false,
    },
  },
}
