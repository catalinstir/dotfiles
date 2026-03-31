require "config/options"
require "config/keymaps"
require "config/autocmds"
require "config/neovide"

require("catppuccin").setup {
  flavour = "latte",
  color_overrides = {
    latte = {
      base = "#f8f8f8", -- main background, default is #eff1f5
      mantle = "#f0ede8", -- slightly darker bg (used in sidebars etc)
      crust = "#e8e5e0", -- darkest bg shade
    },
  },
}
vim.cmd.colorscheme "catppuccin-latte"
