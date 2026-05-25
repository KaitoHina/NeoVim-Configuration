-- nvim-cmp: 自動補全引擎
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",      -- 進入插入模式後才載入
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",         -- LSP 補全來源
    "hrsh7th/cmp-buffer",           -- 當前緩衝區補全來源
    "hrsh7th/cmp-path",             -- 檔案路徑補全來源
    "L3MON4D3/LuaSnip",             -- 程式碼片段引擎
    "saadparwaiz1/cmp_luasnip",     -- 片段補全來源
    "rafamadriz/friendly-snippets", -- 預設程式碼片段
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").lazy_load() -- 載入 vscode 風格片段

    -- 輔助函數：判斷游標前是否有單字字元（用於 Tab 鍵補全）
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      -- 定義補全選單的行為
      completion = {
          -- menu: display options in a menu
          -- menuone: automatically select the first option of the menu
          -- preview: automatically display the completion candiate as you navigate the menu
          -- noselect: prevent neovim from automatically selecting a completion option while navigating the menu
          competeopt = "menu,menuone,preview,noselect"
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- 展開片段
        end,
      },
      -- 定義鍵盤映射
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),           -- 向上捲動檔案
        ["<C-f>"] = cmp.mapping.scroll_docs(4),            -- 向下捲動檔案
        ["<C-e>"] = cmp.mapping.abort(),                   -- 取消補全
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 確認選擇

        -- Tab 鍵：智慧行為
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()                     -- 補全選單中下一項
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()                   -- 展開片段或跳轉下一個佔位符
          elseif has_words_before() then
            cmp.complete()                             -- 手動觸發補全
          else
            fallback()                                 -- 普通 Tab 鍵
          end
        end, { "i", "s" }),

        -- Shift+Tab：反向選擇
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()                     -- 補全選單中上一項
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)                           -- 跳回上一個佔位符
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- LSP 提供的補全
        { name = "luasnip" },   -- 程式碼片段
      }, {
        { name = "buffer" },    -- 當前緩衝區內容
        { name = "path" },      -- 檔案路徑
      }),
    })
  end,
}