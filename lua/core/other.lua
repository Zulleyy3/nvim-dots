-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- -- technically another plugin handles this
-- -- this implementation is mostly for practice and to get more familiar with the NVIM api
vim.api.nvim_set_hl(0, "ExtraWhitespace", {ctermfg="red", ctermbg="red"})
-- vim.fn.matchadd("ExtraWhitespace", [[\s\+$]])
-- vim.api.nvim_create_autocmd(
--   {"BufWinEnter", "InsertLeave"},
--   {callback = function() vim.fn.matchadd("ExtraWhitespace", [[\s\+$]]) end,}
-- )
-- vim.api.nvim_create_autocmd("InsertEnter",
--   {callback = function() vim.fn.matchadd("ExtraWhitespace", [[\s\+\%#\@<!$]]) end,}
-- )
-- vim.api.nvim_create_autocmd("BufWinLeave",
--   {callback = function() vim.fn.clearmatches() end,}
-- )
--
vim.cmd([[
" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
]])

