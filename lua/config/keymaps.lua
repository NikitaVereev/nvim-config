local map = vim.keymap.set

-- Better defaults
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Line navigation
map({ "n", "v", "o" }, "H", "^", { desc = "Start of line" })
map({ "n", "v", "o" }, "L", "$", { desc = "End of line" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Visual mode niceties
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line(s) down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line(s) up" })
map("v", "<", "<gv",   { desc = "Indent left (keep selection)" })
map("v", ">", ">gv",   { desc = "Indent right (keep selection)" })
map("v", "p", '"_dP',  { desc = "Paste without overwriting register" })

-- Window resize (Ctrl+arrows). <C-hjkl> handled by vim-tmux-navigator.
map("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Window taller" })
map("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Window shorter" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Window narrower" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Window wider" })

-- Splits — only the few worth a shortcut. Window prefix is direct <C-w>.
map("n", "<leader>ww", "<C-w>w",          { desc = "Other window" })
map("n", "<leader>wd", "<cmd>close<cr>",  { desc = "Close window" })
map("n", "<leader>w-", "<cmd>split<cr>",  { desc = "Split horizontal" })
map("n", "<leader>w|", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>w=", "<C-w>=",          { desc = "Equalize windows" })

-- Buffers
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current
      and vim.api.nvim_buf_is_loaded(buf)
      and vim.bo[buf].buflisted
      and vim.bo[buf].buftype == ""
    then
      pcall(vim.api.nvim_buf_delete, buf, {})
    end
  end
end, { desc = "Delete other buffers" })

-- Quickfix navigation (open/close via Trouble's <leader>xq).
map("n", "[q", "<cmd>cprevious<cr>", { desc = "Prev quickfix" })
map("n", "]q", "<cmd>cnext<cr>",     { desc = "Next quickfix" })

-- Diagnostics
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 })  end, { desc = "Next diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev error" })
map("n", "]e", function() vim.diagnostic.jump({ count = 1,  severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Quit — :q is direct. <leader>Q for force-quit-all (no delay).
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Terminal
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Misc
map({ "n", "v" }, "x", '"_x', { desc = "Delete char (no register)" })
map("n", "U", "<C-r>",        { desc = "Redo" })
