require("toggleterm").setup{
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  autochdir = false,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  direction = 'horizontal',
  shell = vim.o.shell,
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', opts)
