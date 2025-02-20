local conform = require("conform")

conform.setup({
	formatters = {
		html_beautify = {
			command = "html-beautify",
			require_cwd = false,
		},
	},

	formatters_by_ft = {
		html = { "html_beautify", stop_after_first = true },
		css = {  "prettierd", "prettier", stop_after_first = true  },
		python = {  "black", stop_after_first = true  },
		-- yaml = {  "yamllint", stop_after_first = true },
		markdown =  { "prettierd", "prettier", stop_after_first = true  },
		json =  { "prettierd", "prettier", stop_after_first = true  },
		scss =  { "prettierd", "prettier", stop_after_first = true  },
		astro = { "prettierd", "prettier", stop_after_first = true  },
		typescript =  { "prettierd", "prettier", stop_after_first = true  },
		javascript =  { "prettierd", "prettier", stop_after_first = true  },
		tsx =  { "prettierd", "prettier", stop_after_first = true  },
		typescriptreact =  { "prettierd", "prettier", stop_after_first = true  },
		javascriptreact =  { "prettierd", "prettier", stop_after_first = true  },
		php =  { "prettierd", "prettier", stop_after_first = true } ,
	},
})
