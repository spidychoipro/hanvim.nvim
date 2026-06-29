<p align="center">
  <h1 align="center">hanvim.nvim</h1>
  <p align="center">
    <code>:저장</code> → <code>:w</code> · <code>:종료</code> → <code>:q</code>
  </p>
  <p align="center">
    <a href="https://github.com/spidychoipro/hanvim.nvim/releases">
      <img alt="License" src="https://img.shields.io/github/license/spidychoipro/hanvim.nvim?style=for-the-badge&logo=github">
    </a>
    <a href="https://github.com/spidychoipro/hanvim.nvim">
      <img alt="Neovim" src="https://img.shields.io/badge/Neovim-0.7+-green?style=for-the-badge&logo=neovim">
    </a>
  </p>
  <p align="center">
    <a href="#-english">English</a> · <a href="#-한국어">한국어</a>
  </p>
</p>

---

## 🇰🇷 한국어

Neovim 명령줄에서 한글로 명령어를 입력하세요.

```
:저장<CR>       → :w
:종료!<CR>      → :q!
:저장 파일     → :w 파일
:포맷<CR>      → :lua vim.lsp.buf.format()
:파일찾기<CR>  → :Telescope find_files
```

### 명령어

| 명령어 | 설명 |
|--------|------|
| `:HanvimToggle` | 한글 명령어 ON/OFF 전환 |
| `:HanvimList` | 등록된 약어 목록을 플로팅 창으로 표시 |

<kbd>q</kbd> 또는 <kbd>Esc</kbd>로 창을 닫습니다.

### 설치

<details>
<summary><b>lazy.nvim</b> (추천)</summary>

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

> **참고:** lazy.nvim 환경에서 테스트되었습니다. 다른 패키지 매니저도 정상 동작해야 하지만, 완전한 호환성을 보장하지는 않습니다.

### 설정

```lua
require("hanvim").setup({
    enabled = true,              -- 최초 활성화 여부
    toggle_key = "<F12>",        -- ON/OFF 전환 키 (nil = 매핑 안 함)
    aliases = {                  -- 기본 약어 덮어쓰기 / 추가
        문서열기 = "e doc/",
    },
})
```

### 약어 목록

#### 편집

| 입력 | 확장 |
|------|------|
| `저장` | `w` |
| `종료` | `q` |
| `전부저장` | `wqa` |
| `저장종료` | `wq` |
| `강제종료` | `q!` |
| `강제저장종료` | `wq!` |
| `전체저장` | `wa` |
| `저장실행` | `w \| !%:p` |
| `취소` | `u` |
| `다시실행` | `red` |
| `모두선택` | `%y` |
| `포맷` | `lua vim.lsp.buf.format()` |

#### 파일 / 버퍼

| 입력 | 확장 |
|------|------|
| `수정` | `e` |
| `새파일` | `new` |
| `실행파일` | `!%:p` |
| `버퍼목록` | `ls` |
| `버퍼삭제` | `bd` |
| `다음버퍼` | `bn` |
| `이전버퍼` | `bp` |

#### 창 / 탭

| 입력 | 확장 |
|------|------|
| `세로분할` | `vsplit` |
| `가로분할` | `split` |
| `탭새파일` | `tabnew` |
| `탭목록` | `tabs` |
| `다음탭` | `tabn` |
| `이전탭` | `tabp` |

#### 검색 / 치환

| 입력 | 확장 |
|------|------|
| `찾기` | `/` |
| `바꾸기` | `%s` |

#### 옵션 / 도구

| 입력 | 확장 |
|------|------|
| `줄번호` | `set nu` |
| `상대번호` | `set rnu` |
| `줄번호끄기` | `set nonu` |
| `설정` | `set` |
| `도움말` | `help` |
| `터미널` | `term` |
| `검사` | `checkhealth` |
| `변경사항` | `undotree` |
| `북마크` | `marks` |

#### 기타

| 입력 | 확장 |
|------|------|
| `실행` | `!` |
| `파일찾기` | `Telescope find_files` |
| `텍스트찾기` | `Telescope live_grep` |

### 연동

#### lualine

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

#### which-key

```lua
require("which-key").add({
    { "<leader>h", group = "Hanvim" },
    { "<leader>ht", "<cmd>HanvimToggle<CR>", desc = "ON/OFF" },
    { "<leader>hl", "<cmd>HanvimList<CR>", desc = "약어 목록" },
})
```

---

## 🇬🇧 English

Type Korean commands in Neovim's command-line and watch them expand.

```
:저장<CR>       → :w
:종료!<CR>      → :q!
:저장 file     → :w file
:포맷<CR>      → :lua vim.lsp.buf.format()
:파일찾기<CR>  → :Telescope find_files
```

### Commands

| Command | Description |
|---------|-------------|
| `:HanvimToggle` | Enable / disable expansion |
| `:HanvimList` | Show all aliases in a floating window |

Press <kbd>q</kbd> or <kbd>Esc</kbd> to close the window.

### Installation

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

### Configuration

```lua
require("hanvim").setup({
    enabled = true,
    toggle_key = "<F12>",
    aliases = {
        종료 = "q!",
    },
})
```

### Aliases

See the [Korean section](#-한국어) for the full alias list.

### Integration

#### lualine

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

#### which-key

```lua
require("which-key").add({
    { "<leader>h", group = "Hanvim" },
    { "<leader>ht", "<cmd>HanvimToggle<CR>", desc = "Toggle" },
    { "<leader>hl", "<cmd>HanvimList<CR>", desc = "List aliases" },
})
```

### How it works

hanvim.nvim hooks into `CmdlineChanged` to detect Korean commands as you type in `:` mode. When a match is found, it replaces the Korean text with the corresponding English command in real-time.

- ✅ **Only expands in `:` mode** — safe during search (`/`, `?`)
- ✅ **Respects `!` bang** — `:종료!` becomes `:q!`
- ✅ **Passes arguments** — `:저장 hello.lua` becomes `:w hello.lua`
- ✅ **Longest match wins** — `:전부저장` matches before `:저장`
- ✅ **Toggle on/off** — disable when typing Korean for other purposes
- ✅ **Zero external dependencies**

---

## 📄 License

MIT
