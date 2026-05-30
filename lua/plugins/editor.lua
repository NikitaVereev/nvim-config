return {
  -- mini.surround — vim-surround style: ysiw" / ds" / cs"'
  {
    "echasnovski/mini.surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        add = "ys", delete = "ds", replace = "cs",
        find = "", find_left = "", highlight = "", update_n_lines = "",
      },
      search_method = "cover_or_next",
    },
  },

  -- mini.ai — extra text-objects (a/i): a/argument, f/function, c/class, o/block, t/tag
  {
    "echasnovski/mini.ai",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer",    i = "@class.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },  -- HTML tag
        },
      }
    end,
  },

  -- mini.pairs — auto-close brackets/quotes
  {
    "echasnovski/mini.pairs",
    version = "*",
    event = "InsertEnter",
    opts = {
      modes = { insert = true, command = false, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
    },
  },

  -- mini.icons — icon provider used by Snacks, Lualine, etc.
  {
    "echasnovski/mini.icons",
    version = "*",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- flash — labelled jumps. s = jump, S = treesitter node jump.
  {
    "folke/flash.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      modes = {
        char   = { enabled = true, jump_labels = true, multi_line = true },
        search = { enabled = false },  -- noisy when integrated with /
      },
    },
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter search" },
      { "<C-s>", mode = "c",               function() require("flash").toggle() end,            desc = "Toggle flash search" },
    },
  },

  -- nvim-ts-autotag — auto-close/rename HTML/JSX/Vue tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "xml", "markdown" },
    opts = {},
  },
}
