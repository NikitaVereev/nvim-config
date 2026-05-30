return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = { show_success_message = true },
  keys = {
    -- Extract (visual)
    { "<leader>re", function() require("refactoring").refactor("Extract Function") end,         mode = "x", desc = "Extract function" },
    { "<leader>rf", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "Extract function → file" },
    { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end,         mode = "x", desc = "Extract variable" },

    -- Inline
    { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "Inline variable" },
    { "<leader>rI", function() require("refactoring").refactor("Inline Function") end, mode = "n",         desc = "Inline function" },

    -- Extract block (normal)
    { "<leader>rb", function() require("refactoring").refactor("Extract Block") end,         mode = "n", desc = "Extract block" },
    { "<leader>rB", function() require("refactoring").refactor("Extract Block To File") end, mode = "n", desc = "Extract block → file" },

    -- Print debugging
    { "<leader>rp", function() require("refactoring").debug.printf({ below = true }) end, mode = "n",          desc = "Debug print (printf)" },
    { "<leader>rP", function() require("refactoring").debug.print_var() end,              mode = { "n", "x" }, desc = "Debug print variable" },
    { "<leader>rc", function() require("refactoring").debug.cleanup({}) end,              mode = "n",          desc = "Cleanup debug prints" },

    -- Refactor picker
    { "<leader>rr", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Select refactor" },
  },
}
