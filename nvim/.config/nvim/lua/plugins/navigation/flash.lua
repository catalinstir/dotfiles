return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    modes = {
      search = { enabled = false }, -- don't hijack / and ?
      char = {
        enabled = true, -- enhances f/t/F/T
        jump_labels = true,
      },
    },
  },
  keys = {
    {
      "s",
      function()
        require("flash").jump()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash Jump",
    },
    {
      "S",
      function()
        require("flash").treesitter()
      end,
      mode = { "n", "x", "o" },
      desc = "Flash Treesitter",
    },
    {
      "r",
      function()
        require("flash").remote()
      end,
      mode = "o",
      desc = "Flash Remote",
    },
    {
      "<c-s>",
      function()
        require("flash").toggle()
      end,
      mode = "c",
      desc = "Flash Search Toggle",
    },
  },
}
