return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    max_lines = 3,
    min_window_height = 20,
    line_numbers = true,
    multiline_threshold = 1,
    trim_scope = "outer",
    mode = "cursor",
    zindex = 20,
    on_attach = function(buf)
      local ft = vim.bo[buf].filetype
      return not vim.tbl_contains({ "snacks_dashboard", "snacks_picker_list", "trouble" }, ft)
    end,
  },
  keys = {
    {
      "<leader>cC",
      function() require("treesitter-context").go_to_context(vim.v.count1) end,
      desc = "Go to context start",
    },
  },
}
