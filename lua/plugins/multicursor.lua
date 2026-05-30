return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local map = vim.keymap.set

    -- VSCode-style: word under cursor → <leader>mn repeatedly to grow selection.
    map({ "n", "x" }, "<leader>mn", function() mc.matchAddCursor(1) end,    { desc = "MC: add next match" })
    map({ "n", "x" }, "<leader>mN", function() mc.matchAddCursor(-1) end,   { desc = "MC: add prev match" })
    map({ "n", "x" }, "<leader>ms", function() mc.matchSkipCursor(1) end,   { desc = "MC: skip match" })
    map({ "n", "x" }, "<leader>ma", function() mc.matchAllAddCursors() end, { desc = "MC: add all matches" })

    map({ "n", "x" }, "<leader>mj", function() mc.lineAddCursor(1) end,  { desc = "MC: cursor below" })
    map({ "n", "x" }, "<leader>mk", function() mc.lineAddCursor(-1) end, { desc = "MC: cursor above" })

    map({ "n", "x" }, "<leader>mt", function() mc.toggleCursor() end, { desc = "MC: toggle cursor" })
    map({ "n", "x" }, "<C-q>",      function() mc.toggleCursor() end, { desc = "MC: quick toggle" })

    -- In-mode layer: switch main cursor, delete, exit.
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<left>",  function() mc.prevCursor() end)
      layerSet({ "n", "x" }, "<right>", function() mc.nextCursor() end)
      layerSet({ "n", "x" }, "<leader>mx", function() mc.deleteCursor() end)
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then mc.enableCursors()
        else mc.clearCursors() end
      end)
    end)
  end,
}
