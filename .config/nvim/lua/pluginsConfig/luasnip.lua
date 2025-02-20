require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/snippets"})
require("luasnip").config.setup({store_selection_keys="<Tab>"})
