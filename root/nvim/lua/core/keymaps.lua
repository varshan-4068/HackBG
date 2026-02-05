vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle<CR>')

vim.keymap.set("v", "<Tab>", ">gv")

-- stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

--keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

--keybindings for fzf
vim.keymap.set('n', '<leader>zf', '<cmd>FzfLua files<cr>')

vim.keymap.set('n', '<leader>z', '<cmd>FzfLua zoxide<cr>')

vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers<cr>')

vim.keymap.set('n', '<leader>fh', '<cmd>FzfLua oldfiles<cr>')

--keybinding for code actions

vim.keymap.set('n', '<C-a>', vim.lsp.buf.code_action, opts)


--keybinding for buffers

vim.keymap.set('n', '<C-p>', '<cmd>Bdelete<CR>')

vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>')

vim.keymap.set('n', '<S-l>', '<cmd>:bnext<CR>')

--keybinding for recording a macro

vim.keymap.set('n', '<C-r>', 'qa')

--keybinding for non-arrow movements in nvim

vim.keymap.set('i', '<C-h>', '<Left>')

vim.keymap.set('i', '<C-l>', '<Right>')

vim.keymap.set('i', '<C-j>', '<Down>')

vim.keymap.set('i', '<C-k>', '<Up>')

--keybinding for formatting	

vim.keymap.set('n', '<C-g>', vim.lsp.buf.format, {})

--keybindings for .md file format rendering

vim.keymap.set('n', '<leader>rd', '<cmd> RenderMarkdown disable<CR>')

vim.keymap.set('n', '<leader>re', '<cmd> RenderMarkdown enable<CR>')

vim.keymap.set('n', '<leader>rt', '<cmd> RenderMarkdown toggle<CR>')

vim.keymap.set('n', '<leader>rl', '<cmd> RenderMarkdown log<CR>')

--keymap for urlview 

vim.keymap.set("n", "<leader>u", "<Cmd>UrlView<CR>", { desc = "View buffer URLs" })

--keymap for typr 

vim.keymap.set("n", "<leader>t", "<Cmd>Typr<CR>")

vim.keymap.set("n", "<leader>ts", "<Cmd>TyprStats<CR>")

--keymap for diagnostics window

vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
