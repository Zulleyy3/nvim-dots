-- [[ Setting options ]] See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'
-- TODO :help mousemodel

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--  bind to mousewheel buffer
vim.o.clipboard = 'unnamed'

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

-- NOTE: You should make sure your terminal supports this
-- TODO set terminal colors how i like it
vim.o.termguicolors = false

-- Split behaviour
vim.o.splitbelow = true
vim.o.splitright = true

-- Indicate wrapped lines
vim.o.showbreak = ">>>>"
