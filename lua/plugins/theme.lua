-- 主題套件
return { 
  "rebelot/kanagawa.nvim",
  lazy = false, -- 啟動neovim時載入這個主題
  priority = 1000, -- 確保這個主題在其他套件之前載入
  config = function()
    -- 設定主題
    vim.cmd.colorscheme("kanagawa")
  end,
}