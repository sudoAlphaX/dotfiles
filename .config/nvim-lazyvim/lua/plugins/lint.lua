local XDG_CONFIG_HOME = os.getenv("XDG_CONFIG_HOME")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", XDG_CONFIG_HOME .. "/markdownlint/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
