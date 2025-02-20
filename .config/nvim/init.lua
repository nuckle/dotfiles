local async
async =
    vim.loop.new_async(
    vim.schedule_wrap(
        function()
		  require("lazyInit")
		  require("plugins")
		  require("theme")
		  require("pluginsConfig")
		  require("setup")
		  require("keys")

         async:close()

		 vim.cmd([[
			 syntax on
			 filetype on
			 filetype plugin indent on
		 ]])

        end
    )
)
async:send()
