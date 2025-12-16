return {
  "nvzone/showkeys",
  event = "VeryLazy",
  keys = {
    { "<leader>ok", "<cmd>ShowkeysToggle<cr>", desc = "Options | Toggle Screenkey" },
  },
  config = function()
    require("showkeys").setup()
    vim.cmd "Showkeys"
  end,
}
