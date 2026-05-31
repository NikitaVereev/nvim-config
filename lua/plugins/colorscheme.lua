-- Active theme is persisted to stdpath("state")/colorscheme and restored on startup.
local state_file = vim.fs.joinpath(vim.fn.stdpath("state"), "colorscheme")

local function save_theme(name)
  local f = io.open(state_file, "w")
  if f then f:write(name); f:close() end
end

local function read_theme()
  local f = io.open(state_file, "r")
  if not f then return nil end
  local name = f:read("*l")
  f:close()
  return name
end

local function apply_saved_or_default(default)
  local saved = read_theme()
  if not pcall(vim.cmd.colorscheme, saved or default) then
    vim.cmd.colorscheme(default)
  end
end

local function pick_theme()
  Snacks.picker.colorschemes({
    confirm = function(picker, item)
      picker:close()
      vim.cmd.colorscheme(item.text)
      save_theme(item.text)
      vim.notify("Theme: " .. item.text, vim.log.levels.INFO)
    end,
  })
end

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_mode = true,
      italic = { strings = false, comments = true, operators = false, folds = true },
    },
    config = function(_, opts)
      require("gruvbox").setup(opts)
      apply_saved_or_default("gruvbox")
      vim.keymap.set("n", "<leader>uC", pick_theme, { desc = "Pick colorscheme" })
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 999,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = { enabled = true },
        notify = true,
        snacks = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 999,
    opts = {
      style = "night",
      transparent = true,
      styles = { sidebars = "transparent", floats = "transparent" },
    },
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 999,
    opts = {
      theme = "wave",
      transparent = true,
      background = { dark = "wave", light = "lotus" },
    },
  },
}
