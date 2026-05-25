-- Git 插件配置
return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      -- 使用預設屬性設定 GitSigns
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },           -- 新增行
          change = { text = "~" },        -- 修改行
          delete = { text = "_" },        -- 刪除行
          topdelete = { text = "‾" },     -- 刪除行（頂部）
          changedelete = { text = "~" },  -- 修改並刪除行
        },
      })

      -- 普通模式下預覽遊標下檔案的變更。
      vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", {desc="[G]it Preview [H]unk"})
    end
  },
  {
    "tpope/vim-fugitive",
    config = function()
      -- 查看文件的最新貢獻者
      vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", {desc="[G]it [B]lame"})
      -- 將所有更改的文件添加到暫存區
      vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", {desc = "[G]it Add [A]ll"})
      -- 將當前文件和更改添加到暫存區
      vim.keymap.set("n", "<leader>ga", "Git add", {desc = "[G]it [A]dd"})
      -- 提交當前更改
      vim.keymap.set("n", "<leader>gc", ":Git commit", {desc = "[G]it [C]ommit"})
      -- 將提交的更改推送到遠程倉庫
      vim.keymap.set("n", "<leader>gp", "Git push", {desc = "[G]it [P]ush"})
    end
  }
}