local FIM_MODELS = { "qwen2.5-coder:3b-fim", "qwen2.5-coder:1.5b-fim" }
return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "InsertEnter",
    keys = {
      {
        "<leader>am",
        function()
          local prov = require("minuet").config.provider_options.openai_fim_compatible
          vim.ui.select(FIM_MODELS, { prompt = "minuet FIM model (now: " .. prov.model .. ")" }, function(choice)
            if choice then
              prov.model = choice
              vim.notify("minuet FIM: " .. choice)
            end
          end)
        end,
        desc = "Minuet FIM model",
      },
    },
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 2,
      context_window = 1024,
      request_timeout = 3,
      throttle = 800,
      debounce = 400,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "llamacpp",
          end_point = "http://devcanister:11434/v1/completions",
          model = FIM_MODELS[1],
          optional = { max_tokens = 64, top_p = 0.9 },
          template = {
            prompt = function(ctx_before, ctx_after, _)
              return "<|fim_prefix|>" .. ctx_before .. "<|fim_suffix|>" .. ctx_after .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = {
        default = { "minuet" },
        providers = {
          minuet = {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            timeout_ms = 3000,
            score_offset = 50,
            enabled = function()
              return not vim.tbl_contains(
                { "", "text", "markdown", "gitcommit", "gitrebase", "help", "log", "conf" },
                vim.bo.filetype
              )
            end,
          },
        },
      },
      completion = { trigger = { prefetch_on_insert = false } },
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
      nes = {
        enabled = false,
      },
      cli = {
        mux = {
          enabled = true,
          backend = "tmux",
        },
      },
    },
  },
}
