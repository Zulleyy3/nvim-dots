--[[
Initially based on Kickstart.nvim  
Simple Lua description, helpful.
  - https://learnxinyminutes.com/docs/lua/
How Lua works in Neovim:
  - https://neovim.io/doc/user/lua-guide.html

Left some of the notes from kickstart.vim in the files, because they are genuinely helpful.
Thank you TJ for providing kickstart.vim and writing all the notes!
]]

--[[config directories:
  - lua/core: Configures built-in nvim functionality directly
  - lua/plugins: installs plugin manager and plugins
  - lua/plugins/cfg/: handles plugin specific configuration and keymaps
]]

--[[Load the basic keymaps 
As this includes setting the leader, do this before loading plugins (to set the right leader)
]]
require("core.remaps")

--[[Configure nvim]]
require("core.settings")

-- Only load Plugins when not calling from vscode
if not vim.g.vscode then
  --[[Load Plugins]]
  -- Install package manager
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  -- Autoinclude all files in plugins
  require("lazy").setup("plugins.list")

  -- Load related configuration
  require("plugins.cfg")
end

--[[Keybinds and settings related to nvim diagnostics]]
require("core.diagnostic")

--[[Include other things like custom highlighting and autocmd]]
require("core.other")


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
