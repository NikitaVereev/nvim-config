return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer / selection",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      javascript      = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript      = { "prettierd" },
      typescriptreact = { "prettierd" },
      vue             = { "prettierd" },
      svelte          = { "prettierd" },
      html            = { "prettierd" },
      css             = { "prettierd" },
      scss            = { "prettierd" },
      json            = { "prettierd" },
      jsonc           = { "prettierd" },
      yaml            = { "prettierd" },
      markdown        = { "prettierd" },
      graphql         = { "prettierd" },

      python = { "ruff_format" },
      go     = { "goimports", "gofumpt" },  -- imports first, then style
      rust   = { "rustfmt" },
      sh     = { "shfmt" },
      bash   = { "shfmt" },
      toml   = { "taplo" },
    },

    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 3000,
    },

    -- format_on_save intentionally disabled — manual via <leader>cf.
    notify_on_error = true,

    formatters = {
      shfmt = { prepend_args = { "-i", "2", "-ci" } },
    },
  },
}
