return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick Close Buffer" },
    { "<leader>bD", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
    { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
  },
  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      indicator = { style = "icon", icon = "▎" },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = { error = " ", warning = " ", hint = "󰌵 ", info = " " }
        local result = {}
        for name, count in pairs(diag) do
          if icons[name] and count > 0 then
            table.insert(result, icons[name] .. count)
          end
        end
        return #result > 0 and table.concat(result, " ") or ""
      end,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = "thin",
      always_show_bufferline = false, -- only shows when 2+ buffers open
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
}
