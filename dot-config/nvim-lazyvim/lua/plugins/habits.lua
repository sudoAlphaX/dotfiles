return {

  {
    "tris203/precognition.nvim",
    lazy = false,
    enabled = true,
    opts = {
      showBlankVirtLine = false,
      disabled_fts = { "man", "gitcommit" },
    },
    config = function(_, opts)
      local precog = require("precognition")
      precog.setup(opts)
      precog.hide() -- start hidden

      local idle_ms = 1000
      local timer = vim.uv.new_timer()
      local shown = false
      local enabled = true -- default ON

      vim.on_key(function()
        if not enabled then
          return
        end -- respect toggle

        if timer:is_active() then
          timer:stop()
        end
        if shown then
          shown = false
          pcall(precog.hide)
        end

        timer:start(idle_ms, 0, function()
          vim.schedule(function()
            if enabled then
              shown = true
              pcall(precog.show)
            end
          end)
        end)
      end, vim.api.nvim_create_namespace("precognition-idle"))

      -- Snacks toggle
      vim.schedule(function()
        Snacks.toggle({
          name = "Precognition",
          get = function()
            return enabled
          end,
          set = function(state)
            enabled = state
            if not state then
              if timer:is_active() then
                timer:stop()
              end
              pcall(precog.hide)
            end
          end,
        }):map("<leader>uP")
      end)
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>uH", "<cmd>:Hardtime toggle<CR>", desc = "Toggle Hardtime" },
      { "j", 'v:count == 0 ? "gj" : "j"', desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
      { "<Down>", 'v:count == 0 ? "gj" : "j"', desc = "Down", mode = { "n", "x" }, expr = true, silent = true },
      { "k", 'v:count == 0 ? "gk" : "k"', desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
      { "<Up>", 'v:count == 0 ? "gk" : "k"', desc = "Up", mode = { "n", "x" }, expr = true, silent = true },
    },
    opts = {
      disable_mouse = false,
      max_count = 5,
      disabled_filetypes = {
        "copilot-chat",
      },
    },
  },
}
