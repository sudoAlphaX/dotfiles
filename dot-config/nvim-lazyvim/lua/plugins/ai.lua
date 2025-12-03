return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    optional = true,
    keys = {
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "x" },
      },
      {
        "<leader>al",
        function()
          require("CopilotChat").open({
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
        mode = { "n", "x" },
      },
      {
        "<leader>aa",
        vim.NIL,
        mode = { "n", "x" },
      },
      {
        "<leader>aA",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
        mode = { "n", "x" },
      },
      { "<leader>as", vim.NIL },
      {
        "<leader>aS",
        function()
          require("sidekick.cli").select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      { "<leader>ad", vim.NIL },
      {
        "<leader>aD",
        function()
          require("sidekick.cli").close()
        end,
        desc = "Detach a CLI Session",
      },
      { "<leader>at", vim.NIL, mode = { "n", "x" } },
      {
        "<leader>aT",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      { "<leader>af", vim.NIL, mode = { "n", "x" } },
      {
        "<leader>aF",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
        mode = { "n", "x" },
      },
      { "<leader>av", vim.NIL },
      {
        "<leader>aV",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      { "<leader>ap", vim.NIL, mode = { "n", "x" } },
      {
        "<leader>aP",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
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
