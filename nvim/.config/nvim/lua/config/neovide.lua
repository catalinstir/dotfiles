if vim.g.neovide then
  -- Font
  vim.o.guifont = "Iosevka NF:h10"

  -- Fullscreen
  vim.g.neovide_fullscreen = true

  -- No transparency
  vim.g.neovide_opacity = 1.0

  -- Performance & Visual tweaks
  vim.g.neovide_refresh_rate = 60
  -- vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.3

  -- Disable some animations for better performance
  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_position_animation_length = 0.1
  vim.g.neovide_floating_blur_amount_x = 0.0
  vim.g.neovide_floating_blur_amount_y = 0.0

  -- Padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Zoom keymaps
  vim.keymap.set("n", "<C-=>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = "Neovide | Zoom in" })

  vim.keymap.set("n", "<C-+>", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * 1.1
  end, { desc = "Neovide | Zoom in" })

  vim.keymap.set("n", "<C-->", function()
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor / 1.1
  end, { desc = "Neovide | Zoom out" })

  vim.keymap.set("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Neovide | Reset zoom" })
end
