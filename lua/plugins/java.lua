return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- 當套件被載入後，立刻執行你的現代化 JDTLS 設定
    require('config.jdtls').setup_jdtls()
  end
}