local lint = require("lint")

local tidy = require('lint').linters.tidy

tidy.args = {
	"--drop-empty-elements", "no"
}

lint.linters_by_ft = {
	html = { "tidy" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" }
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		pcall(lint, "try_lint")
	end,
})
