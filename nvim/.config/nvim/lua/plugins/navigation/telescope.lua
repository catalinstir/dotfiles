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
    {
      "<leader>ft",
      function()
        -- Colorschemes are lazy-loaded, so load every plugin that ships colors/ before listing them
        local schemes = vim.tbl_filter(function(p)
          return vim.uv.fs_stat(p.dir .. "/colors") ~= nil
        end, require("lazy").plugins())
        require("lazy").load {
          plugins = vim.tbl_map(function(p)
            return p.name
          end, schemes),
        }
        vim.cmd "Telescope themes"
      end,
      desc = "Themes",
    },
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
        prompt_prefix = "  :",
        selection_caret = " ",
        entry_prefix = " ",
        sorting_strategy = "ascending",
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
        border = {},
        set_env = { ["COLORTERM"] = "truecolor" },
        -- Only overrides of Telescope's defaults (<C-x>/<C-v>/<C-q>, j/k, gg/G etc. are built in)
        mappings = {
          i = {
            ["<Tab>"] = actions.move_selection_next,
            ["<S-Tab>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
            ["<C-h>"] = action_layout.toggle_preview,
          },
          n = {
            ["q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<C-h>"] = action_layout.toggle_preview,
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
