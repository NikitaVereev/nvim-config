return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>tt", function() require("neotest").run.run() end,                        desc = "Run nearest test" },
    { "<leader>tT", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Run file" },
    { "<leader>ta", function() require("neotest").run.run(vim.loop.cwd()) end,          desc = "Run all (cwd)" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                   desc = "Run last" },
    { "<leader>tS", function() require("neotest").run.stop() end,                       desc = "Stop" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                 desc = "Toggle summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true }) end,    desc = "Show output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,            desc = "Toggle output panel" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Watch file" },
    -- ]t/[t are used by todo-comments — failed-test navigation goes through <leader>t*.
    { "<leader>tn", function() require("neotest").jump.next({ status = "failed" }) end, desc = "Next failed test" },
    { "<leader>tp", function() require("neotest").jump.prev({ status = "failed" }) end, desc = "Prev failed test" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        }),
      },
      icons = {
        passed  = " ",
        failed  = " ",
        running = " ",
        skipped = " ",
        unknown = " ",
      },
      quickfix     = { open = false },
      output       = { open_on_run = false },
      output_panel = { open = "botright split | resize 15" },
      summary = {
        animated = false,
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          jumpto = "i",
          output = "o",
          run    = "r",
          stop   = "u",
          target = "t",
          watch  = "w",
        },
      },
    })
  end,
}
