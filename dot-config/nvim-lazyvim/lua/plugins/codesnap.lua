return {
  {
    "mistricky/codesnap.nvim",
    tag = "v2.0.0",
    lazy = true,
    cmd = {
      "CodeSnap",
      "CodeSnapHighlight",
      "CodeSnapSave",
      "CodeSnapSaveHighlight",
      "CodeSnapASCII",
    },
    opts = {
      snapshot_config = {
        background = "#00000000",
        window = {
          mac_window_bar = false,
          margin = {
            x = 0,
            y = 0,
          },
          radius = 0,
        },
      },
    },
  },
}
