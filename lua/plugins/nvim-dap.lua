return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		-- ui plugins to make debugging simplier
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- gain access to the dap plugin and its functions
		local dap = require("dap")
		-- gain access to the dap ui plugin and its functions
		local dapui = require("dapui")

		-- Setup the dap ui with default configuration
		dapui.setup()

		-- setup an event listener for when the debugger is launched
		dap.listeners.before.launch.dapui_config = function()
			-- when the debugger is launched open up the debug ui
			dapui.open()
		end

		-- setup an event listener for when the debugger is terminated
		-- dap.listeners.before.event_terminated["dapui_config"] = function()
		-- 	dapui.close({})
		-- 	dap.repl.close()
		-- end

		-- setup an event listener for when the debugger is exited
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close({})
			dap.repl.close()
		end

		-- set a vim motion for <Space> + d + t to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })

		-- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })

		-- set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "[D]ebug [C]lose UI" })

    -- set a vim motion to open the debugging ui
    vim.keymap.set("n", "<leader>do", dapui.open, { desc = "[D]ebug [O]en UI" })

    -- set a vim motion to toggle the debugging ui
    vim.keymap.set("n", "<leader>dT", dapui.toggle, { desc = "[D]ebug [T]oggle UI" })
    
    -- set a vim motion to step over the current line of code
    vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "[D]ebug [R]un to Cursor" })

		-- 設定快捷鍵 <leader>dq 來強制終止除錯、關閉 UI，並清除所有終端機 buffer
		vim.keymap.set("n", "<leader>dq", function()
			-- 1. 終止除錯程序
			dap.terminate()
			
			-- 2. 關閉除錯介面與 Repl
			dapui.close()
			dap.repl.close()
			
			-- 3. 找出並強制關閉 dap 相關的終端機 buffer，防止 unmodified buffer 錯誤
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local buf_name = vim.api.nvim_buf_get_name(buf)
				-- nvim-dap 產生的 terminal 名稱通常包含 "dap-terminal" 或 "[dap-terminal]"
				if string.match(buf_name, "dap%-terminal") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
			
			vim.notify("Debugger terminated and UI closed.", vim.log.levels.INFO)
		end, { desc = "[D]ebug [Q]uit & Clean Terminals" })
	end,
}