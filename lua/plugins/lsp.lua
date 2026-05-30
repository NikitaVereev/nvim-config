return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
          },
        },
        virtual_text = false,  -- tiny-inline-diagnostic renders these
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(args)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          map("n", "gd",          function() Snacks.picker.lsp_definitions() end,      "Go to definition")
          map("n", "gi",          function() Snacks.picker.lsp_implementations() end,  "Go to implementation")
          map("n", "gy",          function() Snacks.picker.lsp_type_definitions() end, "Go to type definition")
          map("n", "gr",          function() Snacks.picker.lsp_references() end,       "Find references")
          map("n", "gD",          vim.lsp.buf.declaration,                             "Go to declaration")
          map("n", "K",           vim.lsp.buf.hover,                                   "Hover docs")
          map("n", "<C-k>",       vim.lsp.buf.signature_help,                          "Signature help")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,                     "Code action")
          map("n", "<leader>rn",  vim.lsp.buf.rename,                                  "Rename symbol")
          map("n", "<leader>lr",  "<cmd>LspRestart<cr>",                               "Restart LSP")
          map("n", "<leader>li",  "<cmd>checkhealth vim.lsp<cr>",                      "LSP info")
        end,
      })

      -- Wildcard config — capabilities apply to every server.
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "vtsls",
          "vue_ls",
          "angularls",
          "svelte",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "bashls",
          "pyright",
          "gopls",
          "rust_analyzer",
          "taplo",
          "dockerls",
          "prismals",
          "eslint",
        },
        automatic_enable = true,
      })
    end,
  },
}
