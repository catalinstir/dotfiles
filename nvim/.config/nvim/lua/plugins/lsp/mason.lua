return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = {
    { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" },
  },
  config = function()
    require("mason").setup()
  end,
}
