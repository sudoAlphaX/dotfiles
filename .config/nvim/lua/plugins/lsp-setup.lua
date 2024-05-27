return {
	{
		"williamboman/mason.nvim",
		config = function()
			local configs = require("mason")
			configs.setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local configs = require("mason-lspconfig")
			configs.setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			local configs = require("mason-tool-installer")
			configs.setup({
				ensure_installed = {
					-- Lua
					"lua_ls",
					"stylua",
					-- Python
					"pyright",
					"black",
					"isort",
					-- "pylint",
					-- Shell
					"bashls",
				},
				auto_update = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local configs = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			configs.lua_ls.setup({ capabilities = capabilities })
			configs.pyright.setup({ capabilities = capabilities })
			configs.bashls.setup({ capabilities = capabilities })
			configs.kotlin_language_server.setup({ capabilities = capabilities })

			vim.keymap.set("n", "H", vim.lsp.buf.hover, { desc = "Hover info" })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover info" })
			vim.keymap.set("n", "<C-h>", vim.lsp.buf.definition, { desc = "Signature help" })
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.definition, { desc = "Signature help" })
			vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, { desc = "Rename symbol" })
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "View References" })
			vim.keymap.set("n", "<C-space>", vim.lsp.buf.code_action, { desc = "Code Actions" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Actions" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local configs = require("null-ls")
			configs.setup({
				sources = {
					-- Lua
					configs.builtins.formatting.stylua,
					-- Python
					configs.builtins.formatting.black,
					configs.builtins.formatting.isort,
					configs.builtins.diagnostics.pylint.with({
						extra_args = function()
							return { "--init-hook", "import pylint_venv; pylint_venv.inithook()" }
						end,
					}),
				},
			})
			vim.keymap.set("n", "<leader>ll", vim.lsp.buf.format, { desc = "Format File" })
		end,
	},
}
