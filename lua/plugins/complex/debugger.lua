return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    -- Installs the debug adapters for you
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    "mfussenegger/nvim-dap-python",
  },
  config = function()
    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")

    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, { desc = "Debug: Start/Continue" })

    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end, { desc = "Debug: Step Over" })

    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end, { desc = "Debug: Step Over" })

    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<Leader>b", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Debug: Toggle Breakpoint" })

    vim.keymap.set("n", "<Leader>B", function()
      require("dap").set_breakpoint()
    end, { desc = "Debug: Set Breakpoint" })

    vim.keymap.set("n", "<Leader>dlp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Debug: Breakpoint with log " })

    vim.keymap.set("n", "<Leader>dbr", function()
      require("dap").repl.open()
    end, { desc = "Debug:: Open REPL" })

    vim.keymap.set("n", "<Leader>dbl", function()
      require("dap").run_last()
    end, { desc = "Debug: Rerun Last Config" })

    -- vim.keymap.set({ "n", "v" }, "<Leader>dbh", function()
    -- 	require("dap.ui.widgets").hover()
    -- end, { desc = "Debug: Step Over" })
    --
    vim.keymap.set({ "n", "v" }, "<Leader>dsr", function()
      require("dap.ui").toggle()
    end, { desc = "Debug: Last Session Result" })

    -- vim.keymap.set({ "n", "v" }, "<Leader>dbp", function()
    -- 	require("dap.ui.widgets").preview()
    -- end, { desc = "Debug: Step Over" })
    --
    vim.keymap.set("n", "<Leader>dbf", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { desc = "Debug: Show Stackframe?" })
    --
    vim.keymap.set("n", "<Leader>dbs", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { desc = "Debug: Show Scope?" })

    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- dap.listeners.before.attach.dapui_config = function()
    -- 	dapui.open()
    -- end
    -- dap.listeners.before.launch.dapui_config = function()
    -- 	dapui.open()
    -- end
    -- dap.listeners.before.event_terminated.dapui_config = function()
    -- 	dapui.close()
    -- end
    -- dap.listeners.before.event_exited.dapui_config = function()
    -- 	dapui.close()
    -- end
    require("dap-python").setup("python")
    table.insert(require("dap").configurations.python, {
      type = "python",
      request = "launch",
      name = "My custom launch configuration",
      program = "${file}",
      justMyCode = false,
    })
  end,
}
