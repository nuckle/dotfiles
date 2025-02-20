require('lazy').setup({
	'chentoast/marks.nvim',
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require('tokyonight').setup {
				-- other configs
				on_colors = function(colors)
					colors.border = "#565f89"
				end
			}
		end
	},
	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		opts = {
			-- your options here
		}
	},
	'lambdalisue/suda.vim',
	'LunarVim/bigfile.nvim',
	{
		'ptzz/lf.vim',
		config = function()
			vim.g.NERDTreeHijackNetrw = 0
			vim.g.floaterm_opener = 'vsplit'
		end,
		dependencies = {
			'voldikss/vim-floaterm',
		}
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function() require('gitsigns').setup {} end
	},
	'mattn/emmet-vim',
	'lukas-reineke/lsp-format.nvim',
	{
		'lukas-reineke/indent-blankline.nvim',
		dependencies = {
			'HiPhish/rainbow-delimiters.nvim',
		},
	},
	'mrjones2014/smart-splits.nvim',
	'nvim-tree/nvim-web-devicons',
	'romgrk/barbar.nvim',
	{
		'nmac427/guess-indent.nvim',
		config = function() require('guess-indent').setup {} end,
	},
	'frabjous/knap',
	{
		'toppair/peek.nvim',
		event = { 'VeryLazy' },
		build = 'deno task --quiet build:fast'
	},
	'nvim-lualine/lualine.nvim',
	'Vonr/align.nvim',
	'img-paste-devs/img-paste.vim',
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
	{
		'folke/which-key.nvim',
		opts = {}
	},
	{
		'jakewvincent/mkdnflow.nvim',
		rocks = 'luautf8',
		config = function()
			require('mkdnflow').setup({
				mappings = {
					MkdnEnter = { { 'i', 'n', 'v' }, '<CR>' }
				}
			})
		end
	},
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
	{
		'nvim-pack/nvim-spectre',
		dependencies = {
			'nvim-lua/plenary.nvim',
		}
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		event = 'BufWinEnter'
	},
	{
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end
	},
	{
		'windwp/nvim-ts-autotag',
		config = function() require('nvim-ts-autotag').setup({}) end
	},
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
		},
	},
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'mxsdev/nvim-dap-vscode-js',
			{
				'microsoft/vscode-js-debug',
				version = '1.x',
				build = 'npm i && npm run compile vsDebugServerBundle && mv dist out'
			},
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio'
		},
	},
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			warn_no_results = false,
			open_no_results = true,
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	{
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip'
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		'neovim/nvim-lspconfig',
		event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
	},
	{ 'artemave/workspace-diagnostics.nvim' },
	{
		'pmizio/typescript-tools.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		opts = {},
	},
	{
		'kevinhwang91/nvim-ufo',
		dependencies = { 'kevinhwang91/promise-async' },
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim'
		}
	},
	{
		'stevearc/conform.nvim',
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		'mfussenegger/nvim-lint',
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		'williamboman/mason.nvim',
		config = function() require('mason').setup {} end,
		run = ':MasonUpdate',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'WhoIsSethDaniel/mason-tool-installer.nvim'
		}
	},
	{
		'renerocksai/telekasten.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim'
		},
	},
})
