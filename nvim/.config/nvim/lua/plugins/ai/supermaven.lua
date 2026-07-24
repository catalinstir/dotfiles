return {
  "supermaven-inc/supermaven-nvim",
  -- commit = "df3ecf7",
  -- commit = "40bde487fe31723cdd180843b182f70c6a991226",
  event = {
    "BufReadPost",
    "BufNewFile",
  },
  opts = {
    disable_keymaps = false,
    disable_inline_completion = false,
    keymaps = {
      accept_suggestion = "<A-f>",
      clear_suggestion = "<Nop>",
      accept_word = "<A-w>",
    },
  },
  config = function(_, opts)
    require("supermaven-nvim").setup(opts)
    -- Stop it immediately after setup
    vim.schedule(function()
      require("supermaven-nvim.api").stop()
    end)
  end,
}
