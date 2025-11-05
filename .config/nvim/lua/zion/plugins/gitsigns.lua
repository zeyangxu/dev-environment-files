return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "▎", linehl = "GitSignsAddLn" },
				change = { text = "▎", linehl = "GitSignsChangeLn" },
				delete = { text = "▎", linehl = "GitSignsDeleteLn" },
				topdelete = { text = "▎", linehl = "GitSignsDeleteLn" },
				changedelete = { text = "▎", linehl = "GitSignsChangeLn" },
				untracked = { text = "▎", linehl = "GitSignsUntrackedLn" },
			},
			current_line_blame = true,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Next hunk" })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Previous hunk" })

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Stage hunk" })
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Reset hunk" })
			map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
			map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>hp", gs.preview_hunk_inline, { desc = "Preview hunk" })

			-- Blame
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, { desc = "Blame line" })
			map("n", "<leader>hl", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
			map("n", "<leader>hc", function()
				local blame = vim.b.gitsigns_blame_line_dict
				if blame and blame.sha and blame.sha ~= "00000000" and blame.sha ~= "0000000000000000000000000000000000000000" then
					vim.cmd("DiffviewOpen " .. blame.sha .. "^.." .. blame.sha)
				else
					vim.notify("No commit found for this line", vim.log.levels.WARN)
				end
			end, { desc = "Show commit diff" })

			-- Diff
			map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end, { desc = "Diff this ~" })
			map("n", "<leader>ho", "<cmd>diffoff | only<cr>", { desc = "Diff off" })
		end,
		})

		-- Set bold signs & backgrounds
		vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#3c8f5a", bold = true })
		vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#d4a65f", bold = true })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#d26a6a", bold = true })
		vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#5f6a8e", bold = true })

		-- Line backgrounds
		vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#1a2e24" })
		vim.api.nvim_set_hl(0, "GitSignsChangeLn", { bg = "#2e2715" })
		vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { bg = "#2e1a1a" })
		vim.api.nvim_set_hl(0, "GitSignsUntrackedLn", { bg = "#1a1e2e" })
	end,
}
