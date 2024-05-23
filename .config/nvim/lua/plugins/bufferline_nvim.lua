-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/akinsho/bufferline.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        configs = require('bufferline')
        configs.setup()
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")
        vim.keymap.set("n", "<leader>bx", "<cmd>bd<CR>", { desc = "Close Buffer"})
    end,
}
