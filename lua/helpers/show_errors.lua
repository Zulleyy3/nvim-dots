local M = {}

---@param severity vim.diagnostic.Severity
function M.show_errors_in_window(severity)
  -- local lines = vim.print(vim.diagnostic.get(0, {severity=severity}))
  local lines = vim.split(vim.inspect(vim.diagnostic.get(0, {severity=severity})), "\n")
  local buf_handle = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf_handle, 0, -1, false, lines)
  vim.api.nvim_open_win(buf_handle, false, {
    split = "below",
    vertical = true,
  })
end

return M
