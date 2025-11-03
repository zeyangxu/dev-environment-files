return {
	"diegoulloao/nvim-file-location",
	config = function()
		local fileLocation = require("nvim-file-location")
		fileLocation.setup({
			keymap = "<leader>L",
			mode = "workdir", -- options: workdir | absolute
			add_line = true,
			add_column = false,
			default_register = "*",
		})

		local keymap = vim.keymap
		keymap.set(
			"n",
			"<leader>lL",
			"<cmd>lua NvimFileLocation.copy_file_location('absolute', true, false)<cr>",
			{ desc = "Copy absolute file path" }
		)
		keymap.set(
			"n",
			"<leader>ll",
			"<cmd>lua NvimFileLocation.copy_file_location('workdir', true, false)<cr>",
			{ desc = "Copy working directory file path" }
		)
	end,
}
