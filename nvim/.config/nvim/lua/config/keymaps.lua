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
-- Toggle line number
vim.keymap.set("n", "<leader>ol", function()
  vim.o.number = not vim.o.number
  if vim.o.number then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Line Number" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Line Number" })
  end
end, { desc = "Options | Toggle Line Number", silent = true })
-- Toggle relative number
vim.keymap.set("n", "<leader>or", function()
  vim.o.relativenumber = not vim.o.relativenumber
  if vim.o.relativenumber then
    vim.notify("Toggled On", vim.log.levels.INFO, { title = "Relative Number" })
  else
    vim.notify("Toggled Off", vim.log.levels.INFO, { title = "Relative Number" })
  end
end, { desc = "Options | Toggle Relative Number", silent = true })
