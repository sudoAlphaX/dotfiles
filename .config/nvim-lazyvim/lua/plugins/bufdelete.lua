return {
  {
    "https://github.com/famiu/bufdelete.nvim",
    lazy = true,
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      "<leader>bx",
      "<CMD>lua require('bufdelete').bufdelete(0,false)<CR>",
      desc = "Close Buffer",
      {
        "<leader>bX",
        "<CMD>lua require('bufdelete').bufdelete(0,true)<CR>",
        desc = "Force Close Buffer",
      },
    },
  },
}
