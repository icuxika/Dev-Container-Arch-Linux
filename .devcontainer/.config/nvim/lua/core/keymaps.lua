-- 主键设置为空格
vim.g.mapleader = " "

local keymap = vim.keymap

-- ----------视觉模式----------
-- 单行或多行移动
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ----------正常模式----------
-- 窗口
keymap.set("n", "<leader>sv", "<C-w>v") -- 水平新增窗口
keymap.set("n", "<leader>sh", "<C-w>s") -- 垂直新增窗口

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- ----------插件----------
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
-- 切换buffer
keymap.set("n", "<leader>l", ":BufferLineCycleNext<CR>")
keymap.set("n", "<leader>h", ":BufferLineCyclePrev<CR>")
-- 关闭指定buffer
keymap.set("n", "<leader>q", ":BufferLinePickClose<CR>")
-- 关闭其他buffer
keymap.set("n", "<leader>Q", ":BufferLineCloseOthers<CR>")

-- 在浮窗编译并显示单个文件C++程序结果，%对应文件名称如main.cpp，%<等价于main
keymap.set("n", "<leader>rc", ":FloatermNew --autoclose=0 gcc -lstdc++ -g % -o %< && ./%<<CR>")

-- dap
keymap.set({"i", "n", "v"}, "<F5>", "<cmd>lua require'dap'.continue()<CR>")
keymap.set({"i", "n", "v"}, "<F6>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
keymap.set({"i", "n", "v"}, "<F7>", "<cmd>lua require'dap'.step_over()<CR>")
keymap.set({"i", "n", "v"}, "<F8>", "<cmd>lua require'dap'.step_into()<CR>")
keymap.set({"i", "n", "v"}, "<F9>", "<cmd>lua require'dap'.step_out()<CR>")
keymap.set({"i", "n", "v"}, "<F10>", "<cmd>lua require'dap'.run_last()<CR>")

-- cmake
keymap.set("n", "<leader>cpc", "<cmd>CMakeSelectConfigurePreset<CR>")
keymap.set("n", "<leader>cpb", "<cmd>CMakeSelectBuildPreset<CR>")
keymap.set("n", "<leader>cb", "<cmd>CMakeBuild<CR>")
keymap.set("n", "<leader>cla", "<cmd>CMakeLaunchArgs<CR>")
keymap.set("n", "<leader>cr", "<cmd>CMakeRun<CR>")

-- nvim-lspconfig start ----------------------------------------
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
vim.keymap.set('n', 'gp', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gn', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gq', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', 'gt', '<cmd>Lspsaga outline<CR>', opts)
  end,
})
-- nvim-lspconfig end ----------------------------------------
