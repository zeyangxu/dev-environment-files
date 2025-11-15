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
			diff_binaries = false,
			enhanced_diff_hl = true, -- Better syntax highlighting in diffs
			git_cmd = { "git" },
			hg_cmd = { "hg" },
			use_icons = true,
			show_help_hints = true,
			watch_index = true,
			icons = {
				folder_closed = "",
				folder_open = "",
			},
			signs = {
				fold_closed = "",
				fold_open = "",
				done = "✓",
			},
			view = {
				-- VSCode uses side-by-side (vertical) diff view by default
				default = {
					layout = "diff2_vertical",
					winbar_info = true, -- Show file info in winbar like VSCode
				},
				merge_tool = {
					layout = "diff3_mixed",
					disable_diagnostics = true,
					winbar_info = true,
				},
				file_history = {
					layout = "diff2_vertical",
					winbar_info = true,
				},
			},
			file_panel = {
				listing_style = "tree", -- VSCode-like tree view
				tree_options = {
					flatten_dirs = true, -- Flatten single-child directories
					folder_statuses = "only_folded",
				},
				win_config = {
					position = "left", -- File panel on left like VSCode
					width = 35,
					win_opts = {},
				},
			},
			file_history_panel = {
				log_options = {
					git = {
						single_file = {
							diff_merges = "combined",
						},
						multi_file = {
							diff_merges = "first-parent",
						},
					},
				},
				win_config = {
					position = "bottom",
					height = 16,
					win_opts = {},
				},
			},
			commit_log_panel = {
				win_config = {
					win_opts = {},
				},
			},
			default_args = {
				DiffviewOpen = {},
				DiffviewFileHistory = {},
			},
			hooks = {
				diff_buf_read = function(bufnr)
					-- VSCode-like options for diff buffers
					vim.opt_local.wrap = false
					vim.opt_local.list = false
					vim.opt_local.colorcolumn = ""
				end,
				view_opened = function(view)
					-- Additional setup when view opens
					vim.cmd([[
						" VSCode-like diff highlighting
						highlight DiffAdd guibg=#1a3a1a guifg=NONE
						highlight DiffChange guibg=#1a2a3a guifg=NONE
						highlight DiffDelete guibg=#3a1a1a guifg=#5a5a5a
						highlight DiffText guibg=#2a4a5a guifg=NONE
					]])
				end,
			},
			keymaps = {
				disable_defaults = false,
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
					{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
					{ "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
					{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
					{ "n", "<leader>co", actions.conflict_choose("ours"), { desc = "Choose ours" } },
					{ "n", "<leader>ct", actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
					{ "n", "<leader>cb", actions.conflict_choose("base"), { desc = "Choose base" } },
					{ "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all" } },
					{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete conflict region" } },
				},
				diff1 = {
					{ "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open help" } },
				},
				diff2 = {
					{ "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open help" } },
				},
				diff3 = {
					{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open help" } },
				},
				diff4 = {
					{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open help" } },
				},
				file_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
					{ "n", "j", actions.next_entry, { desc = "Next entry" } },
					{ "n", "<down>", actions.next_entry, { desc = "Next entry" } },
					{ "n", "k", actions.prev_entry, { desc = "Previous entry" } },
					{ "n", "<up>", actions.prev_entry, { desc = "Previous entry" } },
					{ "n", "<cr>", actions.select_entry, { desc = "Open file" } },
					{ "n", "o", actions.select_entry, { desc = "Open file" } },
					{ "n", "l", actions.select_entry, { desc = "Open file" } },
					{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open file" } },
					{ "n", "-", actions.toggle_stage_entry, { desc = "Stage/unstage" } },
					{ "n", "S", actions.stage_all, { desc = "Stage all" } },
					{ "n", "U", actions.unstage_all, { desc = "Unstage all" } },
					{ "n", "X", actions.restore_entry, { desc = "Restore entry" } },
					{ "n", "L", actions.open_commit_log, { desc = "Open commit log" } },
					{ "n", "zo", actions.open_fold, { desc = "Expand fold" } },
					{ "n", "h", actions.close_fold, { desc = "Close fold" } },
					{ "n", "zc", actions.close_fold, { desc = "Close fold" } },
					{ "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
					{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
					{ "n", "zM", actions.close_all_folds, { desc = "Close all folds" } },
					{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll up" } },
					{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll down" } },
					{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
					{ "n", "gf", actions.goto_file_edit, { desc = "Go to file" } },
					{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Go to file (split)" } },
					{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Go to file (tab)" } },
					{ "n", "i", actions.listing_style, { desc = "Toggle listing style" } },
					{ "n", "f", actions.toggle_flatten_dirs, { desc = "Toggle flatten dirs" } },
					{ "n", "R", actions.refresh_files, { desc = "Refresh files" } },
					{ "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
					{ "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
					{ "n", "g?", actions.help("file_panel"), { desc = "Open help" } },
					{ "n", "<leader>e", actions.focus_files, { desc = "Focus files" } },
					{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle files" } },
				},
				file_history_panel = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
					{ "n", "g!", actions.options, { desc = "Open options" } },
					{ "n", "<C-A-d>", actions.open_in_diffview, { desc = "Open in diffview" } },
					{ "n", "y", actions.copy_hash, { desc = "Copy hash" } },
					{ "n", "L", actions.open_commit_log, { desc = "Open commit log" } },
					{ "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
					{ "n", "zM", actions.close_all_folds, { desc = "Close all folds" } },
					{ "n", "j", actions.next_entry, { desc = "Next entry" } },
					{ "n", "<down>", actions.next_entry, { desc = "Next entry" } },
					{ "n", "k", actions.prev_entry, { desc = "Previous entry" } },
					{ "n", "<up>", actions.prev_entry, { desc = "Previous entry" } },
					{ "n", "<cr>", actions.select_entry, { desc = "Open file" } },
					{ "n", "o", actions.select_entry, { desc = "Open file" } },
					{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open file" } },
					{ "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll up" } },
					{ "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll down" } },
					{ "n", "<tab>", actions.select_next_entry, { desc = "Next file" } },
					{ "n", "<s-tab>", actions.select_prev_entry, { desc = "Previous file" } },
					{ "n", "gf", actions.goto_file_edit, { desc = "Go to file" } },
					{ "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Go to file (split)" } },
					{ "n", "<C-w>gf", actions.goto_file_tab, { desc = "Go to file (tab)" } },
					{ "n", "<leader>e", actions.focus_files, { desc = "Focus files" } },
					{ "n", "<leader>b", actions.toggle_files, { desc = "Toggle files" } },
					{ "n", "g?", actions.help("file_history_panel"), { desc = "Open help" } },
				},
				option_panel = {
					{ "n", "<tab>", actions.select_entry, { desc = "Select option" } },
					{ "n", "q", actions.close, { desc = "Close" } },
					{ "n", "g?", actions.help("option_panel"), { desc = "Open help" } },
				},
				help_panel = {
					{ "n", "q", actions.close, { desc = "Close help" } },
					{ "n", "<esc>", actions.close, { desc = "Close help" } },
				},
			},
		})
	end,
}
