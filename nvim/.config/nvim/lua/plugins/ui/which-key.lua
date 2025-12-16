return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "", -- symbol prepended to a group
    },
    preset = "classic",
    win = {
      border = vim.g.border_enabled and "rounded" or "none",
      no_overlap = false,
    },
    delay = function()
      return 0
    end,
  },
  config = function(_, opts)
    require("which-key").setup(opts)
    require("which-key").add {
      {
        { "<leader>f", group = "Find", icon = "  " },
        { "<leader>g", group = "Git", icon = " 󰊢 " },
        { "<leader>h", group = "Harpoon", icon = "  " },
        { "<leader>l", group = "LSP", icon = "  " },
        { "<leader>n", group = "Neovim", icon = "  " },
        { "<leader>o", group = "Options", icon = "  " },
        { "<leader>p", group = "Plugins", icon = "  " },
        { "<leader>t", group = "Terminal", icon = "  " },
        { "<leader>x", group = "Trouble", icon = "  " },
        { "<leader>e", group = "NvimTree", icon = "  " },
        { "<leader>m", group = "Mason", icon = "  " },
        { "<leader>T", group = "Typr", icon = "  " },
        { "<leader>y", group = "Yank entire file", icon = "  " },
        { "<leader>b", group = "Buffers", icon = "  " },
      },
    }
  end,
}
