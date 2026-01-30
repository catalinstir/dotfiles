return {
  -- Clangd extensions for better C/C++ support
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      server = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      },
      extensions = {
        autoSetHints = true,
        inlay_hints = {
          inline = false,
        },
      },
    },
  },

  -- CMake integration
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "cmake", "c", "cpp" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>Eb", "<cmd>CMakeBuild<cr>", desc = "Embedded | Build" },
      { "<leader>Ec", "<cmd>CMakeClean<cr>", desc = "Embedded | Clean" },
      { "<leader>Eg", "<cmd>CMakeGenerate<cr>", desc = "Embedded | Generate" },
      { "<leader>Er", "<cmd>CMakeRun<cr>", desc = "Embedded | Run" },
      { "<leader>Es", "<cmd>CMakeSettings<cr>", desc = "Embedded | Settings" },
    },
    opts = {
      cmake_build_directory = "build",
      cmake_generate_options = { "-DCMAKE_BUILD_TYPE=Debug", "-G", "Ninja" },
      cmake_build_options = { "-j", "4" },
      cmake_soft_link_compile_commands = true,
    },
  },

  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Debug | Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Debug | Continue" },
      { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Debug | Step Into" },
      { "<leader>do", "<cmd>DapStepOut<cr>", desc = "Debug | Step Out" },
      { "<leader>dO", "<cmd>DapStepOver<cr>", desc = "Debug | Step Over" },
      { "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Debug | Terminate" },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug | Toggle UI",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Setup DAP UI
      dapui.setup {
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      }

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Virtual text setup
      require("nvim-dap-virtual-text").setup {
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      }

      -- GDB adapter for ARM debugging
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb-multiarch",
        args = { "-i", "dap" },
      }

      -- C/C++ configurations for embedded
      dap.configurations.c = {
        {
          name = "KL25Z (OpenOCD + GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to ELF: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          setupCommands = {
            {
              text = "target extended-remote localhost:3333",
              description = "Connect to OpenOCD",
              ignoreFailures = false,
            },
            {
              text = "monitor reset halt",
              description = "Reset and halt",
              ignoreFailures = false,
            },
            {
              text = "load",
              description = "Load program",
              ignoreFailures = false,
            },
            {
              text = "monitor reset init",
              description = "Reset init",
              ignoreFailures = false,
            },
          },
        },
        {
          name = "K66 (OpenOCD + GDB)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to ELF: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          setupCommands = {
            {
              text = "target extended-remote localhost:3333",
              description = "Connect to OpenOCD",
              ignoreFailures = false,
            },
            {
              text = "monitor reset halt",
              description = "Reset and halt",
              ignoreFailures = false,
            },
            {
              text = "load",
              description = "Load program",
              ignoreFailures = false,
            },
            {
              text = "monitor reset init",
              description = "Reset init",
              ignoreFailures = false,
            },
          },
        },
      }

      -- Copy C config to C++
      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
