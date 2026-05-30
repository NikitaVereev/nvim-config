return {
  "Bekaboo/dropbar.nvim",
  event = "VeryLazy",
  opts = {
    bar = {
      enable = function(buf, win)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then return false end
        if vim.fn.win_gettype(win) ~= "" then return false end
        local ft = vim.bo[buf].filetype
        if vim.tbl_contains({ "snacks_dashboard", "snacks_picker_list", "trouble", "qf", "help" }, ft) then
          return false
        end
        return vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= ""
      end,
    },
  },
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end,                desc = "Pick symbol (winbar)" },
    { "[;",        function() require("dropbar.api").goto_context_start() end,  desc = "Goto context start" },
    { "];",        function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
  },
}
