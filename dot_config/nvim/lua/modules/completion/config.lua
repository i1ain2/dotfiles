local config = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()

function config.nvim_lsp()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.enable({
    'rust_analyzer',
    'pylsp'
  })

  -- lsp configuration
  vim.lsp.config('*', {
    capabilities = capabilities,
  })

  vim.lsp.config('clangd', {
    capabilities = capabilities,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })
end

function config.conform()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })
end

function config.nvim_lint()
  require("lint").linters_by_ft = {
    javascript = { "eslint_d", "cspell" },
    typescript = { "eslint_d", "cspell" },
    javascriptreact = { "eslint_d", "cspell" },
    typescriptreact = { "eslint_d", "cspell" },
    jsx = { "eslint_d", "cspell" },
    tsx = { "eslint_d", "cspell" },
    json = { "eslint_d", "cspell" },
    lua = { "cspell" },
  }
end

function config.lspsaga()
  local lspsaga = require("lspsaga")
  lspsaga.setup({
    ui = {
      code_action = "󰌵",
    },
  })
end

function config.nvim_cmp()
  local cmp = require("cmp")

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({}),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "buffer" },
    }),
  })

  -- Completions for search based on current buffer
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Completions for command line
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

return config
