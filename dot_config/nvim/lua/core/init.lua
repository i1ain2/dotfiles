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
