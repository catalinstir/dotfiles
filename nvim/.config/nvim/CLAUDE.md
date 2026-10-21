# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Neovim config (Lua, lazy.nvim). It lives in a GNU Stow dotfiles repo at `~/.dotfiles/nvim/.config/nvim`, and `~/.config/nvim` is a symlink to it. Edit the files under `~/.dotfiles`. The git root is `~/.dotfiles`, which also holds the zsh, tmux, kitty, sway, waybar and other configs.

The system dependencies (from the dotfiles README) are `fzf ripgrep unzip tree-sitter-cli python3 python3-venv python3-pip clang-format`.

## Commands

There is no build or test suite. To validate changes:

- Format Lua: `stylua .` (uses `stylua.toml`: 2-space indent, 120 columns, double quotes, `call_parentheses = "None"`, so write `require "x"` and `foo { ... }` without parens). Conform also formats on save.
- Headless load check: `nvim --headless +qa` catches startup errors. Use `"+Lazy! install"` (not `sync`, which updates every pinned plugin) to install new specs headless.
- Plugin management happens inside nvim through the `<leader>p*` keymaps (Lazy sync/update/clean/profile). `lazy-lock.json` pins plugin versions, so commit it when plugins change.

## Architecture

- `init.lua` bootstraps lazy.nvim, disables netrw (nvim-tree replaces it), sets leader to `<Space>`, then runs `require("lazy").setup "plugins"` followed by `require "config"`. Because of this order, the `config/*` modules run **after** plugins are set up and can `require` plugin modules directly.
- `lua/plugins/init.lua` only imports category subdirectories (`fun`, `ui`, `core`, `navigation`, `lsp`, `completion`). Each file returns one lazy.nvim spec. A new plugin goes in the matching category folder; a new category has to be added to the import list.
- `lua/config.lua` loads `config/{options,keymaps,autocmds,neovide}` and then runs `pcall(require, "current-theme")`. `lua/current-theme.lua` is a one-line `vim.cmd("colorscheme ...")` that the telescope-themes picker (`<leader>ft`) overwrites every time you pick a theme, so do not hand-edit it. All colorschemes in `plugins/ui/colorschemes.lua` are `lazy = true` (lazy.nvim loads one when `:colorscheme` asks for it), and per-theme setup such as catppuccin's overrides lives in their `opts`. `<leader>ft` loads them all before opening the picker, because the picker can only list loaded themes.
- Keymaps are split. Global ones are in `config/keymaps.lua`. Plugin-specific ones sit in each plugin spec (`keys = {...}` or `init`). The which-key leader groups in `plugins/ui/which-key.lua` (`f` Find, `g` Git, `l` LSP, `p` Plugins, `o` Options, `x` Trouble, etc.) define the prefix convention. Follow it, and register any new group there. `<C-h/j/k/l>` come from vim-tmux-navigator (`plugins/navigation/tmux-navigator.lua`) and only cross into tmux panes together with the matching `is_vim` bindings in `~/.dotfiles/tmux/.tmux.conf`, so change both sides together.
- LSP uses the Neovim 0.11+ native API. `plugins/lsp/mason-lspconfig.lua` sets `vim.lsp.config("*")` capabilities from blink.cmp (`plugins/completion/blink-cmp.lua`), uses `automatic_enable = true`, defines diagnostics and signs, and adds the `LspAttach` keymaps (only `gd`; the rest are Neovim's built-in `gr*`/`K`/`[d` defaults, so don't map a bare `gr`). Per-server settings go in top-level `lsp/<server>.lua` files that return a config table (e.g. `lsp/lua_ls.lua`), not in lspconfig `setup()` calls. Formatter and tool binaries are installed through `mason-tool-installer.lua`.
- Formatting is done by conform.nvim (`plugins/core/conform.lua`), with formatters chosen per filetype. Format-on-save stops when `vim.g.disable_autoformat` is set, which `<leader>of` toggles.
