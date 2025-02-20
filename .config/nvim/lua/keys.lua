local map = vim.api.nvim_set_keymap

map('n', '<leader>e', '<Cmd>Neotree focus toggle<CR>', { desc = 'Toggle sidebar', noremap = true })
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { desc = 'Previous tab', noremap = true })
map('n', '<A-.>', '<Cmd>BufferNext<CR>', { desc = 'Next tab', noremap = true })
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move tab to previous', noremap = true })
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { desc = 'Move tab to next', noremap = true })
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { desc = 'Go to 1 tab', noremap = true })
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { desc = 'Go to 2 tab', noremap = true })
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { desc = 'Go to 3 tab', noremap = true })
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { desc = 'Go to 4 tab', noremap = true })
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { desc = 'Go to 5 tab', noremap = true })
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { desc = 'Go to 6 tab', noremap = true })
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { desc = 'Go to 7 tab', noremap = true })
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { desc = 'Go to 8 tab', noremap = true })
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { desc = 'Go to 9 tab', noremap = true })
map('n', '<A-0>', '<Cmd>BufferLast<CR>', { desc = 'Go to last tab', noremap = true })
map('n', '<A-p>', '<Cmd>BufferPin<CR>', { desc = 'Pin/unip tab', noremap = true })
map('n', '<A-w>', '<Cmd>BufferClose<CR>', { desc = 'Close tab', noremap = true })
map('n', '<C-p>', '<Cmd>BufferPick<CR>', { desc = 'Tab picker', noremap = true })
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { desc = 'Order tabs by number', noremap = true })
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', { desc = 'Order tabs by directory', noremap = true })
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', { desc = 'Order tabs by language', noremap = true })
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { desc = 'Order tabs by window number', noremap = true })
map('i', '<C-h>', '<C-w>', { noremap = true })
map('v', '<Leader>wt', '<C-y>,', { desc = '[w]rap HTML [t]ag', noremap = false })


local kmap = vim.keymap.set
local builtin = require('telescope.builtin')

kmap('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
kmap('n', '<leader>h', vim.lsp.buf.hover, { desc = '[H]over' })
kmap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })
kmap('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
kmap('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep' })
kmap('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
kmap('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
kmap('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
kmap('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
kmap('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })
kmap('n', '<leader>ds', builtin.lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
kmap('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

kmap('n', '<leader>xx', "<cmd>Trouble diagnostics toggle<cr>", { desc = 'Open Diagnostics tab' })
kmap('n', '<leader>xw', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = 'Open Buffer Diagnostics tab' })
kmap('n', '<leader>xl', "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
  { desc = 'LSP Definitions / references / ...' })
kmap('n', '<leader>xq', "<cmd>Trouble qflist toggle<cr>", { desc = 'Quick Fix List' })

kmap('n', '<leader>X', "<cmd>bd!<cr>", { desc = 'Close a buffer (force)' })


local spectre = require("spectre")
kmap('n', '<leader>S', function() spectre.toggle() end, { desc = 'Toggle Spectre' })
kmap('n', '<leader>sw', function() spectre.open_visual({ select_word = true }) end, { desc = 'Search current word' })
kmap('v', '<leader>sw', function() spectre.open_visual() end, { desc = 'Search current word' })
kmap('n', '<leader>sp', function() spectre.open_file_search({ select_word = true }) end, { desc = 'Search on current file' })


local conform = require("conform")

kmap("n", "<leader>fm", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { remap = false, desc = 'Format file' })
kmap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
kmap('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
kmap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
kmap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
kmap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
kmap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
kmap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

kmap("n", "<leader>z", "<cmd>Telekasten panel<CR>", { desc = 'Launch panel if nothing is typed after <leader>z' })
kmap("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>", { desc = '[Z]ettelkasten [f]ind' })
kmap("n", "<leader>zs", "<cmd>Telekasten search_notes<CR>", { desc = '[Z]ettelkasten [S]earch notes' })
kmap("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", { desc = '[Z]ettelkasten to[D]ay' })
kmap("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>", { desc = '[Z]ettelkasten follow link' })
kmap("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", { desc = '[Z]ettelkasten [N]ew note' })
kmap("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>", { desc = '[Z]ettelkasten [C]alendar' })
kmap("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", { desc = '[Z]ettelkasten [B]backlinks' })
kmap("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", { desc = '[Z]ettelkasten [I]nsert' })
kmap("n", "<leader>tf", "<cmd>MkdnTableFormat<CR>", { desc = '[T]able [F]ormat' })
kmap("n", "<leader>pv", "<cmd>PeekOpen<CR>", { desc = 'Markdown [P]re[V]iew' })
kmap("i", "[[", "<cmd>Telekasten insert_link<CR>",
  { desc = 'Call insert link automatically when we start typing a link' })

kmap({ 'n', 'v', 'i' }, '<F5>', function() require("knap").process_once() end,
  { desc = 'Processes the document once, and refreshes the view' })
kmap({ 'n', 'v', 'i' }, '<F6>', function() require("knap").close_viewer() end,
  { desc = 'Closes the viewer application, and allows settings to be reset' })
kmap({ 'n', 'v', 'i' }, '<F7>', function() require("knap").toggle_autopreviewing() end,
  { desc = 'Toggles the auto-processing on and off' })
kmap({ 'n', 'v', 'i' }, '<F8>', function() require("knap").forward_jump() end,
  { desc = 'F8 invokes a SyncTeX forward search, or similar, where appropriate' })

local ls = require 'luasnip'
kmap({ "i", "s" }, "<C-j>", function() ls.jump(1) end, { desc = 'Next item in cmp' })
kmap({ "i", "s" }, "<C-k>", function() ls.jump(-1) end, { desc = 'Previous item in cmp' })

kmap("n", "<leader>o", "<cmd>Lf <CR>", { desc = '[O]pen LF in current directory' })
kmap("n", "<leader>O", "<cmd>LfWorkingDirectory<CR>", { desc = '[O]pen LF in working directory' })
kmap("n", "<leader>td", "<cmd>TaskWikiDone<CR>", { desc = '[T]ask [D]done' })
kmap("n", "<leader>tx", "<cmd>TaskWikiDelete<CR>", { desc = 'Delete [T]ask' })

kmap("n", "<leader>pi", "<cmd>call mdip#MarkdownClipboardImage()<CR>", { desc = '[P]aste [I]mage in .md document' })

-- autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

local dap = require 'dap'

-- vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
kmap('n', '<F2>', function() dap.continue() end, { desc = 'Start a new debugging session' })
kmap('n', '<F10>', function() dap.step_over() end, { desc = 'Step over the code in a debugging session' })
kmap('n', '<F11>', function() dap.step_into() end, { desc = 'Step into the code in a debugging session' })
kmap('n', '<F12>', function() dap.step_out() end, { desc = 'Step out the code in a debugging session' })
kmap('n', '<leader>B', function() dap.toggle_breakpoint() end, { desc = 'Toggle a breakpoint in a debugging sesion' })

local dapui = require 'dapui'

kmap('n', '<leader>D', function() dapui.toggle({ reset = true }) end, { desc = 'Toggle a debugger window' })


local smartSplits = require 'smart-splits'

kmap('n', '<C-h>', function() smartSplits.resize_left() end, { desc = 'Resize window to left' })
kmap('n', '<C-j>', function() smartSplits.resize_down() end, { desc = 'Resize window to down' })
kmap('n', '<C-k>', function() smartSplits.resize_up() end, { desc = 'Resize window to up' })
kmap('n', '<C-l>', function() smartSplits.resize_right() end, { desc = 'Resize window to right' })

kmap('n', '<leader><leader>h', function() smartSplits.swap_buf_left() end, { desc = 'Swap window to left' })
kmap('n', '<leader><leader>j', function() smartSplits.swap_buf_down() end, { desc = 'Swap window to down' })
kmap('n', '<leader><leader>k', function() smartSplits.swap_buf_up() end, { desc = 'Swap window to up' })
kmap('n', '<leader><leader>l', function() smartSplits.swap_buf_right() end, { desc = 'Swap window to right' })

kmap('n', '<leader>l', "<cmd>noh<CR>", { desc = 'C[l]ean search' })
