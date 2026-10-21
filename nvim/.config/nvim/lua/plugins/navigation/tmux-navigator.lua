-- Ctrl+h/j/k/l moves between nvim splits and, at the edge, into the neighbouring tmux pane.
-- Needs the matching bindings in ~/.dotfiles/tmux/.tmux.conf. Outside tmux it just moves between splits.
return {
  "christoomey/vim-tmux-navigator",
  cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1 -- skip its <C-\> (tmux uses C-\ for last-window)
  end,
  keys = {
    { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left window/pane", silent = true },
    { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to lower window/pane", silent = true },
    { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to upper window/pane", silent = true },
    { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to right window/pane", silent = true },
  },
}
