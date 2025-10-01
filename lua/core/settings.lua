-- [[ Setting options ]] See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'
vim.o.mousem= 'extend'
-- TODO :help mousemodel

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  bind to mousewheel buffer
vim.o.clipboard = 'unnamed'


-- Tab-Length
vim.o.tabstop = 8
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.api.nvim_create_autocmd('FileType', {
  pattern = {"c", "cpp"},
  callback = function()
    vim.bo.expandtab = false
  end,
})

-- Enable break indent
vim.o.breakindent = true

-- Do not save undo history
vim.o.undofile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
-- TODO what to do how
vim.wo.signcolumn = 'auto'

-- Decrease update time
vim.o.updatetime = 1000 -- every second
-- vim.o.timeoutlen = 1000  -- time to wait for a mapped sequenc to complete

-- Set completeopt to have a better completion experience
-- TODO try this out and see how it feels
vim.o.completeopt = 'menuone,noselect'

-- default off
vim.o.termguicolors = false

local ok, _ = pcall(vim.cmd, 'colorscheme vimdefaultmodified')
if not ok then
  vim.cmd 'colorscheme default' -- if the above fails, then use default
  -- and set the termguicolors if available
  if (vim.env.TMUX == nil and vim.env.TERM_PROGRAM ~= "Apple_Terminal")
    then
    if vim.fn.has("nvim")
    then
      vim.env.NVIM_TUI_ENABLE_TRUE_COLOR=1
    end
    if vim.fn.has("termguicolors")
    then
      vim.o.termguicolors = true
    end
  end
end

-- Split behaviour
vim.o.splitbelow = true
vim.o.splitright = true

-- Indicate wrapped lines
vim.o.showbreak = ">>>>"
