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

    { "<leader>fsc", "<ESC><CMD>lua require('remote-sshfs.api').connect()<CR>", desc = "Connect to remote" },
    { "<leader>fsd", "<ESC><CMD>lua require('remote-sshfs.api').disconnect()<CR>", desc = "Disconnect from remote" },
    {
      "<leader>fse",
      "<ESC><CMD>lua require('remote-sshfs.api').edit()<CR>",
      desc = "Edit remote (SSH) configurations",
    },
    { "<leader>fsf", "<ESC><CMD>lua require('remote-sshfs.api').find_files()<CR>", desc = "Remote Find Files" },
    { "<leader>fsg", "<ESC><CMD>lua require('remote-sshfs.api').live_grep()<CR>", desc = "Remote Live Grep" },
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
