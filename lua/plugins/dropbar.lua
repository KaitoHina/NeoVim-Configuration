-- dropbar.nvim: winbar 麵包屑導航
return {
  "Bekaboo/dropbar.nvim",
  -- optional, but required for fuzzy finder support
  -- dependencies = {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   build = 'make'
  -- },
  opts = {
    menu = {
      preview = false, -- 保留下拉選單，但不預覽hover的symbol
    },
  },
}
