return {
  {
    "mistricky/codesnap.nvim",
    build = "make",
    tag = "v1.6.3",
    lazy = true,
    cmd = {
      "CodeSnap",
      "CodeSnapHighlight",
      "CodeSnapSave",
      "CodeSnapSaveHighlight",
      "CodeSnapASCII",
    },
    opts = {
      mac_window_bar = false,
      save_path = "~/Pictures/nvim",
      watermark = "",
      bg_theme = "grape", -- Disable theming by bg_padding = 0
      bg_padding = 25,
      has_breadcrumbs = true,
      has_line_number = false,
      show_workspace = true,
    },
  },
}
