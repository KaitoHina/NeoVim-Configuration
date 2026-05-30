-- 設定 LSP 客戶端
return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",                  -- 打開檔案後才載入
  dependencies = {
    "williamboman/mason-lspconfig.nvim", -- 確保 mason 已載入
    "hrsh7th/cmp-nvim-lsp",              -- 為了 capabilities（維持原始 nvim-cmp 依賴）
  },
  config = function()
    -- ========== Neovim LSP 診斷顯示設定 ==========
    vim.diagnostic.config({
      signs = { text = { error = "●", warn = "●", info = "●", hint = "●" } },
      virtual_text = { prefix = "●", spacing = 4, source = "if_many" },
      underline = true,
      severity_sort = true,
      update_in_insert = true,
    })

    -- ========== 波浪線高亮 ==========
    vim.cmd.highlight("DiagnosticUnderlineError", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineWarn", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineInfo", "gui=undercurl")
    vim.cmd.highlight("DiagnosticUnderlineHint", "gui=undercurl")

    -- ========== LSP 通用能力 (使用 nvim-cmp 的 lsp 來源) ==========
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local project_root = vim.fn.getcwd()

    -- ========== 自動設定其他透過 Mason 安裝的伺服器 ==========
    for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
      local server_config = { capabilities = capabilities }

      -- jdtls 由 nvim-jdtls 管理，不使用 nvim-lspconfig 設定
      if server == "jdtls" then goto continue end

      -- 如果是 clangd，加入特定參數並設定 on_new_config 以處理 compile_commands.json 的變化
      if server == "clangd" then
        -- 加入 clangd 特定參數，啟用背景索引和 clang-tidy 支持
        server_config.cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
        }
        -- 當 clangd 的配置被更新（例如 compile_commands.json 變化）時，重啟 LSP 以讓變更生效
        server_config.on_new_config = function(new_config, new_cwd)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end
      end
      -- 使用 nvim-lspconfig 設定並啟用 LSP 伺服器
      vim.lsp.config(server, server_config)
      vim.lsp.enable(server)
      ::continue::
    end

    -- ========== 儲存時對所有 LSP 自動格式化 ==========
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- 確認該 LSP 是否支援格式化功能
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.server_capabilities.documentFormattingProvider then
          -- 當緩衝區被寫入前，呼叫 LSP 的格式化功能，並確保使用正確的 LSP 伺服器（透過 client_id）
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = ev.buf,
            callback = function()
              vim.lsp.buf.format({ async = false, id = ev.data.client_id })
            end,
          })
        end
      end,
    })

    -- ========== 通用 LSP 快捷鍵 ==========
    local keymap = vim.keymap
    -- 設定 Vim 快速鍵: 顯示遊標下程式碼的懸停文件。
    keymap.set("n", "<leader>ch", function() require("pretty_hover").hover() end, { desc = "[C]ode [H]over Documentation" })

    -- 設定 Vim 快速鍵: 跳轉到遊標下程式碼的定義位置。
    keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })

    -- 設定 Vim 快速鍵: 在普通模式和視覺模式下顯示代碼診斷的操作建議。
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })

    -- 設定 Vim 快速鍵: 顯示游標下程式碼的參考 (references)
    keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })

    -- 設定 Vim 快速鍵: 顯示游標下程式碼的實作 (implementations)
    keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })

    -- 設定 Vim 快速鍵: 重新命名游標下的符號
    keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })

    -- 設定 Vim 快速鍵: 跳至專案中該程式碼/物件被宣告的位置（宣告處）
    keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })

    -- 設定 Vim 快速鍵: 格式化當前文件
    keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, { desc = "[C]ode [F]ormat" })

    -- 設定 Vim 快速鍵: 啟用 LSP 伺服器
    keymap.set("n", "<leader>pe", "<cmd>lsp enable<CR>", { desc = "Ls[p] [e]nable" })

    -- 設定 Vim 快速鍵: 停止 LSP 伺服器
    keymap.set("n", "<leader>pd", "<cmd>lsp disable<CR>", { desc = "Ls[p] [d]isable" })

    -- 設定 Vim 快速鍵: 停止 LSP 伺服器 (當檔案卡住或 compile_commands.json 更新但沒反應時使用)
    keymap.set("n", "<leader>ps", "<cmd>lsp stop<CR>", { desc = "Ls[p] [s]top" })

    -- 設定 Vim 快速鍵: 重啟 LSP 伺服器 (當檔案卡住或 compile_commands.json 更新但沒反應時使用)
    keymap.set("n", "<leader>pr", "<cmd>lsp restart<CR>", { desc = "Ls[p] [r]estart" })

    -- 診斷與格式化
    keymap.set("n", "<leader>Di", vim.diagnostic.open_float, { desc = "Open [D]iagnostics [I]nfo" })
    keymap.set("n", "<leader>D[", vim.diagnostic.goto_prev, { desc = "Prev [D]iagnostic" })
    keymap.set("n", "<leader>D]", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
    local function toggle_all_diagnostics()
      if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false)
        vim.notify("All Diagnostics OFF", "info", { title = "LSP" })
      else
        vim.diagnostic.enable(true)
        vim.notify("All Diagnostics ON", "info", { title = "LSP" })
      end
    end
    vim.keymap.set("n", "<leader>Dt", toggle_all_diagnostics, { desc = "[D]iagnostics [T]oggle All" })
  end
}