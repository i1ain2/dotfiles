local package = require('core.pack').package

package({
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
})

package({
  'numToStr/Comment.nvim',
  lazy = false,
  opts = {}
})

package({
  'stevearc/quicker.nvim',
  ft = 'qf',
  keys = {
    { '<C-q>o', function() require('quicker').toggle() end, desc = 'Toggle quickfix' },
    { '<C-q>l', function() require('quicker').toggle({ loclist = true }) end, desc = 'Toggle loclist' },
  },
  opts = {
    keys = {
      { '>', function() require('quicker').expand({ before = 2, after = 2, add_to_existing = true }) end, desc = 'Expand quickfix context' },
      { '<', function() require('quicker').collapse() end, desc = 'Collapse quickfix context' },
    },
  },
})

