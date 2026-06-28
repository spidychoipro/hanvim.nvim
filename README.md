<p align="center">
  <h1 align="center">hanvim.nvim</h1>
  <p align="center">
    한국어 명령어로 Neovim을 제어하세요.
    <br>
    <code>:저장</code> → <code>:w</code> &nbsp;·&nbsp; <code>:종료</code> → <code>:q</code> &nbsp;·&nbsp; <code>:포맷</code> → <code>vim.lsp.buf.format()</code>
    <br>
    <code>:파일찾기</code> → <code>:Telescope find_files</code> &nbsp;·&nbsp; <code>:실행파일</code> → <code>:!%:p</code>
  </p>
  <p align="center">
    <a href="https://github.com/spidychoipro/hanvim.nvim/releases">
      <img alt="License" src="https://img.shields.io/github/license/spidychoipro/hanvim.nvim?style=for-the-badge&logo=github">
    </a>
    <a href="https://github.com/spidychoipro/hanvim.nvim">
      <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.7+-green?style=for-the-badge&logo=neovim">
    </a>
    <a href="https://github.com/spidychoipro/hanvim.nvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/spidychoipro/hanvim.nvim?style=for-the-badge&logo=github">
    </a>
  </p>
</p>

---

## 📦 Installation

<details>
<summary><b>lazy.nvim</b> (recommended)</summary>

```lua
{
    "spidychoipro/hanvim.nvim",
    opts = {
        toggle_key = "<F12>",
    },
}
```

</details>

<details>
<summary><b>packer.nvim</b></summary>

```lua
use {
    "spidychoipro/hanvim.nvim",
    config = function()
        require("hanvim").setup({ toggle_key = "<F12>" })
    end,
}
```

</details>

<details>
<summary><b>vim-plug</b></summary>

```vim
Plug 'spidychoipro/hanvim.nvim'

lua require("hanvim").setup({ toggle_key = "<F12>" })
```

</details>

> **Note:** Tested primarily with lazy.nvim. Other package managers should work, but full compatibility is not guaranteed.

---

## 🚀 Usage

Start typing a Korean command in Neovim's command-line:

```
:저장<CR>         → :w
:저장!<CR>        → :w!
:저장 hello.lua   → :w hello.lua
:종료<CR>         → :q
:종료!<CR>        → :q!
:포맷<CR>         → :lua vim.lsp.buf.format()
:파일찾기<CR>      → :Telescope find_files
:실행파일<CR>      → :!%:p
```

### Commands

| Command | Description |
|---------|-------------|
| `:HanvimToggle` | Enable / disable expansion |
| `:HanvimList` | Show all registered aliases in a floating window |

Pressing <kbd>q</kbd> or <kbd>Esc</kbd> closes the floating window.

---

## ⚙️ Configuration

### Minimal

```lua
require("hanvim").setup()
```

### Full

```lua
require("hanvim").setup({
    -- Start with expansion enabled (default: true)
    enabled = true,

    -- Key to toggle expansion on/off (nil = no mapping)
    toggle_key = "<F12>",

    -- Override or extend default aliases
    aliases = {
        -- Override an existing alias
        종료 = "q!",
        -- Add a new alias
        문서열기 = "e doc/",
    },
})
```

---

## 📋 Aliases

| Category | Input | Expands to |
|----------|-------|------------|
| **편집** | `저장` | `w` |
| | `종료` | `q` |
| | `전부저장` | `wqa` |
| | `저장종료` | `wq` |
| | `강제종료` | `q!` |
| | `강제저장종료` | `wq!` |
| | `전체저장` | `wa` |
| | `저장실행` | `w \| !%:p` |
| | `취소` | `u` |
| | `다시실행` | `red` |
| | `모두선택` | `%y` |
| | `포맷` | `lua vim.lsp.buf.format()` |
| **파일 / 버퍼** | `수정` | `e` |
| | `새파일` | `new` |
| | `실행파일` | `!%:p` |
| | `버퍼목록` | `ls` |
| | `버퍼삭제` | `bd` |
| | `다음버퍼` | `bn` |
| | `이전버퍼` | `bp` |
| **창 / 탭** | `세로분할` | `vsplit` |
| | `가로분할` | `split` |
| | `탭새파일` | `tabnew` |
| | `탭목록` | `tabs` |
| | `다음탭` | `tabn` |
| | `이전탭` | `tabp` |
| **검색 / 치환** | `찾기` | `/` |
| | `바꾸기` | `%s` |
| **옵션 / 도구** | `줄번호` | `set nu` |
| | `상대번호` | `set rnu` |
| | `줄번호끄기` | `set nonu` |
| | `설정` | `set` |
| | `도움말` | `help` |
| | `터미널` | `term` |
| | `검사` | `checkhealth` |
| | `변경사항` | `undotree` |
| | `북마크` | `marks` |
| **기타** | `실행` | `!` |
| | `파일찾기` | `Telescope find_files` |
| | `텍스트찾기` | `Telescope live_grep` |

---

## 🔧 Integration

### lualine

Show Hanvim status in your statusline:

```lua
require("lualine").setup({
    sections = {
        lualine_x = {
            {
                function()
                    return require("hanvim").enabled and "한글" or ""
                end,
                color = { fg = "#bd93f9" },
            },
        },
    },
})
```

### which-key

Show aliases with which-key (add a group under a prefix):

```lua
require("which-key").add({
    { "<leader>h", group = "Hanvim" },
    { "<leader>ht", "<cmd>HanvimToggle<CR>", desc = "Toggle" },
    { "<leader>hl", "<cmd>HanvimList<CR>", desc = "List aliases" },
})
```

---

## 🧠 How it works

hanvim.nvim hooks into `CmdlineChanged` to detect Korean commands as you type in `:` mode. When a match is found, it replaces the Korean text with the corresponding English command in real-time.

- ✅ **Only expands in `:` mode** — safe during search (`/`, `?`)
- ✅ **Respects `!` bang** — `:종료!` becomes `:q!`
- ✅ **Passes arguments** — `:저장 hello.lua` becomes `:w hello.lua`
- ✅ **Longest match wins** — `:전부저장` matches before `:저장`
- ✅ **Toggle on/off** — disable expansion when typing Korean for other purposes
- ✅ **Zero external dependencies**

---

## 📄 License

[MIT](LICENSE)
