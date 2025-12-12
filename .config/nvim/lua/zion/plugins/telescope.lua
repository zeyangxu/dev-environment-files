return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"BurntSushi/ripgrep",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<Tab>"] = actions.toggle_selection + actions.move_selection_better, -- mark/unmark + move down
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse, -- mark/unmark + move up
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send marked to qflist
						["<M-q>"] = actions.add_to_qflist + actions.open_qflist, -- add marked to qflist
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true, -- show hidden files
				},
				git_commits = {
					mappings = {
						i = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
						},
						n = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
						},
					},
				},
				git_bcommits = {
					mappings = {
						i = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
						},
						n = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
						},
					},
				},
				git_stash = {
					mappings = {
						i = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
							["<C-a>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git stash apply " .. selection.value)
							end,
							["<C-p>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git stash pop " .. selection.value)
							end,
						},
						n = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.cmd("DiffviewOpen " .. selection.value .. "^.." .. selection.value)
							end,
							["<C-a>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git stash apply " .. selection.value)
							end,
							["<C-p>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git stash pop " .. selection.value)
							end,
						},
					},
				},
				git_branches = {
					mappings = {
						i = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git checkout " .. vim.fn.shellescape(selection.value))
							end,
						},
						n = {
							["<CR>"] = function(prompt_bufnr)
								local selection = require("telescope.actions.state").get_selected_entry()
								require("telescope.actions").close(prompt_bufnr)
								vim.fn.system("git checkout " .. vim.fn.shellescape(selection.value))
							end,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fF", function()
			require("telescope.builtin").find_files({
				find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
				prompt_title = "Select Directory for Find Files",
				attach_mappings = function(prompt_bufnr, map)
					local action_state = require("telescope.actions.state")
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						if selection then
							require("telescope.builtin").find_files({ cwd = selection[1] })
						end
					end)
					return true
				end,
			})
		end, { desc = "Find files in directory" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fS", function()
			require("telescope.builtin").find_files({
				find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
				prompt_title = "Select Directory for Live Grep",
				attach_mappings = function(prompt_bufnr, map)
					local action_state = require("telescope.actions.state")
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						if selection then
							require("telescope.builtin").live_grep({ cwd = selection[1] })
						end
					end)
					return true
				end,
			})
		end, { desc = "Live grep in directory" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope registers<cr>", { desc = "Fuzzy find registers" })
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show project commits" })
		keymap.set("n", "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", { desc = "Show buffer commits" })
		keymap.set("n", "<leader>gbb", "<cmd>Telescope git_branches<cr>", { desc = "Show Git branches" })
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show Git status" })
		keymap.set("n", "<leader>gsh", "<cmd>Telescope git_stash<cr>", { desc = "Show git stashes" })
		keymap.set("n", "<leader>gbr", "<cmd>Telescope git_bcommits_range<cr>", { desc = "Show buffer commits range" })
		keymap.set("v", "<leader>gbr", "<cmd>Telescope git_bcommits_range<cr>", { desc = "Show buffer commits range" })
		keymap.set("n", "<leader>gB", function()
			require("telescope.builtin").git_branches({
				attach_mappings = function(_, map)
					map({ "n", "i" }, "<CR>", function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("DiffviewOpen " .. selection.value)
					end)
					return true
				end,
			})
		end, { desc = "Diff against branch" })
		keymap.set("n", "<leader>gC", function()
			require("telescope.builtin").git_commits({
				attach_mappings = function(_, map)
					map({ "n", "i" }, "<CR>", function(prompt_bufnr)
						local selection = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						vim.cmd("DiffviewOpen " .. selection.value)
					end)
					return true
				end,
			})
		end, { desc = "Diff against commit" })
	end,
}
