return {
	"mfussenegger/nvim-lint",
	opts = function()
		local lint = require("lint")
		local markdownlint = lint.linters.markdownlint
		local cspell = lint.linters.cspell

		markdownlint.args = {
			"--disable MD013 M036",
		}

		cspell.args = {
			"--unique",
		}

		lint.linters_by_ft = {
			markdown = { "markdownlint", "cspell" },
			tex = { "chktex" },
		}
	end,
}
