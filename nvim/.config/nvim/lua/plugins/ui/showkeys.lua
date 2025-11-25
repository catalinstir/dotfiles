return {
  "nvzone/showkeys",
  init = function()
    vim.keymap.set(
      "n",
      "<leader>ok",
      "<cmd>ShowkeysToggle<cr>",
      { desc = "Screenkey | Toggle Screenkey", silent = true }
    )
  end,
  cmd = "ShowkeysToggle",
}
