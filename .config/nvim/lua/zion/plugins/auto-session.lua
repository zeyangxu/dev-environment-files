--- https://github.com/rmagatti/auto-session
return {
  "rmagatti/auto-session",
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { "<leader>ww", "<cmd>AutoSession search<CR>", desc = "Session search" },
    { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
    { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
  },

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    session_lens = {
      picker_opts = {
        layout_config = {
          width = 0.9,
          height = 0.7,
        },
        path_display = { "tail" },
      },
    },
    -- log_level = 'debug',
  },
}
