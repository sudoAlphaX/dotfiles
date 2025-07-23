return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = true,
  cmd = {
    "RemoteSSHFSConnect",
    "RemoteSSHFSDisconnect",
    "RemoteSSHFSEdit",
    "RemoteSSHFSFindFiles",
    "RemoteSSHFSLiveGrep",
  },
  keys = {

    {
      "<leader>fsc",
      function()
        require("remote-sshfs.api").connect()
      end,
      desc = "Connect to remote",
    },
    {
      "<leader>fsd",
      function()
        require("remote-sshfs.api").disconnect()
      end,
      desc = "Disconnect from remote",
    },
    {
      "<leader>fse",
      function()
        require("remote-sshfs.api").edit()
      end,
      desc = "Edit remote (SSH) configurations",
    },
    {
      "<leader>fsf",
      function()
        require("remote-sshfs.api").find_files()
      end,
      desc = "Remote Find Files",
    },
    {
      "<leader>fsg",
      function()
        require("remote-sshfs.api").live_grep()
      end,
      desc = "Remote Live Grep",
    },
  },
  opts = {
    handlers = {
      on_disconnect = {
        clean_mount_folders = true,
      },
    },
    ui = {
      confirm = {
        connect = false,
      },
    },
  },
}
