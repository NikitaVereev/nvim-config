-- Auto-save sessions per cwd; restore is manual so Dashboard always shows on cold start.
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
    need = 1,
  },
  keys = {
    { "<leader>qs", function() require("persistence").load() end,                desc = "Restore session (cwd)" },
    { "<leader>qS", function() require("persistence").select() end,              desc = "Select session" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
    { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't save current session" },
  },
}
