-- 檔案瀏覽器
return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- 設定快捷鍵，<leader>e 用於切換檔案瀏覽器
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "切換 [E]xplorer" })

    -- 自訂 on_attach 函式來設定快捷鍵
    local function my_on_attach(bufnr)
      local api = require "nvim-tree.api"
      -- 載入預設快捷鍵
      api.config.mappings.default_on_attach(bufnr)
      -- 綁定 d 鍵從「永久刪除」改為「移動到回收站」
      vim.keymap.set("n", "d", api.fs.trash, { buffer = bufnr, desc = "移至回收站" })
      -- 綁定 <leader>[ 退回上一層並設為根目錄
      vim.keymap.set("n", "<leader>[", api.tree.change_root_to_parent, { buffer = bufnr, desc = "CD .." })
      -- 綁定 <leader>] 進入當前資料夾並設為根目錄
      vim.keymap.set("n", "<leader>]", api.tree.change_root_to_node, { buffer = bufnr, desc = "CD folder" })
    end

    -- 圖示設定
    local renderer_config = {
      group_empty = true, -- 合併空目錄 (例如 Java packages)
      -- 顯示縮排引導線
      indent_markers = { enable = true },
      icons = {
        show = {
          file = true,         -- 顯示檔案圖示
          folder = true,       -- 顯示資料夾圖示
          folder_arrow = true, -- 顯示資料夾箭頭圖示
          git = true,          -- 顯示 git 狀態圖示
        }
      },
    }

    -- 設定 nvim-tree
    require("nvim-tree").setup({
      hijack_netrw = true,       -- 接管 netrw 的功能
      update_cwd = true,         -- 切換目錄時更新工作目錄
      sync_root_with_cwd = true, -- 同步根目錄與工作目錄
      actions = {
        change_dir = {
          global = true, -- 全局切換目錄
        },
      },
      auto_reload_on_write = true, -- 寫入檔案後自動重新載入
      on_attach = my_on_attach,    -- 使用自訂的 on_attach 函式
      renderer = renderer_config   -- 使用自訂的圖示設定
    })

    -- 在 Vim 啟動時自動打開 nvim-tree
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   callback = function()
    --     require("nvim-tree.api").tree.open()
    --   end,
    -- })
  end
}

