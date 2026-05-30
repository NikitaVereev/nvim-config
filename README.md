# nvim-config

Минималистичный, быстрый, IDE-уровневый конфиг Neovim для повседневной разработки на TypeScript / Vue / React / Go / Rust / Python / Lua.

Цель — полная замена WebStorm/VSCode без перегруза. Каждый плагин решает **одну** задачу и проверен в реальной работе.

---

## Возможности

- **LSP**: `vtsls` (TypeScript/Vue hybrid), `vue_ls`, `lua_ls`, `rust_analyzer`, `gopls`, `pyright`, `eslint`, и ещё ~10 серверов через Mason
- **Автодополнение**: `blink.cmp` (Rust fuzzy matcher) + сниппеты + signature hints
- **Treesitter**: подсветка + indent + умные text-objects (`mini.ai`)
- **Picker / Explorer / Dashboard / Notifier / Lazygit**: `snacks.nvim`
- **Git**: `gitsigns`, `diffview`, `git-conflict`, `lazygit`
- **Форматирование**: `conform.nvim` (`prettierd`, `stylua`, `ruff`, `gofumpt`, `shfmt`...)
- **Линт**: `nvim-lint` (`shellcheck`, `hadolint`, `ruff`)
- **Тесты**: `neotest` (Vitest, Jest)
- **Рефакторинг**: `refactoring.nvim` (extract function/variable/block)
- **Multicursor**: `multicursor.nvim` (VSCode-style Ctrl-D)
- **Прыжки**: `flash.nvim` (labelled jumps)
- **Edit**: `mini.surround`, `mini.ai`, `mini.pairs`, `nvim-ts-autotag`
- **UI**: `lualine`, `which-key`, `dropbar` (breadcrumbs), `treesitter-context`, `render-markdown`, `tiny-inline-diagnostic`
- **Сессии**: `persistence.nvim` (per-cwd)
- **Закладки на файлы**: `harpoon` v2
- **tmux integration**: `vim-tmux-navigator` (`<C-hjkl>` сквозь панели)

---

## Требования

### Системные пакеты (обязательные)

| Пакет | Зачем |
|---|---|
| `neovim` ≥ 0.12 | сам редактор |
| `git`, `curl` | плагины, mason |
| `ripgrep` (`rg`) | live grep в picker |
| `fd` | поиск файлов в picker |
| `lazygit` | `<leader>gg` git TUI |
| `tree-sitter` CLI ≥ 0.26.1 | компиляция парсеров |
| `zoxide` | frecency-папки `<leader>fz` |
| `gcc`/`clang` + `make` | сборка парсеров и rust matcher |

### Шрифт

Нужен **Nerd Font** для иконок в statusline / dashboard / signs.
Рекомендую `JetBrainsMono Nerd Font`.

### Языковые toolchain'ы (опциональные — по необходимости)

| Язык | Что нужно |
|---|---|
| JS / TS / Vue / React | Node ≥ 18 (через `nvm`) |
| Rust | `rustup` + stable toolchain |
| Go | `go` ≥ 1.21 |
| Python | `python3` ≥ 3.10 |

LSP-серверы, форматтеры, линтеры **ставятся автоматически** через Mason на первом запуске. Руками их не трогаем.

---

## Установка

### macOS

```bash
# 1. Системные deps
brew install neovim tmux git ripgrep fd lazygit tree-sitter zoxide

# 2. Nerd Font
brew install --cask font-jetbrains-mono-nerd-font

# 3. Node (через nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# перезапусти shell
nvm install --lts && nvm use --lts

# 4. Rust (опционально, если пишешь на Rust)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# 5. Клонировать nvim-config напрямую
git clone https://github.com/NikitaVereev/nvim-config.git ~/.config/nvim

# 6. Запустить — плагины подтянутся автоматически
nvim
```

### Arch Linux

```bash
# 1. Системные deps
sudo pacman -S --needed \
  neovim tmux git \
  ripgrep fd lazygit \
  tree-sitter-cli zoxide \
  base-devel gcc

# 2. Nerd Font
sudo pacman -S ttf-jetbrains-mono-nerd

# 3. Node (через nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
# перезапусти shell
nvm install --lts && nvm use --lts

# 4. Rust (опционально)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# 5. Клонировать nvim-config
git clone https://github.com/NikitaVereev/nvim-config.git ~/.config/nvim

# 6. Запустить
nvim
```

### Первый запуск

`nvim` без аргументов откроет Dashboard. Затем:

```vim
:Lazy sync             " установит все плагины (~30-60 сек)
:MasonToolsInstall     " форматтеры + линтеры
:TSUpdate              " парсеры treesitter (~60 сек)
```

После — `:qa` и **перезапустить** `nvim`.

### Проверка

```vim
:checkhealth
```

Должно быть в основном зелёное. Допустимые warning'и:
- `python3-pynvim`, `ruby` — мы их отключили в `options.lua`, можно игнорировать
- `node` — нужен только если ставишь LSP'ы которые ставятся через npm (vtsls, vue_ls). Поставь nvm + node

---

## Структура

```
~/.config/nvim/
├── init.lua                # entry point
├── lazy-lock.json          # pinned plugin versions
├── lua/
│   ├── config/
│   │   ├── options.lua     # vim.opt.*
│   │   ├── keymaps.lua     # глобальные биндинги
│   │   ├── autocmds.lua    # автокоманды
│   │   └── lazy.lua        # bootstrap lazy.nvim
│   └── plugins/            # один плагин = один файл
│       ├── colorscheme.lua
│       ├── completion.lua  # blink.cmp + colorful-menu
│       ├── lsp.lua         # nvim-lspconfig + mason
│       ├── snacks.lua      # folke/snacks (picker/explorer/dashboard/lazygit/...)
│       ├── git.lua         # gitsigns + diffview + git-conflict
│       ├── editor.lua      # mini.* + flash + ts-autotag
│       ├── ui.lua          # which-key + trouble + todo-comments + tiny-diagnostic
│       └── ...
└── lsp/                    # per-server settings (nvim 0.11+ API)
    ├── vtsls.lua
    ├── vue_ls.lua
    ├── lua_ls.lua
    ├── eslint.lua
    └── ...
```

---

## Раскладка клавиш

Leader = `<Space>`.

Полный список доступен внутри nvim: `<leader>fk` (Snacks picker по всем keymaps).

Ключевые группы:

| Префикс | Группа |
|---|---|
| `<leader>f` | find (files, grep, recent, projects, ...) |
| `<leader>g` | git (lazygit, diff, blame, hunks) |
| `<leader>s` | search / symbols |
| `<leader>c` | code (format, diagnostics, lint, context) |
| `<leader>r` | refactor / rename |
| `<leader>m` | multicursor |
| `<leader>t` | test |
| `<leader>h` | harpoon |
| `<leader>x` | diagnostics / quickfix / trouble |
| `<leader>e` | explorer |
| `<leader>q` | session (persistence) |
| `<leader>u` | UI toggles |
| `<leader>b` | buffers |
| `<leader>w` | windows |

Точечно (примеры):

```
<leader><space>   Smart find file
<leader>ff        Files
<leader>fg        Live grep
<leader>fp        Projects picker
<leader>e         Toggle explorer
<leader>gg        Lazygit
<leader>cf        Format buffer / selection
<leader>ca        Code action
<leader>rn        Rename symbol (LSP)
gd / gr / gi / gy LSP: definition / references / impl / type
K                 LSP hover
s                 Flash jump
<leader>mn        Multicursor: add next match
<leader>tt        Run nearest test
<leader>1-4       Harpoon slots
```

---

## Типичные грабли

### Иконки выглядят как `[X]` или прямоугольники
Nerd Font не активен в терминале. Выстави шрифт в настройках Kitty/Alacritty/iTerm/etc.

### LSP не подключается к `.ts` / `.vue`
1. `:Mason` — `vtsls` и `vue_ls` должны быть в Installed.
2. Если нет: `:MasonInstall vtsls vue_ls`.
3. Перезапустить nvim.

### `:TSUpdate` падает или зависает
Проверь `tree-sitter --version` — должна быть **0.26.1+**. Обнови через brew/pacman.

### `:MasonToolsInstall` не сработал на старте
Mason ещё не успел проинициализироваться. Запусти команду вручную через ~10 сек после старта nvim.

### `<C-h/j/k/l>` не прыгает между tmux pane'ами
Нужен `vim-tmux-navigator` плагин **в самом tmux** (TPM). Проверь что в твоём `~/.config/tmux/tmux.conf` есть:
```
set -g @plugin 'christoomey/vim-tmux-navigator'
```
И в tmux выполни: `<prefix> I` (Shift-I).

### После правки `lsp/*.lua` ничего не меняется
Per-server конфиг считывается **один раз** при старте LSP. Нужен полный `:qa` + перезапуск nvim. `:LspRestart` не помогает.

### `gitignore` парсер ругается при установке treesitter
Известный issue ([#7735](https://github.com/nvim-treesitter/nvim-treesitter/issues/7735)) — репо переехал с master на main. Парсер не включён в дефолтный список. Если очень нужен — `:TSInstall gitignore` руками, может сработать.

---

## Обновление

```bash
cd ~/.config/nvim
git pull
nvim
```
Внутри nvim:
```vim
:Lazy sync
:MasonToolsUpdate
:TSUpdate
```

---

## Кастомизация

Вся настройка через файлы в `lua/plugins/` и `lua/config/`. Каждый файл — один плагин с собственным набором опций.

Добавить свой плагин — создать `lua/plugins/my_plugin.lua`:
```lua
return {
  "owner/plugin",
  event = "BufReadPre",
  opts = { ... },
}
```
Lazy.nvim автоматически подхватит при следующем запуске.

---

## Лицензия

MIT
