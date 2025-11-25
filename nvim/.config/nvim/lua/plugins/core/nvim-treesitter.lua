return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "html",
        "css",
        "json",
        "markdown",
      },
      auto_install = true,
      highlight = {
        enable = true, -- ← This is critical!
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    }
  end,
}
