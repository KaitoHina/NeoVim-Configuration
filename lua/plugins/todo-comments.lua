-- TODO 註解高亮和導航
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" }, -- 開啟檔案時自動載入
  config = function()
    local todo_comments = require("todo-comments")

    -- 初始化 setup
    todo_comments.setup({
      signs = true, -- 在行號旁邊顯示圖示
      -- 如果你想客製化關鍵字或顏色，可以寫在這裡，否則留空使用預設值即可
    })

    -- 設定快捷鍵 (Keymaps)
    local keymap = vim.keymap

    -- 跳轉到下一個/上一個 TODO
    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "跳轉到下一個 TODO 註解" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "跳轉到上一個 TODO 註解" })

    -- 結合已安裝的 Telescope 來搜尋全域的 TODO
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "在專案中尋找 TODOs" })
  end,
}