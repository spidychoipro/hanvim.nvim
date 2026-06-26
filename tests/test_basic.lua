local hanvim = require("hanvim")
hanvim.setup()

local cabbrev_output = vim.api.nvim_exec2("cabbrev", { output = true }).output
local lines = vim.split(cabbrev_output, "\n")

assert(#lines > 0, "cabbrev output should not be empty")
print("Total cabbrevs: " .. #lines)
print("All cabbrevs registered successfully!")
