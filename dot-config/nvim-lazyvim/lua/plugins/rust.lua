return {
  "cordx56/rustowl",
  version = "*", -- Latest stable version
  build = "cargo binstall rustowl",
  ft = { "rust" },

  opts = {
    auto_enable = true,
    idle_time = 500,
    highlight_style = "underline",
  },
}
