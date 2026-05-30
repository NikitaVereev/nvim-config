return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "1.*",
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "xzbdmw/colorful-menu.nvim", opts = {} },
  },
  opts_extend = { "sources.default" },
  opts = {
    -- C-y accept, C-e cancel, C-n/C-p move, C-Space show.
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "mono" },

    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = false },
      menu = {
        border = "rounded",
        -- colorful-menu paints kinds/signatures like VSCode.
        draw = {
          treesitter = { "lsp" },
          components = {
            label = {
              text      = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
          },
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    signature = { enabled = true, window = { border = "rounded" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
