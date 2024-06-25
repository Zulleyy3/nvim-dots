-- A configuration file for anything related to nvim's diagnostic functions

-- Helper functions
local display_diagnostic_float = function()
  local opts = {
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    border = "rounded",
    source = "always",
    prefix = " ",
    scope = "cursor",
  }
  vim.diagnostic.open_float(nil, opts)
end

local error_only = function (f)
  local opts = {
    severity = vim.diagnostic.severity.ERROR,
  }
  return function ()
    f(opts)
  end
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '[e', error_only(vim.diagnostic.goto_prev), { desc = 'Go to previous diagnostic error message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', ']e', error_only(vim.diagnostic.goto_next), { desc = 'Go to next diagnostic error message' })
vim.keymap.set('n', '<leader>df', display_diagnostic_float, { desc = 'Open floating [d]iagnostic [f]loat message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [d]iagnostics [l]ist' })
vim.keymap.set('n', '<leader>de', error_only(vim.diagnostic.setloclist), { desc = 'Open [d]iagnostics [e]rror list' })


-- vim.cmd([[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
