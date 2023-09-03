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

-- technically another plugin handles this
-- vim.cmd([[
-- " Highlight trailing spaces
-- " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
-- highlight ExtraWhitespace ctermbg=red guibg=red
-- match ExtraWhitespace /\s\+$/
-- autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
-- autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
-- autocmd InsertLeave * match ExtraWhitespace /\s\+$/
-- autocmd BufWinLeave * call clearmatches()
-- ]])

