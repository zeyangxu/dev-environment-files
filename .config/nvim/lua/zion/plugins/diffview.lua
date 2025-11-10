return {
	"sindrets/diffview.nvim",
	keys = {
		{
			"<leader>gd",
			"<cmd>DiffviewOpen<cr>",
			desc = "Toggle diffview",
		},
		{
			"<leader>gD",
			"<cmd>DiffviewClose<cr>",
			desc = "Close diffview",
		},
	},
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			view = {
				default = {
					layout = "diff2_horizontal",
				},
			},
			keymaps = {
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
					{ "n", "<cr>", actions.goto_file_edit, { desc = "Open file" } },
				},
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
				},
			},
		})
	end,
}
