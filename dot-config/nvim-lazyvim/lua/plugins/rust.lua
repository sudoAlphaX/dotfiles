return {
  "cordx56/rustowl",
  version = "*", -- Latest stable version
  ft = { "rust" },
  lazy = true,

  opts = {
    auto_attach = false,
    auto_enable = false,
    idle_time = 500,
    highlight_style = "underline",
  },

  config = function(_, opts)
    local rustowl = require("rustowl")
    rustowl.setup(opts)

    vim.schedule(function()
      Snacks.toggle({
        name = "RustOwl",
        get = function()
          return rustowl.is_enabled()
        end,
        set = function(state)
          if state then
            rustowl.enable()
          else
            rustowl.disable()
          end
        end,
      }):map("<leader>co")
    end)
  end,
}
