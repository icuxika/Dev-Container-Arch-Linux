require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "clangd", "cmake" },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities
  }
)

lspconfig.lua_ls.setup {}

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--all-scopes-completion", -- 全局补全(补全建议会给出在当前作用域不可见的索引,插入后自动补充作用域标识符),例如在main()中直接写cout,即使没有`#include <iostream>`,也会给出`std::cout`的建议,配合"--header-insertion=iwyu",还可自动插入缺失的头文件
    "--background-index", -- 后台分析并保存索引文件
    "--clang-tidy", -- 启用 Clang-Tidy 以提供「静态检查」
    "--completion-parse=auto", -- 当 clangd 准备就绪时，用它来分析建议
    "--enable-config",
    "--fallback-style=LLVM", -- 默认格式化风格: 在没找到 .clang-format 文件时采用,可用的有 LLVM, Google, Chromium, Mozilla, Webkit, Microsoft, GNU
    "--function-arg-placeholders=true", -- 补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符，乃至函数末
    "--header-insertion=iwyu", -- 插入建议时自动引入头文件 iwyu
    "--header-insertion-decorators", -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
    "-j=12", -- 同时开启的任务数量
    "--log=verbose", -- 让 Clangd 生成更详细的日志
    "--pretty", -- 输出的 JSON 文件更美观
  }
}

lspconfig.cmake.setup {
  cmd = {"cmake-language-server"},
  filetypes = {"cmake"},
  init_options = {
    buildDirectory = "out/build/default"
  },
}

local on_attach = function(client)
  require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup({
  on_attach=on_attach,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})

local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end

saga.setup({
})
