local M = {}
M.enabled = true

local defaults = {
    저장 = "w",
    종료 = "q",
    전부저장 = "wqa",
    저장종료 = "wq",
    강제종료 = "q!",
    강제저장종료 = "wq!",
    전체저장 = "wa",
    새파일 = "new",
    수정 = "e",
    세로분할 = "vsplit",
    가로분할 = "split",
    탭새파일 = "tabnew",
    도움말 = "help",
    취소 = "u",
    다시실행 = "red",
    줄번호 = "set nu",
    상대번호 = "set rnu",
    줄번호끄기 = "set nonu",
    모두선택 = "%y",
    버퍼목록 = "ls",
    버퍼삭제 = "bd",
    다음버퍼 = "bn",
    이전버퍼 = "bp",
    탭목록 = "tabs",
    다음탭 = "tabn",
    이전탭 = "tabp",
    찾기 = "/",
    바꾸기 = "%s",
    설정 = "set",
    실행 = "!",
    터미널 = "term",
    검사 = "checkhealth",
    변경사항 = "undotree",
    북마크 = "marks",
    파일찾기 = "Telescope find_files",
    텍스트찾기 = "Telescope live_grep",
    포맷 = "lua vim.lsp.buf.format()",
    실행파일 = "!%:p",
    저장실행 = "w | !%:p",
}

local function build_sorted_aliases(aliases)
    local sorted = {}
    for korean, english in pairs(aliases) do
        table.insert(sorted, { korean = korean, english = english, len = #korean })
    end
    table.sort(sorted, function(a, b) return a.len > b.len end)
    return sorted
end

local function expand_alias(line, sorted_aliases)
    for _, alias in ipairs(sorted_aliases) do
        local byte_len = alias.len
        if #line >= byte_len then
            local prefix = line:sub(1, byte_len)
            if prefix == alias.korean then
                local rest = line:sub(byte_len + 1)
                if rest == '' or rest:match('^[%s%p]') then
                    return alias.english, rest, #alias.english
                end
            end
        end
    end
    return nil
end

vim.api.nvim_create_user_command("HanvimToggle", function()
    M.enabled = not M.enabled
    vim.g.hanvim_enabled = M.enabled
    local status = M.enabled and "ON" or "OFF"
    vim.notify("Hanvim " .. status, vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command("HanvimList", function()
    local aliases = M.aliases or {}
    local lines = { "", " Hanvim Aliases", "" }
    for korean, english in pairs(aliases) do
        table.insert(lines, string.format("  :%s  ->  :%s", korean, english))
    end
    table.insert(lines, "")
    table.insert(lines, " Hanvim: " .. (M.enabled and "ON" or "OFF"))

    local width = 60
    local height = #lines + 2
    local ui = vim.api.nvim_list_uis()[1] or {}
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = math.min(height, 20),
        row = math.floor(((ui.height or 20) - math.min(height, 20)) / 2),
        col = math.floor(((ui.width or 80) - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " Hanvim ",
        title_pos = "center",
    })
    vim.wo[win].winhl = "Normal:NormalFloat,FloatBorder:FloatBorder"
end, {})

M.setup = function(opts)
    opts = opts or {}
    M.aliases = vim.tbl_deep_extend("force", {}, defaults, opts.aliases or {})
    M.enabled = opts.enabled ~= false
    vim.g.hanvim_enabled = M.enabled

    local sorted_aliases = build_sorted_aliases(M.aliases)
    local group = vim.api.nvim_create_augroup("Hanvim", { clear = true })
    local processing = false

    if opts.toggle_key then
        vim.keymap.set("n", opts.toggle_key, ":HanvimToggle<CR>",
            { noremap = true, silent = true, desc = "Toggle Hanvim" })
    end

    vim.api.nvim_create_autocmd("CmdlineChanged", {
        group = group,
        callback = function()
            if processing or not M.enabled then
                return
            end

            local cmdtype = vim.fn.getcmdtype()
            if cmdtype ~= ':' then
                return
            end

            local line = vim.fn.getcmdline()
            if line == '' then
                return
            end

            local expanded, rest, english_len = expand_alias(line, sorted_aliases)
            if not expanded then
                return
            end

            processing = true
            pcall(vim.fn.setcmdline, expanded)
            vim.fn.setcmdpos(english_len + 1)
            processing = false
        end,
    })
end

return M
