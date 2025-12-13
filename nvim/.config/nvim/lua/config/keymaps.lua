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
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Format on Save" })
  else
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Format on Save" })
  end
end, { desc = "Options | Toggle Format on Save", silent = true })

-- Live Grep in Neovim Config Directory
vim.keymap.set("n", "<leader>ov", function()
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

-- Toggle Spell Check
vim.keymap.set("n", "<leader>os", function()
  vim.o.spell = not vim.o.spell
  if vim.o.spell then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Spell Check" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Spell Check" })
  end
end, { desc = "Options | Toggle Spell Check", silent = true })

-- Toggle Wrap
vim.keymap.set("n", "<leader>ow", function()
  vim.o.wrap = not vim.o.wrap
  if vim.o.wrap then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Line Wrap" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Line Wrap" })
  end
end, { desc = "Options | Toggle Line Wrap", silent = true })

-- Toggle Cursor Line
vim.keymap.set("n", "<leader>oc", function()
  vim.o.cursorline = not vim.o.cursorline
  if vim.o.cursorline then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Cursor Line" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Cursor Line" })
  end
end, { desc = "Options | Toggle Cursor Line", silent = true })

-- Toggle Virtual Text (inline diagnostics)
vim.keymap.set("n", "<leader>ot", function()
  local current = vim.diagnostic.config().virtual_text
  if current then
    vim.diagnostic.config { virtual_text = false }
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Virtual Text" })
  else
    vim.diagnostic.config { virtual_text = true }
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Virtual Text" })
  end
end, { desc = "Options | Toggle Virtual Text", silent = true })

-- Toggle Inlay Hints (LSP type hints)
vim.keymap.set("n", "<leader>oh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  if vim.lsp.inlay_hint.is_enabled() then
    vim.notify("Enabled", vim.log.levels.INFO, { title = "Inlay Hints" })
  else
    vim.notify("Disabled", vim.log.levels.INFO, { title = "Inlay Hints" })
  end
end, { desc = "Options | Toggle Inlay Hints", silent = true })

-- Open Neovim Config in Telescope
vim.keymap.set("n", "<leader>oV", function()
  require("telescope.builtin").find_files {
    cwd = vim.fn.stdpath "config",
    prompt_title = "Neovim Config Files",
  }
end, { desc = "Options | Find Config Files", silent = true })
