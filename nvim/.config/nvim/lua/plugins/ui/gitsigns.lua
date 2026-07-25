return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signcolumn = true,
    numhl = false,
    current_line_blame = false,
    on_attach = function(bufnr)
      local gs = require "gitsigns"
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", function()
        gs.nav_hunk "next"
      end, "Next Hunk")
      map("n", "[h", function()
        gs.nav_hunk "prev"
      end, "Prev Hunk")

      -- Actions
      map("n", "<leader>gsh", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>gb", function()
        gs.blame_line { full = true }
      end, "Blame Line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Line Blame")
      map("n", "<leader>gd", gs.diffthis, "Diff This")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select Hunk")
    end,
  },
}
