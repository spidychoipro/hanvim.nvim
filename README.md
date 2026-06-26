<div align="center">

# hanvim.nvim

**한글 명령어로 Neovim을 제어하세요**

[![Neovim](https://img.shields.io/badge/Neovim-0.7+-green.svg?style=flat-square&logo=neovim)](https://neovim.io)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)

</div>

---

## 📦 Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim) (추천)

```lua
-- 로컬 플러그인
{
    dir = "~/path/to/hanvim.nvim",
    opts = {
        toggle_key = "<F12>",
    },
}
```

```lua
-- GitHub (추후)
-- { "spidychoipro/hanvim.nvim", opts = {} }
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
    "~/path/to/hanvim.nvim",
    config = function()
        require("hanvim").setup({ toggle_key = "<F12>" })
    end,
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug '~/path/to/hanvim.nvim'
lua require("hanvim").setup({ toggle_key = "<F12>" })
```

> **⚠️ 주의:** lazy.nvim 환경에서만 테스트되었습니다.  
> 다른 플러그인 매니저에서도 정상 동작해야 하지만, 완전한 호환성을 보장하지는 않습니다.

---

## 🚀 Usage

`:` 명령줄에서 한글을 입력하면 영어 명령으로 확장됩니다.

```
:저장<CR>        → :w
:종료!<CR>       → :q!
:저장 hello.lua  → :w hello.lua
:포맷<CR>        → :lua vim.lsp.buf.format()
:파일찾기<CR>    → :Telescope find_files
:실행파일<CR>    → :!%:p
```

| Built-in command | Description |
|---|---|
| `:HanvimToggle` | ON/OFF 전환 |
| `:HanvimList` | 등록된 약어 목록을 플로팅 창으로 표시 |

<kbd>F12</kbd> 키로 빠르게 ON/OFF를 전환할 수 있습니다.  
`setup({ toggle_key = nil })`로 키를 설정하지 않으면 매핑되지 않습니다.

---

## ⚙️ Configuration

### Default setup

```lua
require("hanvim").setup()
```

### Full options

```lua
require("hanvim").setup({
    enabled = true,              -- 최초 활성화 여부
    toggle_key = "<F12>",        -- ON/OFF 전환 키 (nil = 매핑 안 함)
    aliases = {                  -- 기본 약어 오버라이드 / 추가
        문서열기 = "e doc/",
        탭닫기 = "tabclose",
    },
})
```

`aliases`에 같은 키를 넣으면 기본값을 덮어씁니다.  
없는 키를 넣으면 새 약어로 추가됩니다.

---

## 📋 Aliases

### 편집

| Input | Expands to | Description |
|---|---|---|
| `저장` | `w` | 저장 |
| `종료` | `q` | 종료 |
| `전부저장` | `wqa` | 전체 저장 후 종료 |
| `저장종료` | `wq` | 저장 후 종료 |
| `강제종료` | `q!` | 강제 종료 |
| `강제저장종료` | `wq!` | 강제 저장 후 종료 |
| `전체저장` | `wa` | 모든 버퍼 저장 |
| `저장실행` | `w \| !%:p` | 저장 후 실행 |
| `취소` | `u` | 실행 취소 |
| `다시실행` | `red` | 다시 실행 |
| `모두선택` | `%y` | 전체 복사 |

### 파일 / 버퍼

| Input | Expands to | Description |
|---|---|---|
| `새파일` | `new` | 새 파일 |
| `수정` | `e` | 파일 열기 |
| `버퍼목록` | `ls` | 버퍼 목록 |
| `버퍼삭제` | `bd` | 버퍼 삭제 |
| `다음버퍼` | `bn` | 다음 버퍼 |
| `이전버퍼` | `bp` | 이전 버퍼 |
| `실행파일` | `!%:p` | 현재 파일 실행 |

### 창 / 탭

| Input | Expands to | Description |
|---|---|---|
| `세로분할` | `vsplit` | 세로 분할 |
| `가로분할` | `split` | 가로 분할 |
| `탭새파일` | `tabnew` | 새 탭 |
| `탭목록` | `tabs` | 탭 목록 |
| `다음탭` | `tabn` | 다음 탭 |
| `이전탭` | `tabp` | 이전 탭 |

### 검색 / 치환

| Input | Expands to | Description |
|---|---|---|
| `찾기` | `/` | 전방 검색 |
| `바꾸기` | `%s` | 문자열 치환 |

### 옵션 / 도구

| Input | Expands to | Description |
|---|---|---|
| `줄번호` | `set nu` | 줄번호 켜기 |
| `상대번호` | `set rnu` | 상대 줄번호 켜기 |
| `줄번호끄기` | `set nonu` | 줄번호 끄기 |
| `설정` | `set` | 옵션 설정 |
| `도움말` | `help` | 도움말 |
| `터미널` | `term` | 터미널 열기 |
| `검사` | `checkhealth` | 헬스 체크 |
| `변경사항` | `undotree` | 변경 이력 |
| `북마크` | `marks` | 북마크 목록 |

### LSP / 플러그인

| Input | Expands to | Description |
|---|---|---|
| `포맷` | `lua vim.lsp.buf.format()` | LSP 포맷 |
| `파일찾기` | `Telescope find_files` | Telescope 파일 찾기 |
| `텍스트찾기` | `Telescope live_grep` | Telescope 텍스트 검색 |
| `실행` | `!` | 셸 명령 실행 |

---

## 🔧 Integration

### lualine

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

---

## 🧠 How it works

`:` 명령줄에서만 한글을 영어 명령으로 확장합니다 (`cabbrev <expr>` + `getcmdtype() == ':'` 조건).  
검색(`/`, `?`) 모드에서는 확장되지 않습니다.

활성화 상태는 `g:hanvim_enabled` Vim 변수로 관리되며,  
`:HanvimToggle` 또는 `<F12>`로 즉시 전환할 수 있습니다.

---

## 📄 License

MIT
