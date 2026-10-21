return {
  "saghen/blink.cmp",
  version = "1.*", -- release tags ship a prebuilt Rust fuzzy matcher
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      -- Only confirms an item you explicitly selected; otherwise inserts a newline
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon", "kind", gap = 1 },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = "rounded", max_width = 80, max_height = 15 },
      },
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
    cmdline = { enabled = false },
  },
}
