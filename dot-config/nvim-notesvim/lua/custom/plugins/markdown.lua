return {
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      { "<leader>mm", "<CMD>lua require('peek').open()<CR>", desc = "Markdown Preview" },
      { "<leader>mM", "<CMD>lua require('peek').close()<CR>", desc = "Stop Markdown Preview" },
    },
    lazy = true,
  },
}
