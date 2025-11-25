return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      enabled = function()
        return vim.fn.executable "make" == 1
      end,
    },
    "andrew-george/telescope-themes",
  },
  cmd = "Telescope",
  keys = {
    -- Files
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<cr>", desc = "Find All Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },

    -- Search
    { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },

    -- Buffers & Navigation
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },

    -- Config
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>ft", "<cmd>Telescope themes<cr>", desc = "Themes" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },

    -- LSP
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
    { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

    -- Git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
  },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local action_layout = require "telescope.actions.layout"

    telescope.setup {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.jpg",
          "%.png",
          "%.jpeg",
          "%.gif",
          "%.webp",
          "%.pdf",
        },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        mappings = {
          i = {
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,
            ["<Esc>"] = actions.close,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-h>"] = action_layout.toggle_preview,

            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["q"] = actions.close,
            ["<Esc>"] = actions.close,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<C-h>"] = action_layout.toggle_preview,

            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        buffers = {
          initial_mode = "normal",
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
            n = {
              ["dd"] = actions.delete_buffer,
            },
          },
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    }

    -- Load extensions
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "themes")
  end,
}
