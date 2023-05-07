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

  use {
    -- 状态栏
    'nvim-lualine/lualine.nvim',
    -- 状态栏图标
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {
    -- 文档树
    'nvim-tree/nvim-tree.lua',
    -- 文档树图标
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  -- ctrl + hjkl 切换左下上右
  use 'christoomey/vim-tmux-navigator'

  -- 语法高亮
  use 'nvim-treesitter/nvim-treesitter'

  -- 配合treesitter，不同括号颜色区分
  use 'p00f/nvim-ts-rainbow'

  -- LSP 插件
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

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
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)
