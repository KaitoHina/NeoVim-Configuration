vim.g.mapleader = " "

local keymap = vim.keymap

-- ---------- 插入模式 ---------- ---
keymap.set("i", "jk", "<ESC>", { desc = "退出插入模式" })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "向左縮排" })

-- ---------- 視覺模式 ---------- ---
-- 單行或多行移動
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "將選中行向下移動" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "將選中行向上移動" })
-- 保持縮排模式
keymap.set("v", "<S-Tab>", "<gv", { desc = "向左縮排" })
keymap.set("v", "<Tab>", ">gv", { desc = "向右縮排" })

-- ---------- 正常模式 ---------- ---
-- 縮排
vim.keymap.set("n", "<Tab>", "v><C-\\><CN>", { desc = "向右縮排" })
vim.keymap.set("n", "<S-Tab>", "v<<C-\\><CN>", { desc = "向左縮排" })
-- 視窗
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "水平新增視窗"})
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "垂直新增視窗"})
-- 視窗跳轉 (左/下/上/右)
keymap.set("n", "<leader>h", "<C-w>h", { desc = "跳轉到左側視窗" })
keymap.set("n", "<leader>j", "<C-w>j", { desc = "跳轉到下方視窗" })
keymap.set("n", "<leader>k", "<C-w>k", { desc = "跳轉到上方視窗" })
keymap.set("n", "<leader>l", "<C-w>l", { desc = "跳轉到右側視窗" })

-- 儲存
keymap.set("n", "<C-s>", ":w<CR>", { desc = "儲存文件" })
keymap.set("i", "<C-s>", "<ESC> :w<CR>", { desc = "儲存文件" })

-- 取消高亮
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "取消搜尋高亮" })

-- 切換緩衝區
keymap.set("n", "<C-L>", ":bnext<CR>", { desc = "切換下個緩衝區" })
keymap.set("n", "<C-H>", ":bprevious<CR>", { desc = "切換上個緩衝區" })

-- 終端
keymap.set('n', '<leader>t', ':bot term<CR>', { desc = "打開底部終端" })
keymap.set("t", '<Esc>', '<C-\\><C-n>', { desc = "退出終端模式" })
-- 在終端模式按下 Ctrl+l Ctrl+l 清空畫面並保留滾動歷史限制
vim.keymap.set('t', '<C-l><C-l>', function()
  vim.opt_local.scrollback = 1
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes('iclear<CR>', true, false, true), 't')
  vim.opt_local.scrollback = 10000
end, { desc = "清空終端畫面" })
