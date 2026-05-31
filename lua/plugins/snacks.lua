return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile   = { enabled = true },
    quickfile = { enabled = true },
    input     = { enabled = true },
    notifier  = { enabled = true, timeout = 3000, style = "compact" },
    indent    = {
      enabled = true,
      indent = { char = "│" },
      scope = { char = "│", underline = false },
    },
    scope     = { enabled = true },
    words     = { enabled = true, debounce = 200 },

    picker = {
      enabled = true,
      sources = {
        files    = { hidden = true, exclude = { ".git" } },
        explorer = { hidden = true, exclude = { ".git" } },
        -- Picking a project: cd + load session (persistence.nvim).
        projects = { confirm = "load_session" },
      },
      win = { input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } } },
    },

    explorer = { enabled = true },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File",        action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "p", desc = "Projects",        action = ":lua Snacks.picker.projects()" },
          { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
        },
      },
    },

    lazygit      = { enabled = true },
    terminal     = { enabled = true },
    scroll       = { enabled = false },
    statuscolumn = { enabled = false },
  },

  keys = {
    -- Picker
    { "<leader><space>", function() Snacks.picker.smart() end,                                                     desc = "Smart find" },
    { "<leader>ff",      function() Snacks.picker.files() end,                                                     desc = "Files" },
    { "<leader>fF",      function() Snacks.picker.files({ hidden = true, ignored = true }) end,                    desc = "Files (all)" },
    { "<leader>fg",      function() Snacks.picker.grep() end,                                                      desc = "Live grep" },
    { "<leader>fG",      function() Snacks.picker.grep_word() end,                                                 desc = "Grep word",         mode = { "n", "v" } },
    { "<leader>fb",      function() Snacks.picker.buffers() end,                                                   desc = "Buffers" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                                    desc = "Recent files" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                   desc = "Config files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                                  desc = "Projects" },
    { "<leader>fz",      function() Snacks.picker.zoxide() end,                                                    desc = "Zoxide (frecent dirs)" },
    { "<leader>fh",      function() Snacks.picker.help() end,                                                      desc = "Help tags" },
    { "<leader>fk",      function() Snacks.picker.keymaps() end,                                                   desc = "Keymaps" },
    { "<leader>fn",      function() Snacks.picker.notifications() end,                                             desc = "Notifications history" },
    { "<leader>f:",      function() Snacks.picker.command_history() end,                                           desc = "Command history" },
    { "<leader>f/",      function() Snacks.picker.lines() end,                                                     desc = "Lines in buffer" },

    -- Symbols / diagnostics
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                               desc = "Document symbols" },
    { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                                     desc = "Workspace symbols" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                               desc = "Diagnostics (workspace)" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                                        desc = "Diagnostics (buffer)" },

    -- Explorer
    { "<leader>e",       function() Snacks.explorer() end,                                                         desc = "Toggle explorer" },
    { "<leader>E",       function() Snacks.explorer.reveal() end,                                                  desc = "Reveal in explorer" },

    -- Lazygit
    { "<leader>gg",      function() Snacks.lazygit() end,                                                          desc = "Lazygit" },
    { "<leader>gf",      function() Snacks.lazygit.log_file() end,                                                 desc = "Lazygit: current file" },
    { "<leader>gl",      function() Snacks.lazygit.log() end,                                                      desc = "Lazygit: log" },

    -- Notifications
    { "<leader>n",       function() Snacks.notifier.show_history() end,                                            desc = "Notifications history" },
    { "<leader>un",      function() Snacks.notifier.hide() end,                                                    desc = "Dismiss notifications" },

    -- Some terminals send <C-_> instead of <C-/> for the same chord; bind both.
    { "<C-/>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
    { "<C-_>", function() Snacks.terminal() end, mode = { "n", "t" }, desc = "Toggle terminal" },
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap",  { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.indent():map("<leader>ui")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })

    -- LSP progress through Snacks notifier (snippet from snacks docs/notifier.md).
    local progress = vim.defaulttable()
    vim.api.nvim_create_autocmd("LspProgress", {
      ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value
        if not client or type(value) ~= "table" then return end
        local p = progress[client.id]

        for i = 1, #p + 1 do
          if i == #p + 1 or p[i].token == ev.data.params.token then
            p[i] = {
              token = ev.data.params.token,
              msg = ("[%3d%%] %s%s"):format(
                value.kind == "end" and 100 or value.percentage or 100,
                value.title or "",
                value.message and (" **%s**"):format(value.message) or ""
              ),
              done = value.kind == "end",
            }
            break
          end
        end

        local msg = {}
        progress[client.id] = vim.tbl_filter(function(v)
          return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
          id = "lsp_progress",
          title = client.name,
          opts = function(notif)
            notif.icon = #progress[client.id] == 0 and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })
  end,
}
