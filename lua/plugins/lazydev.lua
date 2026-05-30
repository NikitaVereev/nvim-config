return {
  "folke/lazydev.nvim",
  ft = "lua", -- грузим только когда открыт Lua-файл
  opts = {
    library = {
      -- Подключить типы lazy.nvim (когда видишь require("lazy"))
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "lazy.nvim",
    },
  },
}
