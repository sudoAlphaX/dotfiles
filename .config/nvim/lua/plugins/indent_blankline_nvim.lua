-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/lukas-reineke/indent-blankline.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        configs = require("ibl")
        configs.setup()
    end,
}
