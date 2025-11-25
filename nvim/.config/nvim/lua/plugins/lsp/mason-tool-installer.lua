return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim", -- Add this
  },
  opts = {
    ensure_installed = {
      "stylua",
      "black",
      "prettier",
    },
  },
}
