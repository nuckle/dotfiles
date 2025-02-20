local cmp = require 'cmp'
local capabilities = require('cmp_nvim_lsp').default_capabilities()


local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.setup({
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	snippet = {
		expand = function(args)
			require 'luasnip'.lsp_expand(args.body)
		end,
	},
	window = {
	},
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
			reason = cmp.ContextReason.Auto,
		}), { "i", "c" }),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
	}),
	sources = cmp.config.sources({
		{ name = 'luasnip' },
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})


local ts_utils = require("nvim-treesitter.ts_utils")

local function ls_name_from_event(event)
	return event.entry.source.source.client.config.name
end

cmp.event:on("confirm_done", function(event)
	local ok, ls_name = pcall(ls_name_from_event, event)
	if ok and vim.tbl_contains({ 'cssls', 'lua_ls' }, ls_name) then
		return
	end

	if ts_utils.get_node_at_cursor() == nil then
		return
	end

	local ts_name = ts_utils.get_node_at_cursor():type()
	if ts_name ~= "named_imports" then
		cmp_autopairs.on_confirm_done()(event)
	end
end)

local present, lsp_format = pcall(require, "lsp-format")
if not present then
	return
end

lsp_format.setup {}


-- Disable lsp syntax highlighting
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
});


-- lsp languages https://github.com/williamboman/mason-lspconfig.nvim
local mason_tool_installer = require("mason-tool-installer")
mason_tool_installer.setup({
	ensure_installed = {
		"astro-language-server",
		"svelte-language-server",
		"css-lsp",
		"vue-language-server",
		"black",
		"emmet-language-server",
		"html-lsp",
		"htmlhint",
		"typescript-language-server",
		"phpactor",
		"marksman",
		"ltex-ls",
		"texlab",
		"python-lsp-server",
		"prettierd",
		"eslint_d",
		"yaml-language-server",
		"lua-language-server"
	},
})


local present, lspconfig = pcall(require, "lspconfig")
if not present then
	return
end


lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig.util.default_config.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)


-- commented because of https://github.com/pmizio/typescript-tools.nvim
-- lspconfig.tsserver.setup({}) -- https://github.com/typescript-lanmaxPreload=1000guage-server/typescript-language-server#workspacedidchangeconfiguration && https://github.com/lvimuser/lsp-inlayhints.nvim#typescript

require("typescript-tools").setup {
	settings = {
		root_dir = function() return vim.uv.cwd() end
	},
	on_attach = function(client, bufnr)
		require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
	end
}
lspconfig.html.setup({
	capabilities = capabilities
})
lspconfig.cssls.setup {}
lspconfig.csharp_ls.setup {}
lspconfig.marksman.setup {}
lspconfig.phpactor.setup {}
lspconfig.astro.setup {}
lspconfig.svelte.setup {}
lspconfig.intelephense.setup {
	init_options = {
		globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense'
	}
}
lspconfig.pylsp.setup {}
lspconfig.lua_ls.setup {
	on_init = function(client)
		local folders = client.workspace_folders

		if folders ~= nil then
			local path = folders[1].name
			if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
				return
			end
		end


		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths here.
					"${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {}
	}
}
lspconfig.texlab.setup {}
lspconfig.yamlls.setup {
	settings = {
		yaml = {
			format = {
				enable = true,
			},
		}
	},
	on_attach = function(client, buffer)
		client.server_capabilities.document_formatting = true
	end
}
lspconfig.volar.setup {
	-- add filetypes for typescript, javascript and vue
	filetypes = { 'vue' },
	init_options = {
		typescript = {
			tsdk = os.getenv("HOME") .. '/.local/share/nvim/mason/packages/vue-language-server/node_modules/typescript/lib'
		},
		vue = {
			-- disable hybrid mode
			hybridMode = false,
		},
	},
}
lspconfig.ltex.setup({
	autostart = false
})
lspconfig.emmet_language_server.setup({
	root_dir = function() return vim.uv.cwd() end,
	capabilities = capabilities,
	filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = false,
			},
		},
	}
})
