return {
  {
    "lervag/vimtex",
    lazy = true,
    enabled = false,
    ft = { "tex" },
    init = function()
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_quickfix_mode = 2
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 1,
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 1,
        styles = 1,
      }
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
      }
    end,
  },
}
