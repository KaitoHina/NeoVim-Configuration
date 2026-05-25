-- 自動補全括號、引號等
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- 僅在插入模式下載入
  opts = {
    check_ts = true,     -- 利用 treesitter 檢查是否該自動補全
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    -- 讓 cmp 在確認補全時也能自動帶上括號
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end,
}