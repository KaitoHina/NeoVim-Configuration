-- 主題套件
return {
  "rebelot/kanagawa.nvim",
  -- "folke/tokyonight.nvim",
  lazy = false,    -- 啟動neovim時載入這個主題
  priority = 1000, -- 確保這個主題在其他套件之前載入
  config = function()
    -- require("kanagawa").setup({
    --   transparent = true, -- 開啟透明背景
    -- })
    -- 設定主題
    vim.cmd.colorscheme("kanagawa")
    -- vim.cmd.colorscheme("tokyonight-moon") -- 使用 moon 變體
  end,
}
