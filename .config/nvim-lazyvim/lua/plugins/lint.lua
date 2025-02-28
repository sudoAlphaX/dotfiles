local HOME = os.getenv("XDG_CONFIG_HOME")
return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", HOME .. "/markdownlint/.markdownlint-cli2.yaml", "--" },
      },
    },
  },
}
