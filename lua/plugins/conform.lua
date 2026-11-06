-- Java 格式化：google-java-format（透過 Mason 安裝）
-- 不用 event 延遲載入：conform 需要在 BufWritePre 前就註冊好 autocmd
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      java = { "google-java-format" },
    },
    format_on_save = function(bufnr)
      -- 只有 java 交給 conform；其他檔案維持原本的 LSP 格式化
      if vim.bo[bufnr].filetype == "java" then
        return { timeout_ms = 3000, lsp_format = "never" }
      end
      return nil
    end,
  },
}
