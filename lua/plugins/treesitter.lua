-- nvim-treesitter `main` branch (master is archived, frozen on nvim 0.11).
-- Parsers install via :TSInstall / the install() call below; highlight + indent
-- are enabled manually per FileType. Needs system tree-sitter CLI.

local parsers = {
  -- web
  "javascript", "typescript", "tsx", "jsdoc",
  "vue", "svelte", "angular",
  "html", "css", "scss",
  -- config / data
  "json", "json5", "jsonc", "yaml", "toml",
  -- backend
  "lua", "luadoc", "luap",
  "python", "go", "rust", "bash",
  -- docs
  "markdown", "markdown_inline",
  -- infra / git
  -- gitignore omitted: parser repo renamed master→main, install script breaks (#7735).
  -- :TSInstall gitignore can be tried manually.
  "dockerfile", "gitcommit", "git_config",
  "diff", "regex",
  -- DB
  "prisma", "sql",
  -- vim
  "vim", "vimdoc", "query",
}

-- Filetypes (note: parser "tsx" → ft "typescriptreact", etc.)
local highlight_filetypes = {
  "lua", "vim", "vimdoc", "query",
  "javascript", "javascriptreact", "typescript", "typescriptreact",
  "vue", "svelte",
  "html", "css", "scss",
  "json", "jsonc", "yaml", "toml",
  "python", "go", "rust", "sh", "bash",
  "markdown",
  "dockerfile", "gitcommit",
  "prisma", "sql", "diff",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter_attach", { clear = true }),
        pattern = highlight_filetypes,
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then return end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Queries used by mini.ai for @function.outer / @class.outer / etc.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = true,
  },
}
