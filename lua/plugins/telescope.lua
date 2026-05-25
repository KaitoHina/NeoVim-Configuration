-- 強大的模糊搜尋器
return {
{ -- Telescope
  'nvim-telescope/telescope.nvim', 
  version = '*', 
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 可選但建議安裝（提供更快的 fzf 效能）
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    -- 使用望遠鏡內建功能
    local builtin = require('telescope.builtin')
    local keymap = vim.keymap  -- <leader> 是空格鍵，這裡用於觸發搜尋功能
    -- 依檔名搜尋檔案
    keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles"})
    -- 依內容搜尋檔案
    keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "[F]ind by [G]rep"})
    -- 搜尋游標下的單字 (跨檔案)
    keymap.set('n', '<leader>fw', builtin.grep_string, {desc = "[F]ind current [W]ord"})
    -- 搜尋當前檔案內容
    keymap.set('n', '<leader>f/', builtin.current_buffer_fuzzy_find, {desc = "[F]ind word in current file"})
    -- 搜尋診斷資訊
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    -- 恢復上一次的搜尋
    keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]inder [R]esume' })
    -- 搜尋最近使用的檔案
    keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    -- 搜尋開啟的緩衝區
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Existing [B]uffers' })
  end
},
{ -- telescope-ui-select 擴充
  'nvim-telescope/telescope-ui-select.nvim',
  config = function()
    -- 取得 Telescope 的導覽相關函式
    local actions = require("telescope.actions")
    require("telescope").setup({
      -- 使用 ui-select 的下拉樣式作為介面
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      },
      -- 設定快捷鍵以在 Telescope 列表中導航
      mappings = {
        i = {
          -- 使用 <Ctrl>+n 移到下一項
          ["<C-n>"] = actions.cycle_history_next,
          -- 使用 <Ctrl>+p 移到前一項
          ["<C-p>"] = actions.cycle_history_prev,
          -- 使用 <Ctrl>+j 移到下一個預覽項目
          ["<C-j>"] = actions.move_selection_next,
          -- 使用 <Ctrl>+k 移到上一個預覽項目
          ["<C-k>"] = actions.move_selection_previous,
        }
      },
      -- 載入 ui-select 擴充
      require("telescope").load_extension("ui-select")
    })
  end
}
}