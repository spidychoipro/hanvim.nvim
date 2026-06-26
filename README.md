# hanvim.nvim

한글 명령어로 Neovim을 제어하세요.  
`:` 명령줄에서 한글을 입력하면 영어 명령으로 자동 확장됩니다.

---

## Features

- `:` 명령줄에서만 동작 (검색 `/` `?` 모드에서는 확장되지 않음)
- 39개 기본 한글 명령어 제공 (저장, 종료, 파일찾기, 포맷 등)
- `:HanvimToggle` 명령어 / `<F12>` 키로 ON/OFF 전환 가능
- `:HanvimList` 명령어로 등록된 약어 전체를 플로팅 창으로 확인
- `setup({ aliases = { ... } })`으로 커스텀 약어 추가/오버라이드 가능
- 인자 전달, bang(`!`) 지원 — `:저장!` → `:w!`

---

## Requirements

- Neovim >= 0.7.0
- `vim.loader` (recommended)

---

## Installation

### lazy.nvim (추천)

```lua
-- 로컬 플러그인으로 추가
{
    dir = "C:/Users/swpar/plugin/hanvim.nvim",
}

-- 또는 git clone 후
{
    dir = "~/path/to/hanvim.nvim",
}
```

기본 설정으로 로드:

```lua
require("hanvim").setup()
```

옵션 포함:

```lua
require("hanvim").setup({
    toggle_key = "<F12>",
    aliases = {
        내맵 = "echo hello",
    },
})
```

### packer.nvim

```lua
use {
    "~/path/to/hanvim.nvim",
    config = function()
        require("hanvim").setup()
    end,
}
```

### vim-plug

```vim
Plug '~/path/to/hanvim.nvim'

" init.lua / init.vim 에서
lua require("hanvim").setup()
```

> **참고:** lazy.nvim 환경에서만 테스트되었습니다.  
> packer.nvim과 vim-plug에서도 정상 동작해야 하지만,  
> 다른 플러그인 매니저와의 완전한 호환성은 보장되지 않습니다.  
> 문제 발생 시 이슈를 남겨주세요.

---

## Commands

| 명령어 | 설명 |
|--------|------|
| `:HanvimToggle` | Hanvim ON/OFF 전환 |
| `:HanvimList` | 등록된 약어 목록을 플로팅 창으로 표시 |

---

## Aliases

| 한글 | 확장 | 설명 |
|------|------|------|
| `저장` | `w` | 저장 |
| `종료` | `q` | 종료 |
| `전부저장` | `wqa` | 전체 저장 후 종료 |
| `저장종료` | `wq` | 저장 후 종료 |
| `강제종료` | `q!` | 강제 종료 |
| `강제저장종료` | `wq!` | 강제 저장 후 종료 |
| `전체저장` | `wa` | 모든 버퍼 저장 |
| `새파일` | `new` | 새 파일 |
| `수정` | `e` | 파일 수정 |
| `세로분할` | `vsplit` | 세로 분할 |
| `가로분할` | `split` | 가로 분할 |
| `탭새파일` | `tabnew` | 새 탭 |
| `도움말` | `help` | 도움말 |
| `취소` | `u` | 실행 취소 |
| `다시실행` | `red` | 다시 실행 |
| `줄번호` | `set nu` | 줄번호 켜기 |
| `상대번호` | `set rnu` | 상대 줄번호 켜기 |
| `줄번호끄기` | `set nonu` | 줄번호 끄기 |
| `모두선택` | `%y` | 전체 선택 (복사) |
| `버퍼목록` | `ls` | 버퍼 목록 |
| `버퍼삭제` | `bd` | 버퍼 삭제 |
| `다음버퍼` | `bn` | 다음 버퍼 |
| `이전버퍼` | `bp` | 이전 버퍼 |
| `탭목록` | `tabs` | 탭 목록 |
| `다음탭` | `tabn` | 다음 탭 |
| `이전탭` | `tabp` | 이전 탭 |
| `찾기` | `/` | 검색 모드 |
| `바꾸기` | `%s` | 문자열 치환 |
| `설정` | `set` | 옵션 설정 |
| `실행` | `!` | 셸 명령 실행 |
| `터미널` | `term` | 터미널 열기 |
| `검사` | `checkhealth` | 헬스 체크 |
| `변경사항` | `undotree` | 변경 이력 |
| `북마크` | `marks` | 북마크 목록 |
| `파일찾기` | `Telescope find_files` | Telescope 파일 찾기 |
| `텍스트찾기` | `Telescope live_grep` | Telescope 텍스트 검색 |
| `포맷` | `lua vim.lsp.buf.format()` | LSP 포맷 |
| `실행파일` | `!%:p` | 현재 파일 실행 |
| `저장실행` | `w \| !%:p` | 저장 후 실행 |

---

## Configuration

```lua
require("hanvim").setup({
    -- 최초 활성화 여부 (기본값: true)
    enabled = true,

    -- 토글 키 (기본값: nil, 설정 안 하면 매핑 안 됨)
    toggle_key = "<F12>",

    -- 기본 약어 덮어쓰기 또는 추가
    aliases = {
        -- 기본값 덮어쓰기
        종료 = "q!",
        -- 새 약어 추가
        문서수정 = "e doc/",
    },
})
```

### lualine 연동 (직접 설정)

```lua
require("lualine").setup({
    sections = {
        lualine_x = {
            {
                function()
                    return require("hanvim").enabled and "한글 ON" or "한글 OFF"
                end,
            },
        },
    },
})
```

---

## How it works

`cabbrev <expr>`을 사용하여 `:` 명령줄에서만 한글을 영어 명령으로 확장합니다.  
`getcmdtype() == ':'` 조건으로 검색 모드에서의 의도치 않은 확장을 방지합니다.

---

## TODO

- [ ] 자동 완성 지원
- [ ] lualine 공식 연동
- [ ] Telescope 익스텐션

---

## License

MIT
