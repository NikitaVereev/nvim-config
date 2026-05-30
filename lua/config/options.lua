vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.showmode = false        -- statusline shows the mode
vim.opt.laststatus = 3          -- one global statusline
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Files / persistence
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- UX
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.confirm = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.pumheight = 10

-- Display
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }
vim.opt.conceallevel = 2        -- markdown rendering needs this

-- Folding open by default; treesitter foldexpr is set per-buffer.
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- Quieter command line
vim.opt.shortmess:append("cI")

-- Visual-block can go past EOL; don't auto-continue comments on new lines.
vim.opt.virtualedit = "block"
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Treat .env* files as sh for highlighting.
vim.filetype.add({
  pattern = {
    ["%.env%..*"] = "sh",
    ["%.env"] = "sh",
  },
})

-- Disable unused providers (faster startup, no warnings).
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 1
