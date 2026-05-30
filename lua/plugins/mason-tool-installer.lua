-- Installs non-LSP tools (formatters, linters). LSP servers handled by mason-lspconfig.
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  cmd = {
    "MasonToolsInstall", "MasonToolsInstallSync",
    "MasonToolsUpdate", "MasonToolsClean",
  },
  event = "VeryLazy",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "stylua", "prettierd", "shfmt", "ruff", "goimports", "gofumpt",
        -- Linters
        "shellcheck", "hadolint",
      },
      run_on_start = true,
      start_delay = 1000,  -- give mason time to init
      auto_update = false,
    })
  end,
}
