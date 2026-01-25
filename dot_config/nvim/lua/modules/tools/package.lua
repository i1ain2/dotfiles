local package = require("core.pack").package
local config = require("modules.tools.config")

-- fuzzy finder
package({
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "^%.git/" },
    },
  },
})

-- git decorations
package({
  "lewis6991/gitsigns.nvim",
  lazy = false,
  opts = {}
})

package({
  "sindrets/diffview.nvim",
  lazy = false,
  config = function()
    require("diffview").setup({
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
        },
      },
    })
  end,
})

-- help
package({
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {}
})

-- greeter
package({
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = config.alpha,
})

package({
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = "actions.close",
    },
  },
})

-- floating terminal
package({
  "numToStr/FTerm.nvim",
  lazy = false,
  opts = {}
})

-- yank
package({
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "kkharji/sqlite.lua", -- 永続化に必要
  },
  lazy = false,
  config = function()
    require("neoclip").setup({
      default_register = "+", -- clipboard=unnamedplusに合わせる
      enable_persistent_history = true,
    })
    require("telescope").load_extension("neoclip")
  end,
})
