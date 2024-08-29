return {
  { 'MeanderingProgrammer/render-markdown.nvim',
  opts = {preset = 'lazy'},
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  lazy = true,
  ft = { "markdown" }
  }
}
