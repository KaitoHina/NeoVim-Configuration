-- 強大的模糊搜尋器
return {
{ -- Telescope
  'nvim-telescope/telescope.nvim', 
  version = '*', 
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- optional but recommended
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    -- 使用望遠鏡內建功能
    local builtin = require('telescope.builtin')
    local keymap = vim.keymap
    -- 設定 vim 快速鍵 <空白鍵> + f + f，按檔案名稱搜尋檔案。
    keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles"})
    -- 設定 vim 快速鍵 <空白鍵> + f + g，按檔案內容搜尋檔案。
    keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "[F]ind by [G]rep"})
    -- 設定 vim 快速鍵 <空白鍵> + f + d，搜尋程式碼診斷資訊。
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    -- 設定 vim 快速鍵 <空白鍵> + f + r，恢復上一次的搜尋。
    keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]inder [R]esume' })
    -- 設定 vim 快速鍵 <空白鍵> + f + .，搜尋最近使用的檔案。
    keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    -- 設定 vim 快速鍵 <空白鍵> + f + b，搜尋開啟的緩衝區。
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Existing [B]uffers' })
  end
},
{ -- telescope-ui-select
  'nvim-telescope/telescope-ui-select.nvim',
  config = function()
    -- get access to telescopes navigation functions
    local actions = require("telescope.actions")
    require("telescope").setup({
      -- use ui-select dropdown as our ui
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      },
      -- set keymappings to navigate through items in the telescope io
      mappings = {
        i = {
          -- use <cltr> + n to go to the next option
          ["<C-n>"] = actions.cycle_history_next,
          -- use <cltr> + p to go to the previous option
          ["<C-p>"] = actions.cycle_history_prev,
          -- use <cltr> + j to go to the next preview
          ["<C-j>"] = actions.move_selection_next,
          -- use <cltr> + k to go to the previous preview
          ["<C-k>"] = actions.move_selection_previous,
        }
      },
      -- load the ui-select extension
      require("telescope").load_extension("ui-select")
    })
  end
}
}