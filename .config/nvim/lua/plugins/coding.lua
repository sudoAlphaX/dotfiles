return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
			numhl = false,
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		keys = {
			-- Find Files
			{ "<leader> ", "<CMD>lua require('telescope.builtin').find_files()<CR>", desc = "Open File" },
			{ "<leader>o", "<CMD>lua require('telescope.builtin').git_files()<CR>", desc = "Git Files" },
			{ "<leader>r", "<CMD>lua require('telescope.builtin').oldfiles()<CR>", desc = "Recent Files" },
			{ "<leader>/", "<CMD>lua require('telescope.builtin').live_grep()<CR>", desc = "Live Grep" },

			-- Buffers
			{ "<leader>bb", "<CMD>lua require('telescope.builtin').buffers()<CR>", desc = "List Buffers" },

			{ "<leader>p", "<CMD>lua require('telescope.builtin').registers()<CR>", desc = "List Registers" },

			-- Git
			{ "<leader>gc", "<CMD>lua require('telescope.builtin').git_commits()<CR>", desc = "Git Commits" },
			{ "<leader>gb", "<CMD>lua require('telescope.builtin').git_branches()<CR>", desc = "Git Branches" },
			{ "<leader>gs", "<CMD>lua require('telescope.builtin').git_status()<CR>", desc = "Git Status" },
			{ "<leader>gh", "<CMD>lua require('telescope.builtin').git_stash()<CR>", desc = "Git Stashes" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = { "gitignore", "bash", "python", "lua", "markdown" },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<leader>tt", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Terminal split" },
			{ "<leader>tf", "<CMD>ToggleTerm direction=float<CR>", desc = "Floating Terminal" },
			{ "<leader>tb", "<CMD>ToggleTerm direction=tab<CR>", desc = "Terminal in a Tab" },

			-- Lazygit
			-- { "<leader>gg", "<CMD>TermExec name=Lazygit cmd=lazygit direction=float<CR>", desc = "Lazygit" },
		},
		lazy = true,
		opts = {},
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gg", "<CMD>LazyGit<CR>", desc = "LazyGit" },
		},
		lazy = true,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = { windowCreationCommand = "botright vsplit" },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.grug_far({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
		lazy = true,
	},
}
