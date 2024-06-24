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
					"ruff",
					"ruff_lsp",
					-- "black",
					-- "isort",
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
			configs.ruff_lsp.setup({
				capabilities = capabilities,
				init_options = {
					settings = {
						-- Extra CLI Arguments
						args = {},
					},
				},
			})
			configs.bashls.setup({ capabilities = capabilities })

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
	{
		"stevearc/conform.nvim",
		config = function()
			local configs = require("conform")
			configs.setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
				formatters_by_ft = {
					lua = { "stylua" },

					python = function(bufnr)
						if require("conform").get_formatter_info("ruff_format", bufnr).available then
							return { "ruff_format", "ruff_organize_imports" }
						else
							return { "isort", "black" }
						end
					end,

					kotlin = { "ktfmt" },
				},
			})
		end,
	},
}
