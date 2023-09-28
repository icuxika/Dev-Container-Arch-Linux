-- 自动安装packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
-- packer.lua 要适应本地文件名字
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
  -- 插件管理
  use "wbthomason/packer.nvim"
  -- 主题
  use 'folke/tokyonight.nvim'
  use "hardhackerlabs/theme-vim"
  -- 图标
  use 'nvim-tree/nvim-web-devicons'
  -- 状态栏
  use 'nvim-lualine/lualine.nvim'
  -- 文档树
  use 'nvim-tree/nvim-tree.lua'
  -- ctrl + hjkl 切换左下上右
  use 'christoomey/vim-tmux-navigator'
  -- 语法高亮
  use 'nvim-treesitter/nvim-treesitter'
  -- 配合treesitter，不同括号颜色区分
  use 'p00f/nvim-ts-rainbow'
  -- LSP 插件
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use 'nvimdev/lspsaga.nvim'
  -- 自动补全
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip" -- snippets引擎，不装这个自动补全会出问题
  use "saadparwaiz1/cmp_luasnip"
  use "rafamadriz/friendly-snippets"
  use "hrsh7th/cmp-path" -- 文件路径
  -- gcc和gc注释
  use "numToStr/Comment.nvim"
  -- 自动补全括号
  use "windwp/nvim-autopairs"
  -- buffer分割线
  use "akinsho/bufferline.nvim"
  -- 左则git提示
  use "lewis6991/gitsigns.nvim"
  -- 文件检索
  use "nvim-lua/plenary.nvim"
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1'
  }
  -- 浮窗控制台
  use 'voldikss/vim-floaterm'
  -- DAP
  use "mfussenegger/nvim-dap"
  use "jay-babu/mason-nvim-dap.nvim"
  use "rcarriga/nvim-dap-ui"
  use "theHamsta/nvim-dap-virtual-text"
  -- git diff
  use "sindrets/diffview.nvim"
  -- nvim tmux键位协调
  use "alexghergh/nvim-tmux-navigation"
  -- 控制台
  use "akinsho/toggleterm.nvim"
  -- cmake
  use "Civitasv/cmake-tools.nvim"
  -- rust
  use 'simrat39/rust-tools.nvim'

  -- 自动安装packer.nvim后安装以上插件
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
