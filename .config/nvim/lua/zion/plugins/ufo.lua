return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		{ "kevinhwang91/promise-async" },
	},
	config = function()
		local ufo = require("ufo")
		local opt = vim.opt

		-- folding
		opt.foldcolumn = "1"
		opt.foldlevel = 99
		opt.foldlevelstart = 99
		opt.foldenable = true

		-- Track current fold level
		local fold_level = 0

		vim.keymap.set("n", "zR", function()
			ufo.openAllFolds()
		end)
		vim.keymap.set("n", "zM", function()
			ufo.closeAllFolds()
			fold_level = 0
		end)
		vim.keymap.set("n", "=", function()
			fold_level = fold_level + 1
			ufo.closeFoldsWith(fold_level)
		end)
		vim.keymap.set("n", "-", function()
			fold_level = math.max(0, fold_level - 1)
			ufo.closeFoldsWith(fold_level)
		end)
		vim.keymap.set("n", "zr", function()
			ufo.openFoldsExceptKinds({ "imports", "comment" })
		end, { desc = "Open folds except imports/comments" })

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
