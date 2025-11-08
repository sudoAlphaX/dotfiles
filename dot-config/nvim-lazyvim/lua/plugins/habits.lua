return {

  {
    "tris203/precognition.nvim",
    event = "VeryLazy", -- load after core UI
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
      local shown, enabled = false, true

      -- start a delayed show after user stops moving/typing
      local function schedule_show()
        if timer:is_active() then
          timer:stop()
        end
        timer:start(idle_ms, 0, function()
          vim.schedule(function()
            if enabled and not shown then
              shown = true
              pcall(precog.show)
            end
          end)
        end)
      end

      -- hide immediately and restart countdown
      local function hide_and_reset()
        if not enabled then
          return
        end
        if timer:is_active() then
          timer:stop()
        end
        if shown then
          shown = false
          pcall(precog.hide)
        end
        schedule_show()
      end

      -- use motion and insert events instead of per-key hook
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertCharPre" }, {
        callback = hide_and_reset,
      })

      -- Snacks toggle integration
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
            else
              schedule_show()
            end
          end,
        }):map("<leader>uP")
      end)
    end,
  },
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    event = "VeryLazy",
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
