return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({ settings = { save_on_toggle = true, sync_on_ui_close = true } })

    local map = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc }) end

    map("<leader>ha", function() harpoon:list():add() end,                         "Harpoon: add file")
    map("<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon: menu")
    map("<leader>hc", function() harpoon:list():clear() end,                       "Harpoon: clear")

    map("<leader>1", function() harpoon:list():select(1) end, "Harpoon 1")
    map("<leader>2", function() harpoon:list():select(2) end, "Harpoon 2")
    map("<leader>3", function() harpoon:list():select(3) end, "Harpoon 3")
    map("<leader>4", function() harpoon:list():select(4) end, "Harpoon 4")
  end,
}
