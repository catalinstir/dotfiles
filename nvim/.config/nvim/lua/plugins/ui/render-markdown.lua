return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "quarto" }, -- lazy-load on markdown-like files
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- pick ONE:
    "nvim-mini/mini.nvim", -- preferred modern choice
    -- or "nvim-tree/nvim-web-devicons",
  },

  opts = {
    -- enable plugin
    enabled = true,

    -- where rendering is active
    render_modes = { "n", "c", "i" },

    -- filetypes to render
    file_types = { "markdown", "quarto" },

    -- general behavior
    max_file_size = 10.0, -- MB

    -- heading styling
    heading = {
      enabled = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      position = "overlay",
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
    },

    -- code blocks
    code = {
      enabled = true,
      style = "full", -- full | language | none
      position = "left",
      width = "block",
    },

    -- tables
    pipe_table = {
      enabled = true,
      preset = "round", -- round | double | heavy | none
    },

    -- block quotes / callouts
    quote = {
      enabled = true,
      icon = "▋",
    },

    -- checkboxes
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰱒 " },
    },

    -- links
    link = {
      enabled = true,
      underline = true,
    },

    -- LaTeX
    latex = {
      enabled = true,
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- optional highlight tweaks
    vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#3b1f1f" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#3b2f1f" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#3b3b1f" })
    vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1f3b2f" })
  end,
}
