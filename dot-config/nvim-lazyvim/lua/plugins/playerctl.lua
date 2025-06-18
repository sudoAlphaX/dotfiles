return {
  {
    "alexxgmz/player.nvim",
    lazy = true,
    enabled = false,
    cmd = "Player",
  },
  {
    "AntonVanAssche/music-controls.nvim",
    enabled = false,
    lazy = true,
    cmd = {
      "MPlayers",
      "MPlay",
      "MPause",
      "MNext",
      "MPrev",
      "MCurrent",
      "MShuffle",
      "MLoop",
      "MLoopToggle",
      "MVolumeGet",
      "MVolumeSet",
    },
  },
}
