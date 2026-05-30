return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    file_types = { "markdown" },
    render_modes = { "n", "c", "t" },  -- raw text in insert mode
    code = { sign = false, width = "block", right_pad = 1 },
    heading = {
      sign = false,
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
    },
    checkbox = { enabled = true },
  },
}
