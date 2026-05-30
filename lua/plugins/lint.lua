return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  keys = {
    { "<leader>cl", function() require("lint").try_lint() end, desc = "Trigger linter" },
  },
  config = function()
    local lint = require("lint")

    -- LSP already lints eslint/gopls/rust-analyzer/lua_ls — don't duplicate.
    lint.linters_by_ft = {
      sh         = { "shellcheck" },
      bash       = { "shellcheck" },
      dockerfile = { "hadolint" },
      python     = { "ruff" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("user_lint", { clear = true }),
      callback = function() pcall(lint.try_lint) end,
    })
  end,
}
