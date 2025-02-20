local present, nt_config = pcall(require, "neo-tree")
if not present then
    return
end

nt_config.setup {
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			show_hidden_count = false
		}
	},
	event_handlers = {
		{
		  event = "file_opened",
		  handler = function()
			--auto close
			require("neo-tree").close_all()
		  end,
		},
	},
	window = {
		mappings = {
				["h"] = function(state)
				local node = state.tree:get_node()
				if node.type == 'directory' and node:is_expanded() then
					require'neo-tree.sources.filesystem'.toggle_directory(state, node)
				else
					require'neo-tree.ui.renderer'.focus_node(state, node:get_parent_id())
				end
				end,
				["l"] = function(state)
				local node = state.tree:get_node()
				if node.type == 'directory' then
					 if not node:is_expanded() then
						require'neo-tree.sources.filesystem'.toggle_directory(state, node)
					 elseif node:has_children() then
						require'neo-tree.ui.renderer'.focus_node(state, node:get_child_ids()[0])
					 end
				end
				end,
		}
	}
}

