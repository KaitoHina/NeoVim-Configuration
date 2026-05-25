-- 注釋插件
return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- 允許我們自動注釋tsx元素
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- 在正常模式下注釋光標下的行
		vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment Line" })
		-- 在視覺模式下注釋選中的行
		vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment Selected" })

		-- 使用 Comment 插件的功能
		local comment = require("Comment")
		-- 使用 tsx 注釋插件的功能
		local ts_context_comment_string = require("ts_context_commentstring.integrations.comment_nvim")

		-- 設定 Comment 插件，並將 tsx 注釋功能整合進去
		comment.setup({
			pre_hook = ts_context_comment_string.create_pre_hook(),
		})
	end,
}