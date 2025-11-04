return {
	"williamboman/mason-lspconfig.nvim",
	opts = {
		ensure_installed = {
			-- LSPs
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"pyright",
			"eslint",
			"thriftls",
			"marksman",
			"jsonls",
			"yamlls",

			-- Linters
			"eslint",
			"markdownlint",

			-- Formatters
			"prettierd",
			"stylua",
		},
	},
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
}
