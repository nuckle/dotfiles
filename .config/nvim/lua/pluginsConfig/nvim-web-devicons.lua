local present, devicons = pcall(require, "nvim-web-devicons")
if not present then
    return
end

devicons.setup({
	strict = true,
  renderer = {
	icons = {
	  git_placement = 'signcolumn',
	  glyphs = {
		git = {
		  unstaged = 'M',
		  staged = 'S',
		  unmerged = 'U',
		  renamed = 'R',
		  untracked = '?',
		  deleted = 'D',
		  ignored = 'I',
		},
	  },
	},
  },

})

devicons.set_icon {
	txt = {
		icon = "",
	},
	log = {
		icon = "󱓷"
	},
	js = {
		icon = "",
		color = "#F1F134",
		cterm_color = "185",
		name = "Js",
	},
	cjs = {
		icon = "",
		color = "#cbcb41",
		cterm_color = "185",
		name = "Cjs",
	},
	mjs = {
		icon = "",
		color = "#f1e05a",
		cterm_color = "185",
		name = "Mjs",
	};
}

