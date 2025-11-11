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
            sticky = { "#buffer" },
            window = {
              layout = "float",
              relative = "cursor",
              width = 1,
              height = 0.4,
              row = 1,
            },
          })
        end,
        desc = "Open Copilot Chat (Inline)",
        mode = { "n", "v" },
      },
      {
        "<leader>aA",
        function()
          require("CopilotChat").open({
            selection = require("CopilotChat.select").buffer,
            sticky = { "#buffer" },
          })
        end,
        desc = "Open Copilot Chat",
        mode = { "n", "v" },
      },
    },
    opts = {
      selection = require("CopilotChat.select").buffer,
      sticky = { "#buffer" },
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
