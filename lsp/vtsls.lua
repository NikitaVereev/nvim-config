-- vtsls replaces ts_ls — Vue tooling team recommends it for hybrid mode.
local inlayHints = {
  enumMemberValues        = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  parameterNames          = { enabled = "literals" },
  parameterTypes          = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes           = { enabled = false },  -- noisy
}

return {
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx",
    "vue",
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = vim.fs.joinpath(
              vim.fn.stdpath("data"),
              "mason", "packages", "vue-language-server",
              "node_modules", "@vue", "language-server"
            ),
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = { enableServerSideFuzzyMatch = true },
      },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = inlayHints,
    },
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = inlayHints,
    },
  },
}
