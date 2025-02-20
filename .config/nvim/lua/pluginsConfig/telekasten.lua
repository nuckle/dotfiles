local present, tk = pcall(require, "telekasten")
if not present then
    return
end

local documents_dir = vim.fn.system("xdg-user-dir DOCUMENTS"):gsub("\n", "")
local notes_dir = documents_dir .. '/notes'

tk.setup({
	home = notes_dir, -- Put the name of your notes directory here
	image_subdir = "Files📎",
})

