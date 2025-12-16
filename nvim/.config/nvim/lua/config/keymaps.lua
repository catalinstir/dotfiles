-- Basic Remaps --
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- tmux navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Yank entire file content
vim.keymap.set("n", "<leader>y", "ggyG``", { desc = "Yank entire file", silent = true })

-- Plugins - Lazy --
-- Clean
vim.keymap.set("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "Lazy | Clean", silent = true })
-- Check
vim.keymap.set("n", "<leader>pC", "<cmd>Lazy check<cr>", { desc = "Lazy | Check", silent = true })
-- Debug
vim.keymap.set("n", "<leader>pd", "<cmd>Lazy debug<cr>", { desc = "Lazy | Debug", silent = true })
-- Install
vim.keymap.set("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "Lazy | Install", silent = true })
-- Sync
vim.keymap.set("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "Lazy | Sync", silent = true })
-- Log
vim.keymap.set("n", "<leader>pl", "<cmd>Lazy log<cr>", { desc = "Lazy | Log", silent = true })
-- Home
vim.keymap.set("n", "<leader>ph", "<cmd>Lazy home<cr>", { desc = "Lazy | Home", silent = true })
-- Help
vim.keymap.set("n", "<leader>pH", "<cmd>Lazy help<cr>", { desc = "Lazy | Help", silent = true })
-- Profile
vim.keymap.set("n", "<leader>pp", "<cmd>Lazy profile<cr>", { desc = "Lazy | Profile", silent = true })
-- Update
vim.keymap.set("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Lazy | Update", silent = true })

-- Options --
-- Toggle Format on Save
vim.keymap.set("n", "<leader>of", function()
  local conform = require "conform"
  if vim.g.disable_autoformat then
    vim.g.disable_autoformat = false
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Format on Save" })
  else
    vim.g.disable_autoformat = true
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Format on Save" })
  end
end, { desc = "Options | Toggle Format on Save", silent = true })

-- Live Grep in Neovim Config Directory
vim.keymap.set("n", "<leader>nv", function()
  require("telescope.builtin").live_grep {
    cwd = vim.fn.stdpath "config",
    prompt_title = "Search Neovim Config",
  }
end, { desc = "Options | Grep Neovim Config", silent = true })

-- Toggle Line Numbers
vim.keymap.set("n", "<leader>on", function()
  vim.o.number = not vim.o.number
  if vim.o.number then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Line Number" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Line Number" })
  end
end, { desc = "Options | Toggle Line Number", silent = true })

-- Toggle Relative Numbers
vim.keymap.set("n", "<leader>or", function()
  vim.o.relativenumber = not vim.o.relativenumber
  if vim.o.relativenumber then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Relative Number" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Relative Number" })
  end
end, { desc = "Options | Toggle Relative Number", silent = true })

-- Toggle Diagnostics
vim.keymap.set("n", "<leader>od", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  if vim.diagnostic.is_enabled() then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Diagnostics" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Diagnostics" })
  end
end, { desc = "Options | Toggle Diagnostics", silent = true })

-- Toggle Inlay Hints (LSP type hints)
vim.keymap.set("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  if vim.lsp.inlay_hint.is_enabled() then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Inlay Hints" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Inlay Hints" })
  end
end, { desc = "Options | Toggle Inlay Hints", silent = true })

-- SudaWrite
vim.keymap.set("n", "<leader>ns", "<cmd>SudaWrite<cr>", { desc = "Neovim | Write with sudo", silent = true })

-- Toggle Supermaven
vim.keymap.set("n", "<leader>na", function()
  local api = require "supermaven-nvim.api"
  if api.is_running() then
    api.stop()
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Supermaven" })
  else
    api.start()
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Supermaven" })
  end
end, { desc = "Options | Toggle Supermaven", silent = true })

-- Open Neovim Config in Telescope
vim.keymap.set("n", "<leader>nV", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "config",
    prompt_title = "Neovim Config Files",
  }
end, { desc = "Options | Find Config Files", silent = true })

-- Quick buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Close buffer without closing window
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Delete buffer (force)" })

-- Close all buffers except current
vim.keymap.set("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all other buffers" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move lines in normal mode
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Move lines in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Don't yank when pasting over selection
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Save with Ctrl+S (also works in insert mode)
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<cr>", { desc = "Save file" })

-- Move by visual line, not actual line
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep cursor centered when searching
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
