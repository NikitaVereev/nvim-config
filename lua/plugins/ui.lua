return {
  -- which-key — show available mappings after a prefix
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = { border = "rounded" },
      icons = { rules = false },
      spec = {
        { "<leader>b",  group = "buffers" },
        { "<leader>c",  group = "code" },
        { "<leader>f",  group = "find" },
        { "<leader>g",  group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>h",  group = "harpoon" },
        { "<leader>l",  group = "lsp" },
        { "<leader>m",  group = "multicursor" },
        { "<leader>q",  group = "session" },
        { "<leader>r",  group = "refactor/rename" },
        { "<leader>s",  group = "search/symbols" },
        { "<leader>t",  group = "test" },
        { "<leader>u",  group = "ui toggles" },
        { "<leader>w",  group = "windows" },
        { "<leader>x",  group = "diagnostics/lists" },
        { "[",          group = "prev" },
        { "]",          group = "next" },
        { "g",          group = "goto" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer keymaps",
      },
    },
  },

  -- tiny-inline-diagnostic — inline diagnostic rendering (we disabled virtual_text in lsp.lua).
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "modern",
      options = {
        show_source = true,
        use_icons_from_diagnostic = true,
        multilines = { enabled = true, always_show = false },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
      },
    },
  },

  -- trouble — persistent UI for diagnostics/refs/symbols/qflist
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      focus = true,
      win = { border = "rounded" },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                         desc = "Diagnostics (workspace)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",            desc = "Diagnostics (buffer)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                 desc = "Symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",  desc = "LSP defs/refs" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                              desc = "Quickfix" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                             desc = "Location list" },
    },
  },

  -- todo-comments — highlight TODO/FIXME/HACK/...
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      keywords = {
        FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "default", alt = { "OPTIM", "PERFORMANCE" } },
        NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test",   alt = { "TESTING", "PASSED", "FAILED" } },
      },
    },
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                       desc = "Todo (Trouble)" },
      {
        "<leader>st",
        function()
          Snacks.picker.grep({ search = [[\b(TODO|FIXME|FIX|HACK|WARN|NOTE|PERF|XXX|BUG)\b]] })
        end,
        desc = "Find todos",
      },
    },
  },
}
