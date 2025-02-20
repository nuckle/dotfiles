local dap = require("dap")

require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
	adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Auto Attach",
			cwd = vim.fn.getcwd(),
			protocol = "inspector",
            skipFiles = {
              '${workspaceFolder}/node_modules/**/*.js',
              '${workspaceFolder}/packages/**/node_modules/**/*.js',
              '${workspaceFolder}/packages/**/**/node_modules/**/*.js',
              '<node_internals>/**',
              'node_modules/**',
              '**/node_modules/**',
            },
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require 'dap.utils'.pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = "Start Chrome with \"localhost\"",
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
			skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
		},
		language == "javascript" and {
			-- use nvim-dap-vscode-js's pwa-node debug adapter
			type = "pwa-node",
			-- launch a new process to attach the debugger to
			request = "launch",
			-- name of the debug action you have to select for this config
			name = "Launch file in new node process",
			-- launch current file
			program = "${file}",
			cwd = "${workspaceFolder}",
		} or nil,
	}
end


local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end
