-- [[ Basic Keymaps ]]
-- Leader must be set before plugins so load this file before loading any plugins please 

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Map Nohl
vim.keymap.set('n', '<leader>n', function() vim.cmd("nohl") end, { desc = 'Remove Highlights' })

-- Swap lines up and down
vim.keymap.set('n', '<c-j>', 'ddp', {silent = true})
vim.keymap.set('n', '<c-k>', 'ddkP', {silent = true})
vim.keymap.set('v', '<c-j>', 'dp', {silent = true})
vim.keymap.set('v', '<c-k>', 'dkP', {silent = true})

-- Map a more convenient mapping for system clipboard
vim.keymap.set({ 'n' , 'v'}, '<leader>c', '\"+', { desc = 'Select system clipboard register' })
if vim.g.vscode then
  -- Calling from VSCode
  vim.api.nvim_set_keymap('x','gc',  "<Plug>VSCodeCommentary",     {})
  vim.api.nvim_set_keymap('n','gc',  "<Plug>VSCodeCommentary",     {})
  vim.api.nvim_set_keymap('o','gc',  "<Plug>VSCodeCommentary",     {})
  vim.api.nvim_set_keymap('n','gcc', "<Plug>VSCodeCommentaryLine", {})
end
