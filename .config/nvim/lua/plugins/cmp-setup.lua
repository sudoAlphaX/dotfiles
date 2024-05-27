return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			{ "saadparwaiz1/cmp_luasnip" },
			{ "rafamadriz/friendly-snippets" },
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			local configs = require("cmp")
			configs.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = configs.config.window.bordered(),
					documentation = configs.config.window.bordered(),
				},
				mapping = configs.mapping.preset.insert({
					["<C-b>"] = configs.mapping.scroll_docs(-4),
					["<C-f>"] = configs.mapping.scroll_docs(4),
					["<C-Space>"] = configs.mapping.complete(),
					["<C-e>"] = configs.mapping.abort(),
					["<CR>"] = configs.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = configs.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
}
