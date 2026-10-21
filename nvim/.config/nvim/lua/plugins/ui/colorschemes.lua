-- All lazy: lazy.nvim loads a scheme when `:colorscheme <name>` asks for it (see lua/current-theme.lua).
-- The <leader>ft picker (plugins/navigation/telescope.lua) loads them all first so it can list them.
return {
  { "rose-pine/neovim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  {
    "catppuccin/nvim",
    main = "catppuccin",
    lazy = true,
    opts = {
      flavour = "latte",
      color_overrides = {
        latte = {
          base = "#f8f8f8", -- main background, default is #eff1f5
          mantle = "#f0ede8", -- slightly darker bg (used in sidebars etc)
          crust = "#e8e5e0", -- darkest bg shade
        },
      },
    },
  },
  { "dracula/vim", lazy = true },
  { "gruvbox-community/gruvbox", lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "bluz71/vim-moonfly-colors", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
}
