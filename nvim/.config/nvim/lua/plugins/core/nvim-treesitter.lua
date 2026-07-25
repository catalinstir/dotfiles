return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false, -- IMPORTANT: do not lazy-load

  config = function()
    -- 1. Install parsers
    require("nvim-treesitter").install {
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
      "bash",
      "vim",
      "vimdoc",
      "query",
      "regex",
    }

    -- 2. Enable Treesitter highlighting (Neovim handles it now)
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
