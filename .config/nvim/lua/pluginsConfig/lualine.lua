local present, lualine = pcall(require, "lualine")
if not present then
    return
end

lualine.setup({
	extensions = { 'neo-tree', 'nvim-dap-ui', 'lazy', 'mason', 'trouble' },
	options = {
		theme = 'nightfly',
		component_separators = '|',
		section_separators = '',
	}
})

