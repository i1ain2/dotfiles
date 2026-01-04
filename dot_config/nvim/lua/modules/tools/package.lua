local package = require("core.pack").package
local config = require("modules.tools.config")

-- fuzzy finder
package({
  "nvim-telescope/telescope.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
      preview = {
        -- fix https://github.com/nvim-telescope/telescope.nvim/issues/3487#issuecomment-3047102892
        treesitter = false,
      }
    }
  }
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
  opts = {}
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
  "echasnovski/mini.files",
  lazy = false,
  opts = {}
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
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = false,
  config = function()
    require("neoclip").setup({
      keys = {
        telescope = {
          -- デフォルトだとc-pなので、選択とかぶるため
          i = {
            paste = "<cr>",
          },
          n = {
            paste = "<cr>",
          },
        },
      },
    })
    require("telescope").load_extension("neoclip")
  end,
})
