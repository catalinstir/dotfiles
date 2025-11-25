return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    -- { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus file explorer" },
    -- { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find current file in tree" },
    -- { "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "Collapse all folders" },
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- Custom highlights for better visuals
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#8AADF4" })
    vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#F5A97F" })
    vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#A6DA95" })
    vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#ED8796" })
    vim.api.nvim_set_hl(0, "NvimTreeModifiedFile", { fg = "#EED49F" })

    require("nvim-tree").setup {
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      reload_on_bufenter = true,
      select_prompts = false,
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 35,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = true,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = {
          "Cargo.toml",
          "Makefile",
          "README.md",
          "readme.md",
          "package.json",
          "CMakeLists.txt",
          ".gitignore",
        },
        symlink_destination = true,
        highlight_git = true,
        highlight_diagnostics = true,
        highlight_opened_files = "name",
        highlight_modified = "name",
        highlight_bookmarks = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          padding = " ",
          symlink_arrow = "  ", --
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = "", --
            symlink = "", --
            bookmark = "", -- 󰆤
            modified = "●",
            folder = {
              arrow_closed = "", --
              arrow_open = "", --
              default = "", --
              open = "", --
              empty = "", --
              empty_open = "", --
              symlink = "", --
              symlink_open = "", --
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "", --
              renamed = "➜",
              untracked = "★",
              deleted = "󰅖", --
              ignored = "◌",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = true,
        update_root = {
          enable = true,
          ignore_list = {},
        },
        exclude = false,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "󰌶", --
          info = "󰋽", --
          warning = "", --
          error = "󰅚", --
        },
      },
      filters = {
        enable = true,
        dotfiles = false,
        git_clean = false,
        git_ignored = false,
        no_buffer = false,
        no_bookmark = false,
        custom = { "^.git$" },
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = { "node_modules", ".git", "target" },
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "rounded",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
      },
      help = {
        sort_by = "key",
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = false,
        },
      },
      experimental = {},
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          profile = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          -- watcher = false,
          -- watchers = false,
        },
      },
    }

    -- Auto-close nvim-tree when it's the last window
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match "NvimTree_" ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
            table.insert(floating_wins, w)
          end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
