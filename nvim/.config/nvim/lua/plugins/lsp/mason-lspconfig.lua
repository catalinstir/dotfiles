return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Define diagnostic signs
    local signs = { Error = "", Warn = "", Hint = "󰌵", Info = "" }

    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
          [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
          [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
        },
      },
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        source = true,
        header = "",
        prefix = "",
      },
    }

    -- Set default capabilities for all servers
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    -- Setup mason-lspconfig with automatic_enable
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd" },
      automatic_enable = true,
    }

    -- LSP keymaps (K, [d, ]d and gr* — grn rename, gra code action, grr references —
    -- are Neovim 0.11+ defaults)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
      end,
    })
  end,
}
