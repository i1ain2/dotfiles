local package = require('core.pack').package
local config = require('modules.ui.config')

-- color theme
package({
  'folke/tokyonight.nvim',
  lazy = false,
  config = config.tokyonight,
})

-- colorize indent
package({
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
})

-- color highlighter
package({
  'catgoose/nvim-colorizer.lua',
  lazy = false,
  opts = {}
})

-- winbar
local version_info = vim.version()
if version_info.major == 0 and version_info.minor >= 10 then
  -- IDE-like breadcrumbs
  package({
    'Bekaboo/dropbar.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    lazy = false
  })
else
  -- tabline plugin
  package({
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    lazy = false
  })
end

-- emphasize the curren  window
package({
  "nvim-zh/colorful-winsep.nvim",
  lazy = false,
  opts = {}
})

-- notification system
package({
  'rcarriga/nvim-notify',
  lazy = false,
  config = function()
    local notify = require('notify')
    notify.setup({
      stages = 'fade_in_slide_out',
      timeout = 1500,
      render = 'compact',
      top_down = false,
    })
    vim.notify = function(msg, level, opts)
      opts = opts or {}
      if level == vim.log.levels.ERROR then
        opts.timeout = false
      end
      notify(msg, level, opts)
    end
  end,
})
