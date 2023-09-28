local dap = require('dap')

-- dap.defaults.fallback.terminal_win_cmd = function ()
--   local Terminal = require("toggleterm.terminal")
--   local newTerm = Terminal:new({
--     clear_env = true
--   })
--   newTerm:toggle()
--   return newTerm.bufnr, newTerm.window
-- end

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = 'codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local dapui = require("dapui")
dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
  print('init')
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  print('term')
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  print('exit')
  dapui.close()
end

require("nvim-dap-virtual-text").setup()
