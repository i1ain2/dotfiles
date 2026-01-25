local package = require("core.pack").package
local config = require("modules.completion.config")

-- You need to install LSP server manually
package({
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = config.nvim_lsp,
})

package({
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = config.lspsaga,
})

package({
  "stevearc/conform.nvim",
  event = "InsertEnter",
  config = config.conform,
})

package({
  "mfussenegger/nvim-lint",
  lazy = false,
  config = config.nvim_lint,
})

package({
  "hrsh7th/nvim-cmp",
  lazy = false,
  config = config.nvim_cmp,
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },
  },
})

package({
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {}
})

package({
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {}
})

package({
  "folke/trouble.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
})

