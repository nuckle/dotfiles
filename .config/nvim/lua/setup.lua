vim.opt.shadafile = ""
vim.g.do_filetype_lua = 1
vim.wo.number = true
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.o.undofile = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.mouse = "a"
vim.opt.copyindent = true
vim.opt.ignorecase = true
vim.opt.showmatch = true
vim.opt.title = true
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.backupcopy = "auto"
vim.opt.backupdir = vim.fn.expand('~/.local/share/nvim/backup/')
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim/undodir/')
vim.opt.undofile = true
vim.opt.undolevels = 2000
vim.opt.foldmethod = 'expr'
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.showmode = false
vim.opt.shortmess:append({ I = true })
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "" })


local autocmd_group = vim.api.nvim_create_augroup(
	"Custom auto-commands",
	{ clear = true }
)

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" },
	{
		pattern = { "*.ejs" },
		callback = function()
			vim.cmd(":set ft=html")
		end,
		group = autocmd_group,
	})

vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" },
	{
		pattern = { "*.yml" },
		callback = function()
			vim.cmd(":setlocal expandtab noic cin")
		end,
		group = autocmd_group,
	})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.mdx" },
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		vim.api.nvim_set_option_value("filetype", "markdown", {buf = buf})
	end,
})
