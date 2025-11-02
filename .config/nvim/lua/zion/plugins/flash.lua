return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		modes = {
			fearch = {
				fenabled = true,
			},
			char = {
				jump_labels = true,
			},
		},
	},
  -- stylua: ignore
  keys = {
    -- Fast cursor jump 
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- Fast visual select
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    -- Remote yank, delete without moving the cursor first
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    -- Remote yank, delete using Treesitter
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    -- Search jump after grep search a keyword
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
