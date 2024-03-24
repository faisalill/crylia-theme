local overrides = require "custom.configs.overrides"

local plugins = {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = overrides.copilot,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
  },
  {
    "smoka7/hop.nvim",
    keys = {
      {
        ",",
        function()
          require("hop").hint_words()
        end,
        mode = { "n", "x", "o" },
      },
      {
        "s",
        function()
          require("hop").hint_char2()
        end,
        mode = { "n", "x", "o" },
      },
      {
        "f",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
            current_line_only = true,
          }
        end,
        mode = { "n", "x", "o" },
      },
      {
        "F",
        function()
          require("hop").hint_char1 {
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
            current_line_only = true,
          }
        end,
        mode = { "n", "x", "o" },
      },
    },

    opts = {

      multi_windows = true,

      keys = "htnsueoaidgcrlypmbkjvx",

      uppercase_labels = true,

      -- reverse_distribution = true,
    },
  }, -- In order to modify the `lspconfig` configuration:
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "pyright",
          "gopls",
          "lua_ls",
          "html",
          "clangd",
          "cssls",
          "rust-analyzer",
          "arduino_language_server",
          "bashls",
          "dockerls",
          "tsserver",
          "svelte-language-server",
          "tailwindcss-language-server",
          "stylua",
          "prettier"
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function ()
      require("custom.configs.lint")
    end
  },
 {
    "mhartington/formatter.nvim",
    event="VeryLazy",
    opts = function ()
      return require("custom.configs.formatter")
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}

return plugins
