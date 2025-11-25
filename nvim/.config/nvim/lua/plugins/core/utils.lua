return {
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "moll/vim-bbye",
    enabled = false,
    cmd = { "Bdelete", "Bwipeout" },
  },
  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" },
  },
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    enabled = false,
    config = function()
      require("Comment").setup {
        ignore = "^$",
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  },
  {
    "folke/ts-comments.nvim",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = {},
  },
}
