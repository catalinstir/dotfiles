return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = {
      blue = "#80a0ff",
      cyan = "#79dac8",
      black = "#080808",
      white = "#c6c6c6",
      red = "#ff5189",
      violet = "#d183e8",
      grey = "#303030",
    }

    -- Custom theme (optional, remove if you want auto theme)
    local custom_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black },
      },
      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },
      inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, bg = colors.black },
      },
    }

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "auto", -- Change to custom_theme if you want custom colors
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "starter" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
          },
          {
            "filename",
            file_status = true,
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            shorting_target = 40,
            symbols = {
              modified = "[+]",
              readonly = "[-]",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = {
          {
            -- Show LSP status
            function()
              local buf_clients = vim.lsp.get_clients { bufnr = 0 }
              if #buf_clients == 0 then
                return "LSP Inactive"
              end

              local buf_client_names = {}
              for _, client in pairs(buf_clients) do
                if client.name ~= "null-ls" then
                  table.insert(buf_client_names, client.name)
                end
              end

              return "[" .. table.concat(buf_client_names, ", ") .. "]"
            end,
            icon = "",
          },
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "filetype",
        },
        lualine_y = {
          "progress",
        },
        lualine_z = {
          "location",
          {
            -- Show total lines
            function()
              return "󰦨 " .. vim.fn.line "$"
            end,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = { "nvim-tree", "lazy", "mason", "trouble" },
    }
  end,
}
