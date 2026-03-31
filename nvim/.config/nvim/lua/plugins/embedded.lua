return {
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      server = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
          "--query-driver=/usr/local/mcuxpressoide-25.6.136/ide/tools/bin/arm-none-eabi-*",
        },
      },
      extensions = {
        autoSetHints = true,
        inlay_hints = { inline = false },
      },
    },
  },
}
