return {
  {
    "nvim-lua/plenary.nvim",
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
    "folke/ts-comments.nvim",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = {},
  },
}
