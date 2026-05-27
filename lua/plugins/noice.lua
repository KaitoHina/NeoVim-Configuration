-- noice.nvim: 美化 Neovim 的訊息、命令列和 LSP 懸浮窗
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim", -- 必須依賴
    "rcarriga/nvim-notify", -- 推薦，用於通知美化
    "nvim-lua/plenary.nvim", -- 某些功能需要
  },
  opts = {
    -- 關鍵：關閉 noice 自帶的 LSP hover，避免與 pretty_hover 衝突
    lsp = {
      hover = {
        enabled = false,
      },
      signature = {
        enabled = true, -- 簽名幫助仍可使用
      },
    },
    -- 其他常規配置（可依喜好調整）
    cmdline = {
      enabled = false, -- 美化命令列
    },
    messages = {
      enabled = false, -- 美化訊息歷史
    },
    popupmenu = {
      enabled = false, -- 美化輸入選單
    },
    notify = {
      enabled = true, -- 使用 nvim-notify
    },
  },
  -- 可選：新增快捷鍵快速查看訊息歷史
  keys = {
    { "<leader>nn", "<cmd>Noice<CR>", desc = "Noice History" },
    { "<leader>nd", "<cmd>Noice dismiss<CR>", desc = "Dismiss All Notifications" },
  },
}