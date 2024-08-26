return {
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_quickfix_mode = 1
      vim.g.tex_conceal = "abdmg"
      vim.g.conceallevel = 1
    end,
  },
  -- {
  -- "micangl/cmp-vimtex",
  -- config = function()
  --   require("cmp").setup({
  --     sources = { name = "vimtex" },
  --   })
  -- end,
  -- },
}
