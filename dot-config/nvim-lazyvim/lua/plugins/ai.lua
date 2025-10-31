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
}
