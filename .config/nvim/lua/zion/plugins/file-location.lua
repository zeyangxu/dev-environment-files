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
	end,
}
