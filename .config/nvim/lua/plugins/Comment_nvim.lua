-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/numToStr/Comment.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
    "numToStr/Comment.nvim",
    config = function()
        configs = require("Comment")
        configs.setup()
        local api = require("Comment.api")
        vim.keymap.set('n', "<C-/>", api.toggle.linewise.current)
        vim.keymap.set('x', "<C-/>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>") 
    end,
}
