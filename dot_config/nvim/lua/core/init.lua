local helper = require("core.helper")

require("core.options")
require("core.pack"):boot_strap()
require("keymap")

-- additional command

-- remove trailing whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- lint on save
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- 例) .eslint.jsonが存在しない場合にeslintを実行するとエラーになる
    require("lint").try_lint(ni, { ignore_errors = true })
  end,
})

-- Auto reload when file changed externally (for Claude Code etc.)
local agent_group = vim.api.nvim_create_augroup("AgentAutoRead", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = agent_group,
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShell", {
  group = agent_group,
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Reloaded.", vim.log.levels.INFO)
  end,
})
