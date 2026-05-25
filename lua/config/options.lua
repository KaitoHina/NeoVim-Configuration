local opt = vim.opt

-- 行號
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2

-- 縮排
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true

-- 不自動換行
opt.wrap = false

-- 游標行
opt.cursorline = true

-- 啟用滑鼠
opt.mouse:append("a")

-- 系統剪貼簿
opt.clipboard:append("unnamedplus")

-- 預設新視窗開在右側和下方
opt.splitright = true
opt.splitbelow = true

-- 搜尋
opt.ignorecase = true
opt.smartcase = true

-- 外觀
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8       -- 游標上下至少保留8行
opt.sidescrolloff = 8   -- 游標左右至少保留8列

-- 文件編碼
opt.fileencoding = "uft-8"

-- 終端窗口設定：打開終端時自動調整大小
vim.api.nvim_create_augroup('TerminalSettings', { clear = true })
vim.api.nvim_create_autocmd('TermOpen', {
  group = 'TerminalSettings',
  pattern = '*', -- 所有终端窗口都生效
  callback = function()
    -- 设置终端窗口的大小。
    vim.cmd('resize 8')
  end,
})
