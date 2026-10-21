return {
  "VidocqH/lsp-lens.nvim",
  event = "LspAttach",
  keys = {
    { "<leader>ll", "<cmd>LspLensToggle<cr>", desc = "LSP | Toggle Code Lens", silent = true },
  },
  opts = {
    enable = false,
  },
}
