return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>th", desc = "Horizontal Terminal" },
    { "<leader>tv", desc = "Vertical Terminal" },
    { "<leader>tf", desc = "Float Terminal" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 10
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 0,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", {
      desc = "Terminal | Horizontal",
      silent = true,
    })
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", {
      desc = "Terminal | Vertical",
      silent = true,
    })
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", {
      desc = "Terminal | Float",
      silent = true,
    })

    -- Terminal mode mappings
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
  end,
}
