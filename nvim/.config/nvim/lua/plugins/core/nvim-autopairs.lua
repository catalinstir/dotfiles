return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require "nvim-autopairs"
    local Rule = require "nvim-autopairs.rule"
    local cond = require "nvim-autopairs.conds"

    autopairs.setup {
      check_ts = true, -- Enable treesitter
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" },
        java = false, -- Don't check treesitter on java
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      disable_in_macro = false,
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = true,
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      check_ts = true,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    }

    -- Integration with nvim-cmp
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp = require "cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Add spaces between parentheses
    local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
    autopairs.add_rules {
      Rule(" ", " "):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({
          brackets[1][1] .. brackets[1][2],
          brackets[2][1] .. brackets[2][2],
          brackets[3][1] .. brackets[3][2],
        }, pair)
      end),
    }

    -- Add rule for pressing <CR> inside brackets (code block formatting)
    for _, bracket in pairs(brackets) do
      autopairs.add_rules {
        Rule(bracket[1] .. " ", " " .. bracket[2])
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match ".%" .. bracket[2] ~= nil
          end)
          :use_key(bracket[2]),
      }
    end

    -- Enhanced <CR> behavior for brackets
    autopairs.add_rules {
      Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript", "javascriptreact" })
        :use_regex(true)
        :set_end_pair_length(2),
    }

    -- Press <CR> inside () {} [] to create a code block
    -- Example: pressing enter after '(' gives:
    -- (
    --   |cursor here
    -- )
  end,
}
