return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    providers = { "lsp", "treesitter", "regex" },
  },
  config = function(_, opts)
    require("illuminate").configure(opts)
    -- navigate between occurrences
    vim.keymap.set("n", "]]", function()
      require("illuminate").goto_next_reference()
    end, { desc = "Next Reference" })
    vim.keymap.set("n", "[[", function()
      require("illuminate").goto_prev_reference()
    end, { desc = "Prev Reference" })
  end,
}
