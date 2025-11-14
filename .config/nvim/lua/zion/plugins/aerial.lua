return {
	"stevearc/aerial.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local aerial = require("aerial")

		aerial.setup({
			-- Priority list of preferred backends for aerial.
			backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },

			layout = {
				max_width = { 40, 0.2 },
				width = nil,
				min_width = 20,
				default_direction = "prefer_left",
				placement = "window",
			},

			-- Automatically open aerial when entering supported buffers
			attach_mode = "window",

			-- Close aerial window when switching to a different buffer
			close_automatic_events = {},

			-- Keymaps in aerial window
			keymaps = {
				["?"] = "actions.show_help",
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.jump",
				["<2-LeftMouse>"] = "actions.jump",
				["<C-v>"] = "actions.jump_vsplit",
				["<C-s>"] = "actions.jump_split",
				["p"] = "actions.scroll",
				["<C-j>"] = "actions.down_and_scroll",
				["<C-k>"] = "actions.up_and_scroll",
				["{"] = "actions.prev",
				["}"] = "actions.next",
				["[["] = "actions.prev_up",
				["]]"] = "actions.next_up",
				["q"] = "actions.close",
				["o"] = "actions.tree_toggle",
				["za"] = "actions.tree_toggle",
				["O"] = "actions.tree_toggle_recursive",
				["zA"] = "actions.tree_toggle_recursive",
				["l"] = "actions.tree_open",
				["zo"] = "actions.tree_open",
				["L"] = "actions.tree_open_recursive",
				["zO"] = "actions.tree_open_recursive",
				["h"] = "actions.tree_close",
				["zc"] = "actions.tree_close",
				["H"] = "actions.tree_close_recursive",
				["zC"] = "actions.tree_close_recursive",
				["zr"] = "actions.tree_increase_fold_level",
				["zR"] = "actions.tree_open_all",
				["zm"] = "actions.tree_decrease_fold_level",
				["zM"] = "actions.tree_close_all",
				["zx"] = "actions.tree_sync_folds",
				["zX"] = "actions.tree_sync_folds",
			},

			-- Show box drawing characters for the tree hierarchy
			show_guides = true,

			-- Customize the characters used when show_guides = true
			guides = {
				mid_item = "├─",
				last_item = "└─",
				nested_top = "│ ",
				whitespace = "  ",
			},

			-- Filter which symbols to show in aerial
			filter_kind = {
				"Class",
				"Constructor",
				"Enum",
				"Function",
				"Interface",
				"Module",
				"Method",
				"Struct",
			},

			-- When true, don't load aerial until a command requires it
			lazy_load = true,

			-- Disable aerial on files with this many lines
			disable_max_lines = 10000,

			-- Disable aerial on files this size or larger (in bytes)
			disable_max_size = 2000000, -- 2MB

			-- Highlight the symbol in the source buffer when cursor is in aerial win
			highlight_on_hover = true,

			-- When you fold code with za, zo, etc, update the aerial tree
			update_events = "TextChanged,InsertLeave",

			-- Highlight the closest symbol under the cursor
			highlight_closest = true,
			highlight_mode = "split_width",

			-- Show symbols from current buffer or all open buffers
			manage_folds = false,

			-- Link aerial highlights to groups
			link_folds_to_tree = false,
			link_tree_to_folds = false,

			-- Automatically jump to symbol under cursor
			autojump = false,

			-- Options for opening aerial in a floating window
			float = {
				border = "rounded",
				relative = "cursor",
				max_height = 0.9,
				height = nil,
				min_height = { 8, 0.1 },
			},

			-- Options for the aerial navigation menu
			nav = {
				border = "rounded",
				max_height = 0.9,
				min_height = { 10, 0.1 },
				max_width = 0.5,
				min_width = { 0.2, 20 },
				win_opts = {
					cursorline = true,
					winblend = 10,
				},
				autojump = false,
				preview = true,
				keymaps = {
					["<CR>"] = "actions.jump",
					["<C-v>"] = "actions.jump_vsplit",
					["<C-s>"] = "actions.jump_split",
					["h"] = "actions.left",
					["l"] = "actions.right",
					["<C-c>"] = "actions.close",
				},
			},

			-- Set symbol icons (using Nerd Font)
			icons = {},

			-- Customize which symbols are shown
			ignore = {
				-- Ignore unlisted symbol kinds
				unlisted_buffers = true,
				-- List of symbol kinds to ignore
				symbols = {},
				-- Ignore symbols that are from these filetypes
				filetypes = {},
				-- Ignore symbols from these buftypes
				buftypes = "special",
			},

			-- When true, aerial will automatically open when you enter a buffer
			open_automatic = false,

			-- Determines how the aerial window decides which symbols to display
			post_jump_cmd = "normal! zz",

			-- When true, aerial will close when you leave the buffer
			close_on_select = false,

			-- Position of aerial window: left, right, float
			-- placement can override this
			-- default_direction = "right",

			-- Set the width of aerial window (when placed on left/right)
			-- width = 30,
		})

		-- Set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>as", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial outline" })
		keymap.set("n", "<leader>aa", "<cmd>AerialNavToggle<CR>", { desc = "Toggle aerial nav" })
		keymap.set("n", "{", "<cmd>AerialPrev<CR>", { desc = "Jump to previous symbol" })
		keymap.set("n", "}", "<cmd>AerialNext<CR>", { desc = "Jump to next symbol" })
	end,
}
