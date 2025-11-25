local options = {
  number = true,
  relativenumber = true,
  mouse = "a",
  showmode = false,
  clipboard = "unnamedplus",
  breakindent = true,
  undofile = true,
  ignorecase = true,
  smartcase = true,
  signcolumn = "yes",
  updatetime = 250,
  splitright = true,
  splitbelow = true,
  scrolloff = 10,
  cursorline = true,
  fillchars = { eob = " " },
  tabstop = 4,
  shiftwidth = 4,
  expandtab = true,
  softtabstop = 4,
  smartindent = true,
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

vim.g.deprecation_warnings = false
