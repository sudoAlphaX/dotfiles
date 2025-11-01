return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    keys = {
      {
        "<leader>al",
        function()
          require("CopilotChat").open({
            selection = require("CopilotChat.select").buffer,
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
            desc = "Open Copilot Chat (Inline)",
          })
        end,
      },
    },
    opts = {
      selection = require("CopilotChat.select").buffer,
      model = "claude-sonnet-4",
      auto_insert_mode = true,
      auto_fold = true,
    },
  },
  {
    "folke/sidekick.nvim",
    optional = true,
    keys = {
      {
        "<leader>au",
        function()
          require("sidekick.nes").update()
        end,
        desc = "Update Sidekick NES",
      },
    },
    opts = {
      cli = {
        mux = {
          enabled = true,
          backend = "tmux",
        },
      },
    },
  },
}
