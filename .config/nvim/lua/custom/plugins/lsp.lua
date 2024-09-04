return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua
					"lua_ls",
					"stylua",
					-- Python
					"pyright",
					"ruff",
					"ruff_lsp",
					-- "black",
					-- "isort",
					-- "pylint",
					-- Shell
					"bashls",
					"shellcheck",
					"shellharden",

					-- Json
					"json-lsp",

					-- Spell
					"cspell",
				},
				auto_update = true,
			}),
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local lsp = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lsp.lua_ls.setup({ capabilities = capabilities })

			lsp.ruff.setup({ capabilities = capabilities })
			lsp.pyright.setup({ capabilities = capabilities })
			lsp.ruff_lsp.setup({ capabilities = capabilities })

			lsp.bashls.setup({ capabilities = capabilities })

			lsp.jsonls.setup({ capabilities = capabilities })

			lsp.clangd.setup({ capabilities = capabilities })

			require("mason-lspconfig").setup_handlers({

				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({})
				end,
			})
		end,
	},
}
