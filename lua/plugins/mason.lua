-- 設定 Mason 和 mason-lspconfig 以安裝和管理 LSP 伺服器
return {
  -- Mason: 安裝和管理 LSP 伺服器、DAP 等工具
  { "williamboman/mason.nvim",
    config = function()
      -- 啟動 Mason 並使用預設設定
      require("mason").setup()
    end
  },
  -- mason-lspconfig: 橋接 Mason 和 lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- 啟動 mason-lspconfig 並確保安裝指定的 LSP 伺服器
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",        -- Lua
          "pyright",       -- Python
          "ts_ls",         -- JavaScript / TypeScript / TSX
          "clangd",        -- C / C++
          "bashls",        -- Bash
          "jsonls",        -- JSON
          "cssls",         -- CSS
          "rust_analyzer", -- Rust
          "marksman",      -- Markdown
          "jdtls",         -- Java
          "intelephense",  -- PHP
        },
      })
    end
  },
  -- mason-nvim-dap: 使用 Mason 管理 DAP（Debug Adapter Protocol）適配器
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      -- 啟動 mason-nvim-dap 並確保安裝指定的 DAP 適配器
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python",             -- Python: debugpy
          "codelldb",           -- C / C++
          -- "java-debug-adapter", -- Java 調試
          -- "java-test",          -- Java 測試
        },
        handlers = {},
      })
    end
  },
  -- mason-tool-installer: 使用 Mason 安裝和管理其他工具
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- 指定要安裝的工具列表
        "java-debug-adapter",
        "java-test",
      },
      -- 在啟動時自動運行安裝
      run_on_start = true,
      -- 在啟動時自動更新已安裝的工具
      auto_update = true,
    },
  }
}