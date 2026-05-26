return {
	"mfussenegger/nvim-dap",
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
	end,
}